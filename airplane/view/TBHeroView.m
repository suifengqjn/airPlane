//
//  TBHeroView.m
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBHeroView.h"

@implementation TBHeroView

- (instancetype)initWithImages:(NSArray *)images
{
    self = [super initWithImage:images[0]];
    if (self) {
        
        // 设置序列帧动画
        [self setAnimationImages:images];
        // 设置播放时长
        [self setAnimationDuration:1.0];
        // 启动动画
        [self startAnimating];

    }
    return self;
}

@end
