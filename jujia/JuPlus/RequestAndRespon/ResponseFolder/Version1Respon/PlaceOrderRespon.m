//
//  PlaceOrderRespon.m
//  JuPlus
//
//  Created by admin on 15/7/6.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PlaceOrderRespon.h"
#import "productOrderDTO.h"
@implementation PlaceOrderRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.orderNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderNo"]];
    self.totalAmt = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalAmt"]];
    self.reqTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"reqTime"]];
    self.receictAddress = [NSString stringWithFormat:@"%@",[dict objectForKey:@"receiverAddress"]];
    self.receictMobile = [NSString stringWithFormat:@"%@",[dict objectForKey:@"receiverMobile"]];
    self.receictName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"receiverName"]];

    self.productArr = [[NSMutableArray alloc]init];
    NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"productList"]];
    for(NSDictionary *dic in arr)
    {
        productOrderDTO *dto = [[productOrderDTO alloc]init];
        [dto loadDTO:dic];
        [self.productArr addObject:dto];
    }
    
    self.status = EncodeStringFromDic(dict, @"status");
    self.realAmt = EncodeStringFromDic(dict, @"realAmt");
    self.statusTxt = EncodeStringFromDic(dict, @"statusTxt");
    self.logCompany = EncodeStringFromDic(dict, @"expressName");
    self.waybill = EncodeStringFromDic(dict, @"expressNo");
    self.remark = EncodeStringFromDic(dict, @"remark");

    
}
@end
