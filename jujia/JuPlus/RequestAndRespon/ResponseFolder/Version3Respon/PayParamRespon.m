//
//  PayParamRespon.m
//  JuPlus
//
//  Created by admin on 15/9/24.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "PayParamRespon.h"

@implementation PayParamRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.orderNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderNo"]];
    self.totalAmt = EncodeStringFromDic(dict, @"totalAmt");
    self.alipay = [[AlipayDTO alloc]init];
    [self.alipay loadDTO: [dict objectForKey:@"payParam"]];
}

@end
