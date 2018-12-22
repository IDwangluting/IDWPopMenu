//
//  WWPopMenuView.h
//  PopMenu
//
//  Created by wangluting on 16/9/7.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WWPopMenuView;

typedef void(^PopAction)(WWPopMenuView *popView,NSInteger tag );

@interface WWPopMenuView : UIView

- (instancetype)initWithMainImage:(UIImage *)mainImage;

- (void)addAttachImage:(UIImage *)image action:(PopAction)action;

@end
