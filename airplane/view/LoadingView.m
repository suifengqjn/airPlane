//
//  LoadingView.m
//  airplane
//
//  Created by qianjianeng on 16/1/19.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "LoadingView.h"

@implementation LoadingView

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1. 实例化四张图像
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:4];
        
        for (int i = 0; i < 4; i++) {
            NSString *imageName = [NSString stringWithFormat:@"images.bundle/loading%d.png", i];
            UIImage *image = [UIImage imageNamed:imageName];
            
            [arrayM addObject:image];
        }
        
        // 2. 建立UIImageView
        UIImageView *imageView = [[UIImageView alloc]initWithImage:arrayM[0]];
        
        // 3. 将UIImageView放置在屏幕中心位置
        [imageView setCenter:self.center];
        [self addSubview:imageView];
        
        // 4. 播放序列帧动画
        // 1) 设置序列帧动画数组
        [imageView setAnimationImages:arrayM];
        // 2) 设置序列帧动画时长，播放一遍使用的时间
        [imageView setAnimationDuration:1.0f];
        // 3) 开始动画
        [imageView startAnimating];
    }
    return self;
    
}

@end
