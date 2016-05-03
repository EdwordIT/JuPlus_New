//
//  InfoChangeV.m
//  JuPlus
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "InfoChangeV.h"

@implementation InfoChangeV

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self uifig];
        
    }
    return self;
}
-(void)uifig
{
    _titleL = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, 0.0f, 100.0f, self.height)];
    [_titleL setFont:FontType(FontMaxSize)];
    [self addSubview:_titleL];
    
    _textL = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 190.0f, 0.0f, 160.0f, self.height)];
    [_textL setFont:FontType(FontMaxSize)];
    [_textL setTextAlignment:NSTextAlignmentRight];
    [self addSubview:_textL];
    
    _rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.width - 30.0f, (self.height - 20.0f)/2, 20.0f, 20.0f)];
    [_rightArrow setImage: [UIImage imageNamed:@"arrow_right"]];
    [self addSubview:_rightArrow];
    
    _clickBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickBtn.frame = CGRectMake(0.0f, 0.0f, self.width , self.height);
    [self addSubview:_clickBtn];
    
    _botomV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(_titleL.left, self.height - 1.0f, self.width - 10.0f, 1.0f)];
    [_botomV setBackgroundColor:Color_Gray_lines];
    [self addSubview:self.botomV];
    
}

@end
