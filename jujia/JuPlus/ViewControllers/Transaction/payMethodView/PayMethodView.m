//
//  PayMethodView.m
//  JuPlus
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "PayMethodView.h"
#import "PayMethodLabel.h"
@implementation PayMethodView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, 30.0f)];
        [_titleL setTextColor:Color_Gray];
        [_titleL setText:@"支付方式"];
        _titleL.textAlignment = NSTextAlignmentCenter;
        [_titleL setFont:FontType(FontSize)];
        [self addSubview:_titleL];
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, _titleL.bottom - 1.0f, self.width, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [self addSubview:line];
       
        NSArray *img = [NSArray arrayWithObjects:@"alipay", nil];
        NSArray *imgT = [NSArray arrayWithObjects:@"支付宝", nil];
        
        for (int i=0; i<1; i++) {
            PayMethodLabel *la = [[PayMethodLabel alloc]initWithFrame:CGRectMake(0.0f, _titleL.bottom, self.width, 50.0f)];
            [la.headImgV setImage:[UIImage imageNamed:[img objectAtIndex:i]]];
            [la.headL setText:[imgT objectAtIndex:i]];
            la.selectBtn.tag = i;
            [self addSubview:la];
        }
        
       
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
