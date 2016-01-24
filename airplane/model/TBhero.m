//
//  TBhero.m
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBhero.h"
#import "TBBullet.h"

#define kFireCount 2
@implementation TBhero

+ (instancetype)heroWithSize:(CGSize)heroSize gameAera:(CGRect)gameAera
{
    TBhero *hero = [[TBhero alloc] init];
    hero.position = CGPointMake(gameAera.size.width/2, gameAera.size.height-100);
    hero.size = heroSize;
    hero.isEnhancedBullte = NO;
    hero.enhancedTime = 0;
    hero.bulletCount = 0;
    hero.bullteSet = [NSMutableSet set];
    hero.isDead = NO;
    
    return hero;
}



#pragma mark - 发射子弹
// 发射子弹之前，需要指定bullteNormalSize 和 bullteEnhancedSize
- (void)fire
{
    // 循环发射子弹，意味着创建kFireCount个子弹的实例
    // 需要根据子弹是否加强，计算当前使用子弹的大小
    CGSize bullteSize = self.bullteNormalSize;
    if (self.isEnhancedBullte) {
        bullteSize = self.bullteEnhancedSize;
    }
    //计算第一课子弹的y坐标
    CGFloat y = self.position.y - self.size.height/2 - bullteSize.height/2;
    CGFloat x = self.position.x;
    
    for (NSInteger i = 0; i < kFireCount; i++) {
        CGPoint p = CGPointMake(x, y - i * bullteSize.height * 2);
        TBBullet *b = [TBBullet bulletWithPosition:p isEnhanced:self.isEnhancedBullte];
    [self.bullteSet addObject:b];
        
        
    }
}

//碰撞检测使用的frame
- (CGRect)collisionFrame
{
    CGFloat x = self.position.x - self.size.width / 4.0;
    CGFloat y = self.position.y - self.size.height / 2.0;
    CGFloat w = self.size.width / 2.0;
    CGFloat h = self.size.height;
    
    return CGRectMake(x, y, w, h);
    
}
@end
