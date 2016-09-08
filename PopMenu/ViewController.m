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

@property(nonatomic,strong)UIView *dynamicView;

@property(nonatomic,strong)UIView *view1;
@property(nonatomic,strong)UIView *view2;

@property(nonatomic,strong)NSArray *viewArray;

@property(nonatomic,strong)UIDynamicAnimator *dynamicAnimator;
@property(nonatomic,strong)UISnapBehavior * snapBehavior;

@property(nonatomic,strong)UISnapBehavior *snapBehavior1;
@property(nonatomic,strong)UISnapBehavior *snapBehavior2;

@property(nonatomic,strong)UICollisionBehavior *collisionBehavior;

@property(nonatomic,strong)UILabel *lab;


@property(nonatomic,strong)UIGravityBehavior *gravityBehavior;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 50, ScreenWiidth, ScreenHeight)];
    label.textAlignment=NSTextAlignmentCenter;
    [self.view addSubview:label];

    self.view.backgroundColor=[UIColor grayColor];
    
    UIImage *image1=[UIImage imageNamed:@"icon-email"];
    UIImage *image2=[UIImage imageNamed:@"icon-facebook"];
    UIImage *image3=[UIImage imageNamed:@"icon-twitter"];
    UIImage *imagemain=[UIImage imageNamed:@"start"];


    PopMenuView *popMenu=[[PopMenuView alloc]initWithMainImage:imagemain size:CGSizeMake(50, 50)];
    
    popMenu.center=CGPointMake(ScreenWiidth/2, ScreenHeight-30);
    
    [popMenu addAttachImage:image1 action:^(PopMenuView *popView, NSInteger tag) {
        label.text=[NSString stringWithFormat:@"选中了第%li个",tag];
    }];
    [popMenu addAttachImage:image2 action:^(PopMenuView *popView, NSInteger tag) {
        label.text=[NSString stringWithFormat:@"选中了第%li个",tag];
    }];
    [popMenu addAttachImage:image3 action:^(PopMenuView *popView, NSInteger tag) {
        label.text=[NSString stringWithFormat:@"选中了第%li个",tag];
    }];
  
    [self.view addSubview:popMenu];

    
    
}



-(BOOL)shouldAutorotate
{
    return NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
