//
//  TBBullet.h
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TBBullet : NSObject

//  由英雄调用（循环三次），直接给定子弹位置，和是否增强(选用第二种方法)
+ (id)bulletWithPosition:(CGPoint)positon isEnhanced:(BOOL)isEnhanced;

// 位置
@property (assign, nonatomic) CGPoint position;

// 伤害值
@property (assign, nonatomic) NSInteger damage;

// 是否是增强子弹（主要用于界面显示时使用哪一张图片）
@property (assign, nonatomic) BOOL isEnhanced;

@end
