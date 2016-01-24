//
//  TBGameModel.m
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "TBGameModel.h"

@implementation TBGameModel
+ (id)gameModelWithArea:(CGRect)gameArea heroSize:(CGSize)heroSize
{
    TBGameModel *m = [[TBGameModel alloc]init];
    
    m.gameArea = gameArea;

    
    // 实例化英雄，英雄是独一无二的，可以针对该对象，对工厂方法进行扩展
    m.hero = [TBhero heroWithSize:heroSize gameAera:gameArea];
    
    // 默认得分为0
    m.score = 0;
    
    return m;
}
- (TBEnemy *)createEnemyWithType:(TBEnemyType)type size:(CGSize)size
{
    return [TBEnemy enemyWithType:type size:size gameArea:self.gameArea];
}

@end
