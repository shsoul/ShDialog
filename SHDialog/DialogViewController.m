//
//  DialogViewController.m
//  SHDialog
//
//  Created by zhangshuijie on 2017/2/4.
//  Copyright © 2017年 zhangshuijie. All rights reserved.
//

#import "DialogViewController.h"
#import <Masonry.h>

@interface DialogViewController ()

@property(nonatomic, strong) UIView *contentView;
@property(nonatomic, strong) UILabel *dialogTitle;
@property(nonatomic, strong) UIView *customView;
@property(nonatomic, strong) UIButton *sure;
@property(nonatomic, strong) UIVisualEffectView *effectView;

@end

@implementation DialogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45];
    _contentView = [[UIView alloc] init];
    _contentView.layer.cornerRadius = 12;
    _contentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    _contentView.transform = CGAffineTransformMakeScale(2, 2);
    _contentView.alpha = 0;
    [self.view addSubview:_contentView];
    
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    _effectView.layer.cornerRadius = 12;
    _effectView.clipsToBounds = YES;
    [self.contentView addSubview:_effectView];
    
    [_effectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_contentView);
    }];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@270);
        make.center.equalTo(self.view);
        make.height.mas_lessThanOrEqualTo(290).priorityLow();
    }];
    
    _dialogTitle = [[UILabel alloc] init];
    _dialogTitle.text = @"this is title!";
    _dialogTitle.textAlignment = NSTextAlignmentCenter;
    [_contentView addSubview:_dialogTitle];
    
    _customView = [[UIView alloc] init];
    _customView.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:_customView];
    
    UILabel *tips = [[UILabel alloc] init];
    [_customView addSubview:tips];
    tips.textAlignment = NSTextAlignmentCenter;
    tips.text = @"this is customView!";
    [tips mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_customView);
    }];
    
    _sure = [[UIButton alloc] init];
    [_sure setTitle:@"确定" forState:UIControlStateNormal];
    [_sure setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [_sure addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_sure];
    
    [_dialogTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_contentView).offset(15);
        make.right.equalTo(_contentView).offset(-15);
        make.top.equalTo(_contentView).offset(10);
        make.height.greaterThanOrEqualTo(@20);
    }];
    
    [_customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentView);
        make.top.equalTo(_dialogTitle.mas_bottom);
        make.bottom.equalTo(_sure.mas_top);
        make.height.equalTo(@100);
    }];
    
    [_sure mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentView);
        make.bottom.equalTo(_contentView);
        make.height.equalTo(@45);
    }];
}

- (void)click:(id)sender {
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self show];
}

- (void)show {
    CGFloat dTime = 0.35;
    [UIView animateWithDuration:dTime animations:^{
        self.contentView.alpha = 1;
    }];
    
    [UIView animateWithDuration:dTime delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:10 options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.contentView.transform = CGAffineTransformMakeScale(1, 1);
    } completion:^(BOOL finished) {
        [self animateDidCompletion];
    }];
}
- (void)animateDidCompletion {
    UIBezierPath *cPath = [UIBezierPath bezierPathWithRoundedRect:self.contentView.frame cornerRadius:12];
    UIBezierPath *wPath = [UIBezierPath bezierPathWithRect:self.view.bounds];
    [wPath appendPath:cPath];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    [self.view.layer addSublayer:maskLayer];
    maskLayer.path = wPath.CGPath;
    maskLayer.fillRule = kCAFillRuleEvenOdd;
    self.view.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:0.5];
    maskLayer.fillColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.45].CGColor;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
