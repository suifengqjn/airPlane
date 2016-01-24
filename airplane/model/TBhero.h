//
//  TBhero.h
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TBhero : NSObject

#pragma mark 中心点位置
@property (nonatomic, assign) CGPoint position;

@property (nonatomic, assign, readonly) CGRect collisionFrame;
//飞机的大小
@property (nonatomic, assign) CGSize size;
// 子弹是否增强
@property (assign, nonatomic) BOOL isEnhancedBullte;
// 子弹增强时间
@property (assign, nonatomic) NSInteger enhancedTime;
//发射子弹集合
@property (strong, nonatomic) NSMutableSet *bullteSet;
//炸弹数量
@property (assign, nonatomic) NSInteger bulletCount;
#pragma mark 子弹辅助属性
// 普通子弹尺寸
@property (assign, nonatomic) CGSize bullteNormalSize;
// 加强子弹尺寸
@property (assign, nonatomic) CGSize bullteEnhancedSize;

//是否死亡
@property (nonatomic, assign) BOOL isDead;

+ (instancetype)heroWithSize:(CGSize)heroSize gameAera:(CGRect)gameAera;
- (void)fire;
@end
