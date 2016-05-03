//
//  OrderProductView.m
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderProductView.h"
@implementation OrderProductView

#define space 20.0f
-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.iconImgV];
        [self addSubview:self.titleL];
        [self addSubview:self.priceL];
        [self addSubview:self.countL];
    }
    return self;
}
#pragma mark --UI
-(UIImageView *)iconImgV
{
    if(!_iconImgV)
    {
        CGFloat multiple = SCREEN_WIDTH/PICTURE_HEIGHT;
        CGFloat imgW = 80.0f;
        CGFloat imgH = imgW/multiple;
        _iconImgV = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, (self.height - imgH)/2 , imgW, imgH)];
        [_iconImgV setImage:[UIImage imageNamed:@"default_square"]];
        
        
    }
    return _iconImgV;
}
-(JuPlusUILabel *)titleL
{
    if(!_titleL)
    {
        _titleL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.iconImgV.right +space/2, space/2, 150.0f, 30.0f)];
        [_titleL setFont:FontType(14.0f)];
        _titleL.textColor = Color_Black;
    }
    return _titleL;
}
-(JuPlusUILabel *)priceL
{
    if(!_priceL)
    {
        _priceL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.titleL.right, self.titleL.top, self.width - self.titleL.right - space/2, 30.0f)];
        [_priceL setFont:[UIFont systemFontOfSize:FontSize]];
        _priceL.textAlignment = NSTextAlignmentRight;
        _priceL.textColor = Color_Gray;
    }
    return _priceL;
}

-(JuPlusUILabel *)countL
{
    if(!_countL)
    {
        _countL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.priceL.right - 50.0f , self.priceL.bottom, 50.0f, 30.0f)];
        [_countL setFont:FontType(14.0f)];
        _countL.textAlignment = NSTextAlignmentRight;
        [_countL setTextColor:Color_Gray];
    }
    return _countL;
}
-(void)loadData:(productOrderDTO *)dto
{
    
    [self.iconImgV setimageUrl:dto.imgUrl placeholderImage:nil];
    [self.titleL setText:dto.productName];
    [self.priceL setPriceText:dto.price];
    [self.countL setText:[NSString stringWithFormat:@"X%@",dto.countNum]];
    
}

@end
