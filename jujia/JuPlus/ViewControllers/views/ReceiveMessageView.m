//
//  ReceiveMessageView.m
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ReceiveMessageView.h"
@implementation ReceiveMessageView
{
    CGFloat space;
    CGFloat labelH;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        space = 10.0f;
        labelH = 20.0f;
        self.backgroundColor = [UIColor whiteColor];
        UIImageView *bgImg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
        [bgImg setImage:[UIImage imageNamed:@"address_bg"]];
        [self addSubview:bgImg];
//        
//        NSArray *array = [NSArray arrayWithObjects:@"收件人",@"手机",@"收件地址", nil];
//        for (int i=0; i<3; i++) {
//            JuPlusUILabel *label = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(space, labelH*i+space, 70.0f, labelH)];
//            [label setFont:FontType(16.0f)];
//            [label setTextColor:Color_Black];
//            [label setText:[array objectAtIndex:i]];
//            [self addSubview:label];
//        }
        
        [self addSubview:self.nameL];
        [self addSubview:self.mobileL];
        [self addSubview:self.addressL];
        [self addSubview:self.rightArrow];
    }
    return self;
}
-(JuPlusUILabel *)nameL
{
    if(!_nameL)
    {
        _nameL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(space*2, space, 70.0f, labelH)];
        [_nameL setFont:FontType(FontSize)];
        [_nameL setTextColor:Color_Black];
    }
    return _nameL;
}
-(JuPlusUILabel *)mobileL
{
    if(!_mobileL)
    {
        _mobileL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.nameL.right, space, 120.0f, labelH)];
        [_mobileL setFont:FontType(FontSize)];
        [_mobileL setTextColor:Color_Black];
    }
    return _mobileL;
}
-(JuPlusUILabel *)addressL
{
    if(!_addressL)
    {
        _addressL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(space*2, self.mobileL.bottom, self.width - 110.0f, labelH)];
        [_addressL setFont:FontType(FontSize)];
        [_addressL setTextColor:Color_Gray];
    }
    return _addressL;
}
-(UIButton *)rightArrow
{
    if(!_rightArrow)
    {
        _rightArrow = [UIButton buttonWithType:UIButtonTypeCustom];
        CGFloat imgW = 20.0f;
        CGFloat imgH = 20.0f;
        _rightArrow .frame = CGRectMake(self.width - imgW - space, (self.height - imgH)/2, imgW, imgH);
        [_rightArrow setImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateNormal];
    }
    return _rightArrow;
}
-(void)setAddressInfo:(AddressDTO *)dto
{
    [self.nameL setText:dto.addName];
    [self.mobileL setText:dto.addMobile];
    [self.addressL setText:dto.addAddress];
    self.tag = [dto.addId intValue];

}
@end
