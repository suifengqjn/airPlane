//
//  TBBullet.m
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBBullet.h"

#define kDamageNormal       1
#define kDamageEnhanced     2

@implementation TBBullet

+ (id)bulletWithPosition:(CGPoint)positon isEnhanced:(BOOL)isEnhanced
{
    TBBullet *bu = [[TBBullet alloc]init];
    bu.position = positon;
    bu.isEnhanced = isEnhanced;
    bu.damage = isEnhanced ? kDamageEnhanced : kDamageNormal;
    
    
    return bu;
}
@end
