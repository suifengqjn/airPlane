//
//  TBBulletView.m
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBBulletView.h"
#import "TBBullet.h"

@implementation TBBulletView

- (id)initWithImage:(UIImage *)image bullet:(TBBullet *)bullet
{
    self = [super initWithImage:image];
    
    if (self) {
        self.bullet = bullet;
    }
    
    return self;
}
@end
