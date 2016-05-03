//
//  productView.m
//  JuPlus
//
//  Created by admin on 15/7/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "productView.h"
#define space 20.0f
@implementation productView
-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.iconImgV];
        [self addSubview:self.titleL];
        [self addSubview:self.priceL];
        [self addSubview:self.typeLabel];
        [self addSubview:self.countV];
        
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
        
        
    }
    return _iconImgV;
}
-(JuPlusUILabel *)titleL
{
    if(!_titleL)
    {
        _titleL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.iconImgV.right +space/2, space, 100.0f, 20.0f)];
        [_titleL setFont:FontType(14.0f)];
        _titleL.textColor = Color_Black;
    }
    return _titleL;
}
-(JuPlusUILabel *)priceL
{
    if(!_priceL)
    {
        _priceL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.titleL.left, self.titleL.bottom, 100.0f, 30.0f)];
        [_priceL setFont:[UIFont systemFontOfSize:FontMinSize]];
        _priceL.textColor = Color_Gray;
    }
    return _priceL;
}

-(CountView *)countV
{
    if(!_countV)
    {
        CGRect frame;
        UIImage *img = [UIImage imageNamed:@"countNum"];
        if (img.size.width == 104.f) {
            frame = CGRectMake(self.width - 104.0f, (self.height - 18.0f)/2, 104.0f, 30.0f);
        }else{
            frame = CGRectMake(self.width - 80.0f, (self.height - 18.0f)/2, 80.0f, 22.0f);
        }
        _countV = [[CountView alloc]initWithFrame:frame];
    }
    return _countV;
}
-(UILabel *)typeLabel
{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.width - 100.0f, self.titleL.top, 100.0f, 30.0f)];
        [_typeLabel setFont:FontType(FontSize)];
        [_typeLabel setTextColor:Color_Basic];
        _typeLabel.textAlignment = NSTextAlignmentRight;
        [_typeLabel setHidden:YES];
    }
    return _typeLabel;
}
-(void)loadData:(productOrderDTO *)dto
{
    [self.iconImgV setimageUrl:dto.imgUrl placeholderImage:nil];
    [self.titleL setText:dto.productName];
    [self.priceL setText:[NSString stringWithFormat:@"¥ %.2f",[dto.price floatValue]]];
    [self.countV setCountNum:[dto.countNum intValue]];

}
@end
