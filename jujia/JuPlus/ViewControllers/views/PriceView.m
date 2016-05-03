//
//  PriceView.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PriceView.h"

@implementation PriceView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.backImage];
        [self addSubview:self.textLabel];
    }

    return self;
}
-(UIImageView *)backImage
{
    if(!_backImage)
    {
        _backImage = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
        [_backImage setImage:[UIImage imageNamed:@"price_bg"]];
    }
    return _backImage;
}
-(UILabel *)textLabel
{
    if(!_textLabel)
    {
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, 0.0f, 100.0f, self.height)];
        [_textLabel setTextColor:[UIColor whiteColor]];
        [_textLabel setFont:[UIFont systemFontOfSize:FontMaxSize]];
    }
    return _textLabel;
}
//设置价格
-(void)setPriceText:(NSString *)price
{
    NSString *str =[NSString stringWithFormat:@"¥ %@",price];
    CGFloat width = [CommonUtil getLabelSizeWithString:str andLabelHeight:self.textLabel.height andFont:self.textLabel.font].width;
    self.textLabel.frame = CGRectMake(self.width - width - 10.0f, 0.0f, width+10.0f, self.textLabel.height);
    [self.textLabel setText:str];
    
}
@end
