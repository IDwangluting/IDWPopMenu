//
//  PopMenuView.m
//  PopMenu
//
//  Created by wangluting on 16/9/7.
//  Copyright © 2016年 wangluting. All rights reserved.
//

#import "PopMenuView.h"

#define radius (int)[UIScreen mainScreen].bounds.size.width * 0.65 / 2
//#define radius 30
#define Height [UIScreen mainScreen].bounds.size.height
#define Width   [UIScreen mainScreen].bounds.size.width

@implementation PopMenuView {
    NSMutableArray *_itemArray;
    NSMutableArray *_snapArray;
    UIDynamicAnimator *_dynaimcAnimatr;
    UICollisionBehavior *_collisionBehavoir;
    NSMutableArray *_expendPointArray;
    NSMutableArray *_unexpendPointArray;
    BOOL _isexpend;
}

- (instancetype)init {
    if (self=[super init]) {
        _attachMenuItemSize=CGSizeMake(44,44);
        self.frame=CGRectMake(0, 0, 44, 44);
        _snapArray=[NSMutableArray new];
        _expendPointArray=[NSMutableArray new];
        _unexpendPointArray=[NSMutableArray new];
        _itemArray=[NSMutableArray new];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self =[super initWithFrame:frame]) {
        
    }
    return self;
}

- (instancetype)initWithMainImage:(UIImage *)mainImage size:(CGSize)size {
    self =[self init];
    if(mainImage==nil)
        self.backgroundColor=[UIColor redColor];
    else{
        self.layer.contents=(__bridge id)mainImage.CGImage;
        self.layer.contentsGravity=kCAGravityResizeAspectFill;
    }
    if (!CGSizeEqualToSize(CGSizeZero, size)) {
        self.frame=CGRectMake(0, 0, size.width, size.height);
    }
    return self;
}

-(void)addAttachImage:(UIImage *)image action:(Action)action {
    if(!image)  return ;
    
    UIView *attachView=[[UIView alloc]initWithFrame:CGRectMake(0, 0,_attachMenuItemSize.width , _attachMenuItemSize.height)];
    attachView.center=self.center;
    attachView.layer.contentsGravity=kCAGravityResizeAspectFill;
    attachView.layer.contents=(__bridge id)image.CGImage;
    [_itemArray addObject:attachView];
    attachView.tag=[_itemArray count];
    _action=action;
    [attachView addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(__panHandle:)]];
    [attachView addGestureRecognizer: [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__action:)]];
}

- (void)willMoveToSuperview:(UIView *)newSuperview {
    _dynaimcAnimatr= [[UIDynamicAnimator alloc] initWithReferenceView:newSuperview];
    _expendPointArray= [self __calculateLocation];
    [_itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [newSuperview addSubview:obj];
        [_unexpendPointArray addObject:NSStringFromCGPoint(self.center)];
    }];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [_dynaimcAnimatr removeBehavior:_collisionBehavoir];
    [self __expend:_isexpend];
    _isexpend=!_isexpend;
}

-(void)__panHandle:(UIPanGestureRecognizer *)sender {
    switch (sender.state) {
        case UIGestureRecognizerStateBegan: {
            [_dynaimcAnimatr removeBehavior:_collisionBehavoir];
            [self __removeAllSnapBehavoir];
             break;
        }
        case UIGestureRecognizerStateChanged:
            sender.view.center=[sender locationInView:self.superview];
            break;
        case UIGestureRecognizerStateEnded : {
            _collisionBehavoir=[[UICollisionBehavior alloc]initWithItems:_itemArray];
            [_dynaimcAnimatr addBehavior:_collisionBehavoir];
            [self __addAllSnapBehavoirWithPointArray:_expendPointArray];
            break;
        }
        default:
            break;
    }
}

- (void)__action:(UITapGestureRecognizer *)sender {
    [self __expend:YES];
    if(_action)
        _action(self,sender.view.tag);
}

//默认mainMenu在底部中间
-(NSMutableArray *)__calculateLocation {
    NSInteger count = [_itemArray count];
    CGPoint loction ;
    for (NSInteger i=1;count>=i ; i++) {
        CGFloat locationHeight = Height-_attachMenuItemSize.height/2- radius *sin(M_PI/(count+1) *i);
        if (count/2>i) {
            loction =  CGPointMake(Width/2- radius *cos(M_PI/(count+1) *i),locationHeight);
        }else{
            loction =  CGPointMake(Width/2+radius *cos(M_PI/(count+1) *i),locationHeight);
        }
        [_expendPointArray addObject:NSStringFromCGPoint(loction)];
    }
    return _expendPointArray;
}

-(void)__expend:(BOOL)isExpend {
    [self __removeAllSnapBehavoir];
    if(isExpend) {
        [self __addAllSnapBehavoirWithPointArray:_unexpendPointArray];
        return ;
    }
    [self __addAllSnapBehavoirWithPointArray:_expendPointArray];
}

-(void)__addAllSnapBehavoirWithPointArray:(NSArray * )pointArray {
    [_itemArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        UISnapBehavior *snapBehavior=[[UISnapBehavior alloc]initWithItem:obj snapToPoint:CGPointFromString(pointArray[idx]) ];
        [_dynaimcAnimatr addBehavior:snapBehavior];
        [_snapArray addObject:snapBehavior];
    }];
}

-(void)__removeAllSnapBehavoir {
    if([_snapArray count] < 1)  return ;
    
    [_snapArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [_dynaimcAnimatr removeBehavior:obj];
    }];
}
@end
