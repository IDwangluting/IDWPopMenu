//
//  PopMenuView.h
//  PopMenu
//
//  Created by wangluting on 16/9/7.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PopMenuView;

typedef void(^PopAction)(PopMenuView *popView,NSInteger tag );

@interface PopMenuView : UIView

- (instancetype)initWithMainImage:(UIImage *)mainImage;

- (void)addAttachImage:(UIImage *)image action:(PopAction)action;

@end
