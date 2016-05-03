//
//  PostProductRespon.m
//  JuPlus
//
//  Created by admin on 15/8/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PostProductRespon.h"

@implementation PostProductRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];
    self.regName = [NSString stringWithFormat:@"%@",[dict objectForKey:@"name"]];

}
@end
