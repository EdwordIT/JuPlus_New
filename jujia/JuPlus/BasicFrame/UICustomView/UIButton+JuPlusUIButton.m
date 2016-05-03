//
//  UIButton+JuPlusUIButton.m
//  JuPlus
//
//  Created by admin on 15/7/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UIButton+JuPlusUIButton.h"
#import "UIButton+WebCache.h"


@implementation UIButton (JuPlusUIButton)


//加载网络图片
-(void)setimageUrl:(NSString *)url placeholderImage:(NSString *)defalutImage
{
    if(defalutImage==nil)
    {
        if (self.width == self.height) {
            defalutImage = @"default_square";
        }
    }
    else if(self.width==self.height*2)
    {
        defalutImage = @"default_rectangle";
    }
  //  url =[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [self sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,url] ] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:defalutImage]];
     [self sd_setBackgroundImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,url]] forState:UIControlStateHighlighted placeholderImage:[UIImage imageNamed:defalutImage]];
}
//收藏相关的放缩动画
-(void)startAnimation
{
    self.userInteractionEnabled = NO;
    CAKeyframeAnimation *k = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    //values中的每一个值对应放大从开始到结束动作的倍数，对应到keyTimes中的为没一段动画持续时间
    /*  const kCAAnimationLinear; 根据动画的总时长平均分配所有帧数的动画(推荐在平滑动态时候使用)
     NSString * const kCAAnimationDiscrete;   只展示关键帧的状态，没有中间过程，没有动画。
     NSString * const kCAAnimationPaced;根据给定的每一帧的时间决定每一段动画的快慢
     */
    k.values = @[@(1.0),@(0.75),@(1.25),@(1.0)];
    k.keyTimes = @[@(0.0),@(0.25),@(0.5),@(0.25)];
    k.calculationMode = kCAAnimationPaced;
    k.duration = 1.0;
    k.delegate = self;
    [self.layer addAnimation:k forKey:nil];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    self.userInteractionEnabled = YES;
    //在3D旋转中，添加此属性，用于区别是否在中途就提前按钮状态
    if (!self.showsTouchWhenHighlighted) {
        self.selected = !self.selected;
    }
    
}

//3D旋转
- (CAAnimation *)animationRotate:(CATransform3D )transform

{
    CATransform3D rotationTransform  = transform;
    
    CABasicAnimation* animation;
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"];
    
    animation.toValue        = [NSValue valueWithCATransform3D:rotationTransform];
    
    animation.duration        = 0.5;
    //旋转后是否回到原位置
    animation.autoreverses    = YES;
    
    animation.cumulative    = YES;
    
    animation.repeatCount    = 1;
    
    animation.beginTime        = 0;

    animation.delegate        = self;
    
    return animation;
    
}
//创建一个animation组合
-(void)CATransform3D:(CATransform3D )transform

{
    self.userInteractionEnabled = NO;
    [UIView animateWithDuration:ANIMATION animations:^{
        self.selected = !self.selected;
    }completion:^(BOOL finished) {
        
    }];
    UIButton *theButton = self;
    CAAnimation* myAnimationRotate = [self animationRotate:transform];
    
//    CAAnimationGroup *m_pGroupAnimation     = [CAAnimationGroup animation];
//    
//    m_pGroupAnimation.delegate              =self;
//    
//    m_pGroupAnimation.removedOnCompletion   =NO;
//    
//    m_pGroupAnimation.duration              =1;
//    
//    m_pGroupAnimation.timingFunction        = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//    
//    m_pGroupAnimation.repeatCount           =1;//FLT_MAX;  //"forever";
//    
//    m_pGroupAnimation.fillMode              =kCAFillModeForwards;
//    
//    m_pGroupAnimation.animations             = [NSArray arrayWithObjects:myAnimationRotate,nil];
    
    [theButton.layer addAnimation:myAnimationRotate forKey:@"animationRotate"];
   // [theButton.layer addAnimation:m_pGroupAnimation forKey:@"animationRotate"];
}

@end
