//
//  GetAddressRespon.m
//  JuPlus
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "GetAddressRespon.h"
#import "AddressDTO.h"
@implementation GetAddressRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.addressArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in [dict objectForKey:@"data"]) {
        AddressDTO *dto = [[AddressDTO alloc]init];
        [dto loadDTO:dic];
        [self.addressArray addObject:dto];
    }
}
@end
