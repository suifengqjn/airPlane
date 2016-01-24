//
//  TBLogoView.m
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBLogoView.h"

@implementation TBLogoView

- (instancetype)initWithImage:(UIImage *)image
{
    self = [super initWithImage:image];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFit;
    }
    return self;
}

@end
