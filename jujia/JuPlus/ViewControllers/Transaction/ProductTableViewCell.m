//
//  ProductTableViewCell.m
//  JuPlus
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "ProductTableViewCell.h"
#define space 20.0f
static CGFloat productHeight = 100.0f;
@implementation ProductTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImgV];
        [self.contentView addSubview:self.titleL];
        [self.contentView addSubview:self.priceL];
        [self.contentView addSubview:self.countV];
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
        _iconImgV = [[UIImageView alloc]initWithFrame:CGRectMake(space, (productHeight - imgH)/2 , imgW, imgH)];

        
    }
    return _iconImgV;
}
-(JuPlusUILabel *)titleL
{
    if(!_titleL)
    {
        _titleL = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(self.iconImgV.right +space/2, space, 100.0f, 20.0f)];
        [_titleL setFont:FontType(FontSize)];
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
            frame = CGRectMake(self.width - 104.0f -space, (productHeight - 18.0f)/2, 104.0f, 30.0f);
        }else{
            frame = CGRectMake(self.width - 80.0f -space, (productHeight - 18.0f)/2, 80.0f, 22.0f);
        }
        _countV = [[CountView alloc]initWithFrame:frame];
    }
    return _countV;
}

-(void)fileCell:(productOrderDTO *)dto
{
    [self.iconImgV setimageUrl:dto.imgUrl placeholderImage:nil];
    [self.titleL setText:dto.productName];
    [self.priceL setText:[NSString stringWithFormat:@"¥ %.2f",[dto.price floatValue]]];
    [self.countV setCountNum:[dto.countNum intValue]];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
