//
//  TBGamePlayViewController.m
//  airplane
//
//  Created by qianjianeng on 16/1/19.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBGamePlayViewController.h"
#import "UIView+Extension.h"
#import "TBImageManager.h"
#import "TBMusicTool.h"
#import "TBBackGroundView.h"
#import "TBConst.h"
#import "TBBullet.h"
#import "TBGameModel.h"
#import "TBHeroView.h"
#import "TBBulletView.h"
#import "TBEnemy.h"
#import "TBEnemyView.h"
static long steps;

@interface TBGamePlayViewController ()

// 游戏时钟
@property (strong, nonatomic) CADisplayLink    *gameTimer;
//游戏资源
@property (nonatomic, strong) TBImageManager   *imageManager;
@property (nonatomic, strong) TBMusicTool      *musicTool;
//游戏背景图
@property (nonatomic, strong) TBBackGroundView *backGroundView;

@property (nonatomic, strong) TBGameModel      *gameModel;
// 游戏视图
@property (strong, nonatomic) UIView           *gameView;
//暂停按钮
@property (strong, nonatomic) UIButton         *button;
//游戏得分
@property (nonatomic, strong) UILabel          *scoreLabel;
// 英雄战机视图
@property (strong, nonatomic) TBHeroView       *heroView;

// 子弹视图集合，记录屏幕中所有的子弹视图
@property (strong, nonatomic) NSMutableSet     *bulletViewSet;

// 敌机集合，记录屏幕中所有飞机的视图
@property (strong, nonatomic) NSMutableSet     *enemyViewSet;
@end

@implementation TBGamePlayViewController
- (void)viewWillLayoutSubviews
{
    self.view.bounds = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    steps = 0;
    [self loadBackImage];
    // 实例化集合
    self.bulletViewSet = [NSMutableSet set];
    self.enemyViewSet = [NSMutableSet set];
    
    CGSize heroSize = [self.imageManager.heroFlyImages[0] size];
    self.gameModel = [TBGameModel gameModelWithArea:self.view.bounds heroSize:heroSize];
    [self.gameModel.hero setBullteNormalSize:[self.imageManager.bullteNormalImage size]];
    [self.gameModel.hero setBullteEnhancedSize:[self.imageManager.bullteEnhancedImage size]];
    
    
    //游戏视图
    self.gameView = [[UIView alloc] initWithFrame:self.gameModel.gameArea];
    [self.view addSubview:self.gameView];
    
    
    //暂停按钮
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.button setImage:self.imageManager.pauseImage forState:UIControlStateNormal];
    [self.button setImage:self.imageManager.pauseHLImage forState:UIControlStateHighlighted];
    self.button.frame = CGRectMake(20, 20, self.imageManager.pauseImage.size.width, self.imageManager.pauseImage.size.height);
    [self.button addTarget:self action:@selector(pauseGame) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.button];
    //游戏得分
    self.scoreLabel = [[UILabel alloc] init];
    self.scoreLabel.textAlignment = NSTextAlignmentLeft;
    self.scoreLabel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    self.scoreLabel.frame = CGRectMake(CGRectGetMaxX(self.button.frame) + 15, CGRectGetMinY(self.button.frame), 150, CGRectGetHeight(self.button.frame));
    [self.view addSubview:self.scoreLabel];
    
    //英雄视图
    self.heroView = [[TBHeroView alloc] initWithImages:self.imageManager.heroFlyImages];
    [self.heroView setCenter:self.gameModel.hero.position];
    [self.gameView addSubview:self.heroView];
    
    [self.musicTool backMusicPlay];
    [NSThread sleepForTimeInterval:1.0];
    [self startGameTimer];
}

#pragma mark - 游戏暂停开始
- (void)pauseGame
{
   self.button.tag = !self.button.tag;
    if (self.button.tag) {
        [self.button setImage:self.imageManager.startImage forState:UIControlStateNormal];
        [self.button setImage:self.imageManager.startHLImage forState:UIControlStateHighlighted];
        [self stopGameTimer];
    } else {
        [self.button setImage:self.imageManager.pauseImage forState:UIControlStateNormal];
        [self.button setImage:self.imageManager.pauseHLImage forState:UIControlStateHighlighted];
        [self startGameTimer];
    }
    
}

