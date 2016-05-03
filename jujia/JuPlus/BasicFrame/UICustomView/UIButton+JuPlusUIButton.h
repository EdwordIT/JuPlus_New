//
//  UIButton+JuPlusUIButton.h
//  JuPlus
//
//  Created by admin on 15/7/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (JuPlusUIButton)

-(void)setimageUrl:(NSString *)url placeholderImage:(NSString *)defalutImage;
//放缩
-(void)startAnimation;
//3D旋转
-(void)CATransform3D:(CATransform3D )transform;

@end
