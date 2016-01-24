//
//  TBConst.m
//  airplane
//
//  Created by qianjianeng on 16/1/24.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBConst.h"

@implementation TBConst

+ (void)saveScore:(NSString *)score
{
    [[NSUserDefaults standardUserDefaults] setObject:score forKey:@"gameScore"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)score
{
     return [[NSUserDefaults standardUserDefaults] objectForKey:@"gameScore"];
}
@end
