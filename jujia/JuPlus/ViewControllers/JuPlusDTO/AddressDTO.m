//
//  AddressDTO.m
//  JuPlus
//
//  Created by admin on 15/7/14.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "AddressDTO.h"

@implementation AddressDTO

-(void)loadDTO:(NSDictionary *)dict
{
    self.addId = [NSString stringWithFormat:@"%@",[dict objectForKey:@"id"]];
    self.addName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];
    self.addAddress = [NSString stringWithFormat:@"%@",[dict objectForKey:@"address"]];
    self.addMobile = [NSString stringWithFormat:@"%@",[dict objectForKey:@"mobile"]];
    NSString *isDefault = [NSString stringWithFormat:@"%@",[dict objectForKey:@"isDefault"]];
    if ([isDefault intValue]==1) {
        self.isDefault = YES;
    }
    else
        self.isDefault = NO;
}
@end
