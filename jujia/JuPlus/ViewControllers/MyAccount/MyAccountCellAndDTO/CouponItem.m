//
//  CouponItem.m
//  JuPlus
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CouponItem.h"

@implementation CouponItem
-(void)loadDTO:(NSDictionary *)dict
{
    self.idString = EncodeStringFromDic(dict, @"id");
    self.title = EncodeStringFromDic(dict, @"couponName");
    self.txt = EncodeStringFromDic(dict, @"detail");
    self.amt = EncodeStringFromDic(dict, @"amt");
    self.usedMinAmt = EncodeStringFromDic(dict, @"usedMinAmt");
    self.expireDate = EncodeStringFromDic(dict, @"endDate");
    self.status = [EncodeStringFromDic(dict, @"status") integerValue];
}
@end
