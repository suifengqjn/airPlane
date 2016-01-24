//
//  MainViewController.m
//  airplane
//
//  Created by qianjianeng on 16/1/19.
//  Copyright © 2016年 SF. All rights reserved.
//

#import "MainViewController.h"
#import "LoadingView.h"
#import "TBLogoView.h"
#import "TBImageManager.h"
#import "TBConst.h"
#import "TBGamePlayViewController.h"
#import "TBConst.h"
@interface MainViewController ()

@property (nonatomic, weak  ) LoadingView              *loadingView;
@property (nonatomic, strong  ) TBLogoView               *logoView;
@property (nonatomic, strong) TBGamePlayViewController *playVC;
@property (nonatomic, weak  ) UILabel              *scoreLabel;
@end

@implementation MainViewController
- (BOOL)prefersStatusBarHidden
{
    return YES;
}
- (void)viewWillLayoutSubviews
{
    self.view.bounds = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.view.backgroundColor = [UIColor whiteColor];
    LoadingView *load = [[LoadingView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:load];
    self.loadingView = load;
    [self performSelectorInBackground:@selector(buildLogoView) withObject:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateScore:) name:@"gameOverPojilu" object:nil];
    
}

- (void)updateScore:(NSNotification *)info
{
    NSDictionary *dic = info.userInfo;
    
    NSString *score = [dic valueForKey:@"score"];
    self.scoreLabel.text = [NSString stringWithFormat:@"历史最高分:   %@",score];

}
- (void)buildLogoView
{
    [NSThread sleepForTimeInterval:2.0];
    [self.loadingView removeFromSuperview];
    self.logoView = [[TBLogoView alloc] initWithImage:[TBImageManager shareManager].logoImage];
    self.logoView.frame = self.view.bounds;
    [self.view addSubview:self.logoView];

    [self buildScoreLabel];
    [self buildButton];
    
}

- (void)buildScoreLabel
{
    UILabel *testLabel = [[UILabel alloc] init];
    testLabel.frame = CGRectMake((kScreenWidth - 180)/2 , 100, 180, 40);
    
    testLabel.text = [NSString stringWithFormat:@"历史最高分:   %@",[[TBConst score] integerValue] <= 0 ? @(0) : [TBConst score]];
    testLabel.font = [UIFont fontWithName:@"Marker Felt" size:20];
    testLabel.textAlignment = NSTextAlignmentCenter;
    self.scoreLabel = testLabel;
    [self.view addSubview:testLabel];
}
- (void)buildButton
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.layer.cornerRadius = 20.0;
    button.layer.masksToBounds = YES;
    button.frame = CGRectMake((kScreenWidth - 140)/2 , kScreenHeight-150, 140, 40);
    [button setTitle:@"开始游戏" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor grayColor];
    button.titleLabel.font = [UIFont fontWithName:@"Marker Felt" size:25];
    [button addTarget:self action:@selector(gameBegin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
- (void)gameBegin
{
    self.playVC = [[TBGamePlayViewController alloc] init];
    [self.playVC loadResources];
    
    [self.view addSubview:self.playVC.view];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.scoreLabel.text = [NSString stringWithFormat:@"历史最高分:   %@",[TBConst score]];
}
@end
