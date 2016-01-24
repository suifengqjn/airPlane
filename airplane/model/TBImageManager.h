//
//  TBImageManager.h
//  airplane
//
//  Created by qianjianeng on 16/1/19.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TBImageManager : NSObject

+ (instancetype)shareManager;

#pragma mark 暂停按钮
//暂停按钮普通
@property (nonatomic, strong) UIImage *pauseImage;
//暂停按钮普通高亮
@property (nonatomic, strong) UIImage *pauseHLImage;
#pragma mark 开始按钮
//开始按钮普通
@property (nonatomic, strong) UIImage *startImage;
//开始按钮普通高亮
@property (nonatomic, strong) UIImage *startHLImage;

#pragma mark 背景图片
@property (strong, nonatomic) UIImage *bgImage;
#pragma mark logo图片
@property (strong, nonatomic) UIImage *logoImage;
#pragma mark 英雄图片
// 飞行数组
@property (strong, nonatomic) NSArray *heroFlyImages;
// 爆炸数组
@property (strong, nonatomic) NSArray *heroBlowupImages;

#pragma mark 子弹图片
// 普通子弹
@property (strong, nonatomic) UIImage *bullteNormalImage;
// 加强子弹
@property (strong, nonatomic) UIImage *bullteEnhancedImage;

#pragma mark 敌机图片
// 小飞机飞行图像
@property (strong, nonatomic) UIImage *enemySmallImage;
// 小飞机爆炸数组
@property (strong, nonatomic) NSArray *enemySmallBlowupImages;
// 中飞机飞行图像
@property (strong, nonatomic) UIImage *enemyMiddleImage;
// 中飞机爆炸数组
@property (strong, nonatomic) NSArray *enemyMiddleBlowupImages;
// 中飞机挨揍图像
@property (strong, nonatomic) UIImage *enemyMiddleHitImage;
// 大飞机飞行数组
@property (strong, nonatomic) NSArray *enemyBigImages;
// 大飞机爆炸数组
@property (strong, nonatomic) NSArray *enemyBigBlowupImages;
// 大飞机挨揍图像
@property (strong, nonatomic) UIImage *enemyBigHitImage;


@end
