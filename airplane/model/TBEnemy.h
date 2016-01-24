//
//  TBEnemy.h
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TBEnemyType) {
    kEnemySmall = 0,
    kEnemyMiddle,
    kEnemyBig,
};

@interface TBEnemy : NSObject

@property (nonatomic, assign) TBEnemyType type;
@property (nonatomic, assign) CGPoint position;
//生命值
@property (nonatomic, assign) NSInteger hp;
//速度
@property (nonatomic, assign) NSInteger speed;
//得分
@property (nonatomic, assign) NSInteger score;
// 飞机爆炸标示，如果为真，标示飞机要爆炸，供碰撞检测使用
@property (assign, nonatomic) BOOL toBlowup;
// 爆炸动画已经播放的帧数
@property (assign, nonatomic) NSInteger blowupFrames;



+ (id)enemyWithType:(TBEnemyType)type size:(CGSize)size gameArea:(CGRect)gameArea;
@end
