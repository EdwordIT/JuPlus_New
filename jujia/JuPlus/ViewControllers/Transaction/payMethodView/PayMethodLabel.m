//
//  PayMethodLabel.m
//  JuPlus
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "PayMethodLabel.h"

@implementation PayMethodLabel
-(id)initWithFrame:(CGRect)frame
{
    CGFloat space = 10.0f;
    self = [super initWithFrame:frame];
    if (self) {
        
        _headImgV = [[UIImageView alloc]initWithFrame:CGRectMake(space, (self.height - 25.0f)/2, 25.0f, 25.0f)];
        [self addSubview:_headImgV];

        _headL = [[UILabel alloc]initWithFrame:CGRectMake(_headImgV.right +space, 0.0f, 80.0f, self.height)];
        [_headL setTextColor:Color_Gray];
        [_headL setFont:FontType(FontMaxSize)];
        [self addSubview:_headL];
        
        _selectBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _selectBtn.frame = CGRectMake(self.right - 20.0f - space, (self.height - 20.0f)/2, 20.0f , 20.0f);
        [_selectBtn setImage:[UIImage imageNamed:@"method_no"] forState:UIControlStateNormal];
        [_selectBtn setImage:[UIImage imageNamed:@"method_yes"] forState:UIControlStateNormal];
        _selectBtn.selected = YES;
        [self addSubview:_selectBtn];
        
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
