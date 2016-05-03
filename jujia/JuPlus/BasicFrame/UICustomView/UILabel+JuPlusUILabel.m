//
//  UILabel+JuPlusUILabel.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UILabel+JuPlusUILabel.h"

@implementation UILabel (JuPlusUILabel)
-(void)setPriceTxt:(NSString *)price
{
    NSString *str =[NSString stringWithFormat:@"¥ %.2f",[price floatValue]];
    CGFloat width = [CommonUtil getLabelSizeWithString:str andLabelHeight:self.height andFont:self.font].width;
    self.frame = CGRectMake(0.0f, self.top, width+10.0f, self.height);
    [self setText:str];
    self.alpha = 0.8;
    self.backgroundColor = HEX_RGB(@"895329");
}
-(void)setStatus:(NSString *)string
{
    if ([string isEqualToString:@"未支付"]||[string isEqualToString:@"未发货"]) {
        self.textColor = RGBCOLOR(242, 100, 116);
    }else if ([string isEqualToString:@"已发货"]||[string isEqualToString:@"已退款"]){
        self.textColor = RGBCOLOR(143, 195, 31);
    }else if ([string isEqualToString:@"退款中"]){
        self.textColor = RGBCOLOR(0, 183, 238);
    }else if ([string isEqualToString:@"已完成"]){
        self.textColor = RGBCOLOR(243, 151, 0);
    }else if ([string isEqualToString:@"已失效"]){
        self.textColor = RGBCOLOR(160, 160, 160);
    }else{
       self.textColor = RGBCOLOR(242, 100, 116); 
    }
    [self setText:string];
}
@end
