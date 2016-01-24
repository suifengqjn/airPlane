//
//  TBEnemyView.m
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBEnemyView.h"
#import "TBEnemy.h"
#import "TBMusicTool.h"
@implementation TBEnemyView

- (id)initWithEnemy:(TBEnemy *)enemy imageManager:(TBImageManager *)imageManger
{
    self = [super init];
    
    if (self) {
        self.enemy = enemy;
        // 根据敌机类型设置敌机的相关图像
        switch (enemy.type) {
            case kEnemySmall:
                // 图像
                self.image = imageManger.enemySmallImage;
                // 爆炸图像
                self.blowupImages = imageManger.enemySmallBlowupImages;
                [[TBMusicTool shareManager] playSoundWithType:kTBMusicEnemySmallDown];
                break;
            case kEnemyMiddle:
                // 图像
                self.image = imageManger.enemyMiddleImage;
                // 爆炸
                self.blowupImages = imageManger.enemyMiddleBlowupImages;
                // 挨揍
                self.hitImage = imageManger.enemyMiddleHitImage;
                [[TBMusicTool shareManager] playSoundWithType:kTBMusicEnemyMiddleDown];
                break;
            case kEnemyBig:
                // 图像
                self.image = imageManger.enemyBigImages[0];
                // 因为大飞机有多张图片，需要播放序列帧动画
                self.animationImages = imageManger.enemyBigImages;
                self.animationDuration = 0.5f;
                // 播放序列帧动画
                [self startAnimating];
                
                // 爆炸
                self.blowupImages = imageManger.enemyBigBlowupImages;
                // 挨揍
                self.hitImage = imageManger.enemyBigHitImage;
                [[TBMusicTool shareManager] playSoundWithType:kTBMusicEnemyBigDown];
                
                break;
        }
        
        // 设定图像视图的frame和center
        [self setFrame:CGRectMake(0, 0, self.image.size.width, self.image.size.height)];
        [self setCenter:enemy.position];
    }
    
    return self;
}

@end
