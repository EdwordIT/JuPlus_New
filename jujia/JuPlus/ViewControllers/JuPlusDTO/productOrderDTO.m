//
//  productOrderDTO.m
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "productOrderDTO.h"

@implementation productOrderDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.imgUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"productImg"]];
    self.productName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"productName"]];
    self.price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"productPrice"]];
    self.countNum = [NSString stringWithFormat:@"%@",[dict objectForKey:@"productNum"]];
    self.productNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"productNo"]];
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];

}
@end
