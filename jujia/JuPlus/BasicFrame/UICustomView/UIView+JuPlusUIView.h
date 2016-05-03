//
//  UIView+FurnHUIView.h
//  ImageTips
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#undef L
#define L(key) \
[[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil]
//view的高斯模糊对应的tag，别处禁用
#define VisualEffectTag 1001

@interface UIView (JuPlusUIView)
@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat bottom;

@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;

@property(nonatomic) CGFloat centerX;
@property(nonatomic) CGFloat centerY;

@property(nonatomic,readonly) CGFloat screenX;
@property(nonatomic,readonly) CGFloat screenY;
@property(nonatomic,readonly) CGFloat screenViewX;
@property(nonatomic,readonly) CGFloat screenViewY;
@property(nonatomic,readonly) CGRect screenFrame;

@property(nonatomic) CGPoint origin;
@property(nonatomic) CGSize size;


- (void)removeAllSubviews;
- (UIViewController *)viewController;
////设置view高斯模糊显示
//-(void)setVisualEffect;
////取消高斯模糊显示
//-(void)removeVisualEffect;
//like airbnb
- (void)setAnchorPoint:(CGPoint)point;
-(UIViewController *)getSuperViewController;
//一级界面推到下级界面动画
-(CATransition *)getPushTransition;
//从上到下覆盖界面
-(CATransition *)getPopTransition;
//放大图片
-(void)showPortraitImage:(UIView *)view inView:(UIView *)showView;
@end
