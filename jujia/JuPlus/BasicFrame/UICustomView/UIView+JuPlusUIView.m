//
//  UIView+FurnHUIView.m
//  ImageTips
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UIView+JuPlusUIView.h"

@implementation UIView (JuPlusUIView)
- (CGFloat)left {
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)top {
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y {
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right {
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)screenX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
    }
    return x;
}

- (CGFloat)screenY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
    }
    return y;
}

- (CGFloat)screenViewX {
    CGFloat x = 0;
    for (UIView* view = self; view; view = view.superview) {
        x += view.left;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            x -= scrollView.contentOffset.x;
        }
    }
    
    return x;
}

- (CGFloat)screenViewY {
    CGFloat y = 0;
    for (UIView* view = self; view; view = view.superview) {
        y += view.top;
        
        if ([view isKindOfClass:[UIScrollView class]]) {
            UIScrollView* scrollView = (UIScrollView*)view;
            y -= scrollView.contentOffset.y;
        }
    }
    return y;
}

- (CGRect)screenFrame {
    return CGRectMake(self.screenViewX, self.screenViewY, self.width, self.height);
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}


- (void)removeAllSubviews
{
    while (self.subviews.count)
    {
        UIView* child = self.subviews.lastObject;
        [child removeFromSuperview];
    }
}

- (UIViewController *)viewController
{
    id nextResponder = [self nextResponder];
    if ( [nextResponder isKindOfClass:[UIViewController class]] )
    {
        return (UIViewController *)nextResponder;
    }
    else
    {
        return nil;
    }
}


- (void)setAnchorPoint:(CGPoint)anchorPoint {
    UIView *view = self;
    CGPoint newPoint = CGPointMake(view.bounds.size.width * anchorPoint.x, view.bounds.size.height * anchorPoint.y);
    CGPoint oldPoint = CGPointMake(view.bounds.size.width * view.layer.anchorPoint.x, view.bounds.size.height * view.layer.anchorPoint.y);
    
    newPoint = CGPointApplyAffineTransform(newPoint, view.transform);
    oldPoint = CGPointApplyAffineTransform(oldPoint, view.transform);
    
    CGPoint position = view.layer.position;
    
    position.x -= oldPoint.x;
    position.x += newPoint.x;
    
    position.y -= oldPoint.y;
    position.y += newPoint.y;
    
    view.layer.position = position;
    view.layer.anchorPoint = anchorPoint;
    
}
-(UIViewController *)getSuperViewController
{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:NO];//变黑
    UIView *view;
    UIViewController *superVc;
    for (int i=0; i<100; i++) {
        if(view ==nil)
        {
            view = self.superview;
        }
        else
        {
            view = view.superview;
        }
        if(view.viewController!=nil)
        {
            superVc = view.viewController;
            break;
        }
        else
        {
            i ++;
        }
        
    }
    return superVc;
}
//放大头像，并对背景进行高斯模糊处理
-(void)showPortraitImage:(UIView *)view inView:(UIView *)showView
{
    //高斯模糊的view
    UIVisualEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    visualEffectView.frame =CGRectMake(0.0f, 0.0f, showView.width, showView.height);
    visualEffectView.tag = VisualEffectTag;
    visualEffectView.alpha = 0;
    [showView addSubview:visualEffectView];

    //得到需要放大的图片
    UIImage *image;
    if ([view isKindOfClass:[UIImageView class]]) {
        image = ((UIImageView *)view).image;
    }else if ([view isKindOfClass:[UIButton class]]){
        image = ((UIButton *)view).imageView.image;
    }else
    {
    }
    UIImageView *imageV = [[UIImageView alloc]initWithImage:image];
    imageV.userInteractionEnabled = YES;
    CGRect frameInSuperview = [view convertRect:view.frame toView:self];
    frameInSuperview.origin.x = (SCREEN_WIDTH - view.width)/2;
    frameInSuperview.origin.y-=20.0f;
    imageV.frame = frameInSuperview;
    [showView addSubview:imageV];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
    [imageV addGestureRecognizer:tap];
    CGRect toFrame = CGRectMake(0.0f, (showView.height - PICTURE_HEIGHT)/2, SCREEN_WIDTH, PICTURE_HEIGHT);
    
    [UIView animateWithDuration:ANIMATION animations:^{
        imageV.frame = toFrame;
        visualEffectView.alpha = 1;
    } completion:^(BOOL finished) {
        
    }];
}
-(void)tapGesture:(UITapGestureRecognizer *)ges
{
    UIView *view = [self viewWithTag:VisualEffectTag];

    [UIView animateWithDuration:ANIMATION animations:^{
        ges.view.alpha = 0;
        view.alpha = 0;
    } completion:^(BOOL finished) {
        [ges.view removeFromSuperview];
        [view removeFromSuperview];
    }];
}
//一级界面推到下级界面动画
-(CATransition *)getPushTransition
{
    CATransition *transition = [CATransition animation];
    transition.duration =0.5;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromRight;
    transition.delegate = self;
    return transition;
}
//从上到下覆盖界面
-(CATransition *)getPopTransition
{
    CATransition *transition = [CATransition animation];
    transition.duration =1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type =@"rippleEffect";
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    
    return transition;
}

@end
