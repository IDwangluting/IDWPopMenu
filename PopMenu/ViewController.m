//
//  ViewController.m
//  PopMenu
//
//  Created by wangluting on 16/9/7.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import "ViewController.h"
#import "PopMenuView.h"

#define  ScreenHeight (int)[UIScreen mainScreen].bounds.size.height
#define ScreenWiidth  (int)[UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, ScreenWiidth, 50)];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];

    self.view.backgroundColor=[UIColor grayColor];
    

    PopMenuView *popMenu=[[PopMenuView alloc]initWithMainImage:[UIImage imageNamed:@"start"] size:CGSizeMake(50, 50)];
    
    [popMenu addAttachImage:[UIImage imageNamed:@"icon-email"] action:^(PopMenuView *popView, NSInteger tag) {
        label.text=[NSString stringWithFormat:@"选中了第%li个",tag];
    }];
    [popMenu addAttachImage:[UIImage imageNamed:@"icon-facebook"] action:^(PopMenuView *popView, NSInteger tag) {
        label.text=[NSString stringWithFormat:@"选中了第%li个",tag];
    }];
    [popMenu addAttachImage:[UIImage imageNamed:@"icon-twitter"] action:^(PopMenuView *popView, NSInteger tag) {
        label.text=[NSString stringWithFormat:@"选中了第%li个",tag];
    }];
    popMenu.center=CGPointMake(ScreenWiidth/2, ScreenHeight-30);
    [self.view addSubview:popMenu];
}

-(BOOL)shouldAutorotate {
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
