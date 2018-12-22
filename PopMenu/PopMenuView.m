//
//  PopMenuView.m
//  PopMenu
//
//  Created by wangluting on 16/9/7.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import "PopMenuView.h"

#define radius (int)[UIScreen mainScreen].bounds.size.width * 0.65 / 2
#define Height [UIScreen mainScreen].bounds.size.height
#define Width  [UIScreen mainScreen].bounds.size.width

@implementation PopMenuView {
    NSMutableArray *_itemArray;
    NSMutableArray *_snapArray;
    UIDynamicAnimator *_dynaimcAnimatr;
    UICollisionBehavior *_collisionBehavoir;
    NSMutableArray *_expendPointArray;
    NSMutableArray *_unexpendPointArray;
    BOOL _isexpend;
    PopAction _action;
}

- (instancetype)init {
    if (self=[super init]) {
        _snapArray=[NSMutableArray new];
        _expendPointArray=[NSMutableArray new];
        _unexpendPointArray=[NSMutableArray new];
        _itemArray=[NSMutableArray new];
    }
    return self;
}

- (instancetype)initWithMainImage:(UIImage *)mainImage {
    if((self = [self init]) && mainImage){
        self.layer.contents=(__bridge id)mainImage.CGImage;
        self.layer.contentsGravity=kCAGravityResizeAspectFill;
        self.frame = CGRectMake(0, 0, mainImage.size.width, mainImage.size.height);
    }
    return self;
}

- (void)addAttachImage:(UIImage *)image action:(PopAction)action {
    if(!image)  return ;
    
    UIView *attachView=[[UIView alloc]init];
    attachView.layer.contentsGravity = kCAGravityResizeAspectFill;
    attachView.layer.contents = (__bridge id)image.CGImage;
    [_itemArray addObject:attachView];
    attachView.tag = [_itemArray count];
    _action=action;
    [attachView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(_panHandle:)]];
    [attachView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(_action:)]];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    [super willMoveToSuperview:newSuperview];
    _dynaimcAnimatr= [[UIDynamicAnimator alloc] initWithReferenceView:newSuperview];
    _expendPointArray= [self _calculateLocation];
    [_itemArray enumerateObjectsUsingBlock:^(UIView * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.frame = self.frame;
        [newSuperview addSubview:obj];
        [self->_unexpendPointArray addObject:NSStringFromCGPoint(self.center)];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_dynaimcAnimatr removeBehavior:_collisionBehavoir];
    [self _expend:_isexpend];
    _isexpend=!_isexpend;
}

- (void)_panHandle:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            [_dynaimcAnimatr removeBehavior:_collisionBehavoir];
            [self _removeAllSnapBehavoir];
             break;
        }
        case UIGestureRecognizerStateChanged:
            sender.view.center=[sender locationInView:self.superview];
            break;
        case UIGestureRecognizerStateEnded : {
            _collisionBehavoir=[[UICollisionBehavior alloc]initWithItems:_itemArray];
            [_dynaimcAnimatr addBehavior:_collisionBehavoir];
            [self _addAllSnapBehavoirWithPointArray:_expendPointArray];
            break;
        }
        default:
            break;
    }
}

- (void)_action:(UITapGestureRecognizer *)sender {
    [self _expend:YES];
    if(_action) _action(self,sender.view.tag);
}

//默认mainMenu在底部中间
- (NSMutableArray *)_calculateLocation {
    NSInteger count = [_itemArray count];
    CGPoint loction ;
    for (NSInteger i=1;count>=i ; i++) {
        CGFloat locationHeight = Height-self.frame.size.height/2- radius *sin(M_PI/(count+1) *i);
        if (count/2>i) {
            loction =  CGPointMake(Width/2- radius *cos(M_PI/(count+1) *i),locationHeight);
        }else{
            loction =  CGPointMake(Width/2+radius *cos(M_PI/(count+1) *i),locationHeight);
        }
        [_expendPointArray addObject:NSStringFromCGPoint(loction)];
    }
    return _expendPointArray;
}

- (void)_expend:(BOOL)isExpend {
    [self _removeAllSnapBehavoir];
    if(isExpend) {
        [self _addAllSnapBehavoirWithPointArray:_unexpendPointArray];
        return ;
    }
    [self _addAllSnapBehavoirWithPointArray:_expendPointArray];
}

- (void)_addAllSnapBehavoirWithPointArray:(NSArray * )pointArray {
    [_itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UISnapBehavior *snapBehavior=[[UISnapBehavior alloc]initWithItem:obj snapToPoint:CGPointFromString(pointArray[idx]) ];
        [self->_dynaimcAnimatr addBehavior:snapBehavior];
        [self->_snapArray addObject:snapBehavior];
    }];
}

- (void)_removeAllSnapBehavoir {
    if([_snapArray count] < 1)  return ;
    
    [_snapArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [self->_dynaimcAnimatr removeBehavior:obj];
    }];
}

@end