#pragma mark 更新游戏分数
- (void)updateScorel
{
    if (self.gameModel.score == 0) {
        self.scoreLabel.text = @"";
    } else {
        self.scoreLabel.text = [NSString stringWithFormat:@"%ld", (long)self.gameModel.score * 100];;
    }
}
- (void)gameStep
{
    steps ++;
    
    //更新英雄位置
    self.heroView.center = self.gameModel.hero.position;
    
    if (steps % 20 == 0) {
        [self.gameModel.hero fire];
        [self.musicTool playSoundWithType:kTBMusicBullet];
    }
    
    // 每次时钟触发，都需要检查更新屏幕上所有子弹的位置
    [self checkBullets];
    
    
    //敌机创建
    [self createEnemys];
    
    //更新敌机位置
    [self updateEnemyPosition];
    
    //碰撞检测
    [self checkCollision];
}
#pragma mark - 英雄移动
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [touch locationInView:self.gameView];
    
    CGPoint previousLocation = [touch previousLocationInView:self.gameView];
    
    CGPoint offSet = CGPointMake(location.x - previousLocation.x, location.y - previousLocation.y);
    
    CGPoint prePosition = self.gameModel.hero.position;
    
    CGPoint nowPosition = CGPointMake(prePosition.x + offSet.x, prePosition.y + offSet.y);
    //控制英雄视图在游戏区域内
    if (nowPosition.x < 0) {
        nowPosition.x = 0;
    }
    if (nowPosition.x > self.gameModel.gameArea.size.width) {
        nowPosition.x = self.gameModel.gameArea.size.width;
    }
    if (nowPosition.y < self.gameModel.hero.size.height / 2) {
        nowPosition.y = self.gameModel.hero.size.height / 2;
    }
    if (nowPosition.y > self.gameModel.gameArea.size.height - self.gameModel.hero.size.height / 2) {
        nowPosition.y = self.gameModel.gameArea.size.height - self.gameModel.hero.size.height / 2;
    }
    self.gameModel.hero.position = nowPosition;
}

#pragma mark - 检查子弹
- (void)checkBullets
{
    NSMutableSet *needRemoveSet = [NSMutableSet set];
    
    for (TBBulletView *buview in self.bulletViewSet) {
        
        CGPoint position = CGPointMake(buview.center.x, buview.center.y - 8.0);
        [buview setCenter:position];
        //判断子弹是否飞出屏幕
        if (CGRectGetMaxY(buview.frame) < 0) {
            [needRemoveSet addObject:buview];
        }
        
    }
    // 遍历要删除的集合，清除飞出屏幕的子弹
    for (TBBulletView *bulletView in needRemoveSet) {
        // 从视图中删除
        [bulletView removeFromSuperview];
        // 从集合中删除
        [self.bulletViewSet removeObject:bulletView];
    }
    
    [needRemoveSet removeAllObjects];
    
    for (TBBullet *bullet in self.gameModel.hero.bullteSet) {
        
        UIImage *bulletImage = self.imageManager.bullteNormalImage;
        
        if (bullet.isEnhanced) {
            bulletImage = self.imageManager.bullteEnhancedImage;
        }
        TBBulletView *bulletView = [[TBBulletView alloc] initWithImage:bulletImage bullet:bullet];
        [bulletView setCenter:bullet.position];
        [self.gameView addSubview:bulletView];
        [self.bulletViewSet addObject:bulletView];
        
    }
    
    [self.gameModel.hero.bullteSet removeAllObjects];
  
}

#pragma  mark - 敌机
//创建敌机
- (void)createEnemys
{
    //敌机创建
    if (steps % 20 == 0) {
        // 1）创建模型
        TBEnemy *enemy = nil;
        
        if (steps % (5 * 60) == 0) {
            // 随机出现大飞机或者中飞机，先随机出来飞机的类型
            TBEnemyType type = (arc4random_uniform(2) == 0) ? kEnemyMiddle : kEnemyBig;
            
            CGSize size = self.imageManager.enemyMiddleImage.size;
            if (kEnemyBig == type) {
                size = [self.imageManager.enemyBigImages[0]size];
            }
            enemy = [self.gameModel createEnemyWithType:type size:size];
        } else {
            // 小飞机
            enemy = [self.gameModel createEnemyWithType:kEnemySmall size:self.imageManager.enemySmallImage.size];
            
        }
        
        // 2）根据模型创建飞机视图
        TBEnemyView *enemyView = [[TBEnemyView alloc] initWithEnemy:enemy imageManager:_imageManager];
        
        // 3) 将敌机视图添加到集合及视图
        [self.enemyViewSet addObject:enemyView];
        [self.gameView addSubview:enemyView];
    }
}
//更新敌机位置
- (void)updateEnemyPosition
{
    
    NSMutableSet *neetRemoveEnemySet = [NSMutableSet set];
    for (TBEnemyView *enView in self.enemyViewSet) {
        TBEnemy *en = enView.enemy;
        CGPoint position = CGPointMake(enView.center.x, enView.center.y + en.speed);
        [enView setCenter:position];
        if (CGRectGetMinY(enView.frame) > self.gameModel.gameArea.size.height) {
            [neetRemoveEnemySet addObject:enView];
        }
    }
    
    //删除超出屏幕的敌机
    for (TBEnemyView *enView in neetRemoveEnemySet) {
        [enView removeFromSuperview];
        [self.enemyViewSet removeObject:enView];
    }
    
    [neetRemoveEnemySet removeAllObjects];
}

