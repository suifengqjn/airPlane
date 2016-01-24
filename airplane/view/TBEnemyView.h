//
//  TBEnemyView.h
//  airplane
//
//  Created by qianjianeng on 16/1/23.
//  Copyright © 2016年 SF. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBImageManager.h"
@class TBEnemy;
@interface TBEnemyView : UIImageView
@property (strong, nonatomic) NSArray *blowupImages;
// 挨揍图像
@property (strong, nonatomic) UIImage *hitImage;
// 敌机模型，便于后续的处理...
@property (strong, nonatomic) TBEnemy *enemy;

// 1. 敌机的大小不一致
// 2. 敌机有飞行的图像，或者数组
// 3. 敌机有挨揍图像
// 4. 有爆炸图像
// 综上所述：实例化方法传入Enemy对象，和ImageRes对象，可以简化参数传递
- (id)initWithEnemy:(TBEnemy *)enemy imageManager:(TBImageManager *)imageManger;
@end
