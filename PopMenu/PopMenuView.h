//
//  PopMenuView.h
//  PopMenu
//
//  Created by wangluting on 16/9/7.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopMenuView;

typedef void(^Action)(PopMenuView *popView,NSInteger tag );

@interface PopMenuView : UIView

@property(nonatomic,copy)Action action;

@property(nonatomic,assign)CGSize mainMenuItemSize;
@property(nonatomic,assign)CGSize attachMenuItemSize;

-(instancetype)initWithMainImage:(UIImage *)mainImage size:(CGSize) size;

-(void)addAttachImage:(UIImage *)image action:(Action)action;

@end