#pragma mark - 碰撞检测
- (void)checkCollision
{
    if (steps % 10 == 0) {   //减慢动画播放速度
        NSMutableSet *removeEnemyViewSet = [NSMutableSet set];
        for (TBEnemyView *enemyView in self.enemyViewSet) {
            TBEnemy *enemy = enemyView.enemy;
            if (enemy.toBlowup) {
                [enemyView setImage:enemyView.blowupImages[enemy.blowupFrames++]];
               
            }
            if (enemy.blowupFrames == enemyView.blowupImages.count) {
                 [removeEnemyViewSet addObject:enemyView];
            }
        }
        
        //移除爆炸后的敌机
        for (TBEnemyView *enemyView in removeEnemyViewSet) {
            self.gameModel.score += enemyView.enemy.score;
            [self updateScorel];
            [enemyView removeFromSuperview];
            [self.enemyViewSet removeObject:enemyView];
        }
        
        [removeEnemyViewSet removeAllObjects];
        
    }
    
    
    
    
    
    //英雄子弹和敌机的碰撞
    for (TBBulletView *bulletView in self.bulletViewSet) {
        TBBullet *bullet = bulletView.bullet;
        for (TBEnemyView *enemyView in self.enemyViewSet) {
            TBEnemy *enemy = enemyView.enemy;
            
            //判断子弹和敌机是否相交 ,敌机处于爆炸中，或者英雄死亡 不做碰撞处理,
            if (CGRectIntersectsRect(bulletView.frame, enemyView.frame) && !enemy.toBlowup && !self.gameModel.hero.isDead) {
                //子弹的伤害值减去敌机的hp
                 enemy.hp -= bullet.damage;
                if (enemy.hp <= 0) {  //销毁飞机
                    enemy.toBlowup = YES;
                    
                } else {
                    
                    if (enemy.type == kEnemyBig) {  //大飞机先停止动画
                        [enemyView stopAnimating];
                    }
                    enemyView.image = enemyView.hitImage;
                }
            }
        }
    }
    
    //敌机和英雄的碰撞
    //英雄碰撞区域过大，太容易死亡
    for (TBEnemyView *enemyView in self.enemyViewSet) {
        
        //英雄死亡
        if (CGRectIntersectsRect(enemyView.frame, self.gameModel.hero.collisionFrame) && !enemyView.enemy.toBlowup) {
            [self.musicTool playSoundWithType:kTBMusicGameOver];
            
            [self gameOver];
            
            self.gameModel.hero.isDead = YES;
            
            [self.heroView stopAnimating];
            
            [self.heroView setImage:self.imageManager.heroBlowupImages[0]];
            
            [self.heroView setAnimationImages:self.imageManager.heroBlowupImages];
            
            [self.heroView setAnimationDuration:1.0];
            
            [self.heroView setAnimationRepeatCount:1];
            
            [self.heroView stopAnimating];
            
            [self performSelector:@selector(stopGameTimer) withObject:nil afterDelay:1.0];
        }
        break;
    }
    
    
}

- (void)gameOver
{

    NSInteger preScore = [[TBConst score] integerValue];
    if ([self.scoreLabel.text integerValue] > preScore) {
        [TBConst saveScore:[NSString stringWithFormat:@"%@", self.scoreLabel.text]];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"gameOverPojilu" object:nil userInfo:@{@"score":self.scoreLabel.text}];
    }
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"游戏结束" message:@"game over" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        [self.view removeFromSuperview];
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
}
#pragma mark - 加载背景图片
- (void)loadBackImage
{
    self.backGroundView = [[TBBackGroundView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.backGroundView];
}


#pragma mark - 加载资源
- (void)loadResources
{
    self.imageManager = [TBImageManager shareManager];
    self.musicTool    = [TBMusicTool shareManager];
    
}

#pragma mark 开始游戏时钟(每秒60次)
- (void)startGameTimer
{
    // 1) 实例化游戏时钟
    self.gameTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(gameStep)];
    // 2) 添加到主运行循环
    [self.gameTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
    [self.backGroundView startMove];
    [self.musicTool backMusicPlay];
}

#pragma mark 停止游戏时钟
- (void)stopGameTimer
{
    // 通过时钟来处理界面的变化，如果把时钟停止，游戏将停止
    [self.gameTimer invalidate];
    [self.backGroundView stopMove];
    [self.musicTool backMusicStop];
}
@end
