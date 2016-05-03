//
//  UIScrollView+UITouch.h
//  JuPlus
//
//  Created by admin on 15/8/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (UITouch)
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event ;
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;

@end
