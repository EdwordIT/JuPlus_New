//
//  TabBar_BottomBtn.m
//  JuPlus
//
//  Created by admin on 15/9/25.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "TabBar_BottomBtn.h"

@implementation TabBar_BottomBtn
-(id)init
{
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0.0f, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
              [self.titleLabel setFont:FontType(FontSize)];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setBackgroundColor:Color_Pink];
        self.alpha = ALPHLA_BUTTON;
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
