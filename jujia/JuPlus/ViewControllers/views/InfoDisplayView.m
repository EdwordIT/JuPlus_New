//
//  InfoDisplayView.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "InfoDisplayView.h"

@implementation InfoDisplayView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.headerL];
        [self addSubview:self.textL];
    }
    return self;
}
-(UILabel *)headerL
{
    if(!_headerL)
    {
        _headerL = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 10.0f, self.width, 30.0f)];
        [_headerL setTextColor:Color_Basic];
        [_headerL setFont:FontType(FontSize)];
        _headerL.textAlignment = NSTextAlignmentCenter ;
    }
    return _headerL;
}
-(RTLabel *)textL
{
    if(!_textL)
    {
        _textL = [[RTLabel alloc]initWithFrame:CGRectMake(10.0f, self.headerL.bottom+10.0f, self.width -20.0f, 30.0f)];
        _textL.textAlignment = RTTextAlignmentCenter;
        [_textL setFont:FontType(FontSize)];
        [_textL setTextColor:Color_Gray];
    }
    return _textL;
}
-(void)layoutSubviews
{
    self.frame = CGRectMake(self.left, self.top , self.width, self.textL.height+50.0f);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
