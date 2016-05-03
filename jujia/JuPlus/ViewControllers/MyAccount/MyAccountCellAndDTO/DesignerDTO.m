//
//  DesignerDTO.m
//  JuPlus
//
//  Created by ios_admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerDTO.h"

@implementation DesignerDTO

- (void)loadDTO:(NSDictionary *)dict
{
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];
    self.coverUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"coverUrl"]];
    self.simpleExplain = [NSString stringWithFormat:@"%@",[dict objectForKey:@"simpleExplain"]];
    self.totalPrice = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalPrice"]];
}

@end
