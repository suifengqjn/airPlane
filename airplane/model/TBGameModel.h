//
//  TBGameModel.h
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TBhero.h"
#import "TBEnemy.h"
#import "TBEnemyView.h"
#import <UIKit/UIKit.h>
@interface TBGameModel : NSObject

#pragma mark - 游戏区域
@property (assign, nonatomic) CGRect gameArea;

#pragma mark - 游戏得分
@property (assign, nonatomic) NSInteger score;


#pragma mark - 英雄的属性及方法
@property (strong, nonatomic) TBhero *hero;

#pragma mark - 创建敌机
// 敌机跟子弹是有区别的，子弹是一次发射三颗，而敌机每次只有一个
// 因此定义一个方法，返回敌机的模型即可


+ (id)gameModelWithArea:(CGRect)gameArea heroSize:(CGSize)heroSize;
#pragma mark - 创建敌机
// 敌机跟子弹是有区别的，子弹是一次发射三颗，而敌机每次只有一个
// 因此定义一个方法，返回敌机的模型即可
- (TBEnemy *)createEnemyWithType:(TBEnemyType)type size:(CGSize)size;

@end
