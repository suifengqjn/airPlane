//
//  TBImageManager.m
//  airplane
//
//  Created by qianjianeng on 16/1/19.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBImageManager.h"

@implementation TBImageManager

+ (instancetype)shareManager
{
    static TBImageManager *_ImageManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _ImageManager = [[TBImageManager alloc] init];
    });
    return _ImageManager;
}

#pragma mark - 私有方法
#pragma mark 从指定bundle中加载图像
- (UIImage *)loadImageWithBundle:(NSBundle *)bundle imageName:(NSString *)imageName
{
    // 从images.bundle中加载指定文件名的图像
    NSString *path = [bundle pathForResource:imageName ofType:@"png"];
    
    return [UIImage imageWithContentsOfFile:path];
}

#pragma mark 从指定bundle中加载序列帧图像数组
// 参数：format 就是文件名的格式字符串
- (NSArray *)loadImagesWithBundle:(NSBundle *)bundle format:(NSString *)format count:(NSInteger)count
{
    NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:count];
    
    for (NSInteger i = 1; i <= count; i++) {
        NSString *imageName = [NSString stringWithFormat:format, i];
        
        UIImage *image = [self loadImageWithBundle:bundle imageName:imageName];
        
        [arrayM addObject:image];
    }
    
    return arrayM;
}

#pragma mark - 对象方法
- (id)init
{
    self = [super init];
    
    if (self) {
        // 加载图片资源，在游戏开发中，对于游戏视图中需要使用到图像资源，最好不要用缓存
        // 1. 实例化bundle
        // 1） 取出images.bundle的bundle路径
        NSString *bundlePath = [[[NSBundle mainBundle]bundlePath]stringByAppendingPathComponent:@"images.bundle"];
        // 2) 建立images.bundle的包
        NSBundle *bundle = [NSBundle bundleWithPath:bundlePath];
        
        // 2. 加载背景图片
        self.bgImage = [self loadImageWithBundle:bundle imageName:@"background_2"];
        
        self.logoImage = [self loadImageWithBundle:bundle imageName:@"BurstAircraftLogo"];
        // 3. 加载英雄飞行图片
        self.heroFlyImages = [self loadImagesWithBundle:bundle
                                                 format:@"hero_fly_%d"
                                                  count:2];
        self.heroBlowupImages = [self loadImagesWithBundle:bundle format:@"hero_blowup_%d" count:4];
        
        // 4. 子弹图片
        self.bullteNormalImage = [self loadImageWithBundle:bundle imageName:@"bullet1"];
        self.bullteEnhancedImage = [self loadImageWithBundle:bundle imageName:@"bullet2"];
        
        // 5. 小飞机
        self.enemySmallImage = [self loadImageWithBundle:bundle imageName:@"enemy1_fly_1"];
        self.enemySmallBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy1_blowup_%d" count:4];
        
        // 6. 中飞机
        self.enemyMiddleImage = [self loadImageWithBundle:bundle imageName:@"enemy3_fly_1"];
        self.enemyMiddleHitImage = [self loadImageWithBundle:bundle imageName:@"enemy3_hit_1"];
        self.enemyMiddleBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy3_blowup_%d" count:4];
        
        // 7. 大飞机
        self.enemyBigImages = [self loadImagesWithBundle:bundle format:@"enemy2_fly_%d" count:2];
        self.enemyBigHitImage = [self loadImageWithBundle:bundle imageName:@"enemy2_hit_1"];
        self.enemyBigBlowupImages = [self loadImagesWithBundle:bundle format:@"enemy2_blowup_%d" count:7];
        
        //按钮图片
        self.pauseImage = [self loadImageWithBundle:bundle imageName:@"BurstAircraftPause"];
        self.pauseHLImage = [self loadImageWithBundle:bundle imageName:@"BurstAircraftPauseHL"];
        self.startImage = [self loadImageWithBundle:bundle imageName:@"BurstAircraftStart"];
        self.startHLImage = [self loadImageWithBundle:bundle imageName:@"BurstAircraftStartHL"];
    }
    
    return self;
}


@end
