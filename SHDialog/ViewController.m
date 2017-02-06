//
//  ViewController.m
//  SHDialog
//
//  Created by zhangshuijie on 2017/2/4.
//  Copyright © 2017年 zhangshuijie. All rights reserved.
//

#import "ViewController.h"
#import "DialogViewController.h"
#import <Masonry.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [[UIButton alloc] init];
    [self.view addSubview:btn];
    [btn setTitle:@"dialog" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Image_bg"]];
    [self.view addSubview:image];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(80);
        make.height.equalTo(@40);
        make.width.equalTo(@60);
    }];
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@250);
        make.top.equalTo(btn.mas_bottom).offset(50);
        make.centerX.equalTo(self.view);
    }];
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)click:(id)sender {
    DialogViewController *dialog = [[DialogViewController alloc] init];
    dialog.modalPresentationStyle = UIModalPresentationOverFullScreen;
    self.definesPresentationContext = YES;
    [self presentViewController:dialog animated:NO completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
