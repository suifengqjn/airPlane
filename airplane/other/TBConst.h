//
//  TBConst.h
//  airplane
//
//  Created by qianjianeng on 16/1/24.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kScreenHeight ([UIScreen mainScreen].bounds.size.height)
#define kScreenWidth ([UIScreen mainScreen].bounds.size.width)

@interface TBConst : NSObject

+ (void)saveScore:(NSString *)score;
+ (NSString *)score;

@end
