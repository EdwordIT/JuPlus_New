//
//  PostOrderRespon.m
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PostOrderRespon.h"

@implementation PostOrderRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.orderNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderNo"]];
    self.totalAmt = EncodeStringFromDic(dict, @"totalAmt");
    self.realAmt = EncodeStringFromDic(dict, @"realAmt");
    self.alipay = [[AlipayDTO alloc]init];
    [self.alipay loadDTO: [dict objectForKey:@"payParam"]];
}
@end
