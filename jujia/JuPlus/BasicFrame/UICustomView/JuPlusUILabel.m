//
//  JuPlusUILabel.m
//  JuPlus
//
//  Created by admin on 15/7/1.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUILabel.h"

@implementation JuPlusUILabel
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        
    }
    return self;
}
-(void)setPriceText:(NSString *)price
{
    CGFloat priceTxt = [price floatValue];
    NSString *txt = [NSString stringWithFormat:@"¥ %.2f",priceTxt];
    [self setText:txt];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
