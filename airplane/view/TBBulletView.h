//
//  TBBulletView.h
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TBBullet;

@interface TBBulletView : UIImageView

@property(strong, nonatomic) TBBullet *bullet;

- (id)initWithImage:(UIImage *)image bullet:(TBBullet *)bullet;

@end
