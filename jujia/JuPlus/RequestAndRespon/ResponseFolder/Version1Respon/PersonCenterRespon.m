//
//  PersonCenterRespon.m
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PersonCenterRespon.h"

@implementation PersonCenterRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.portrait = [NSString stringWithFormat:@"%@",[dict objectForKey:@"portraitPath"]];
    self.nickname = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickname"]];
    self.worksCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"collocatePicCount"]];
    self.payCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"buySuccCount"]];
    self.favourCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"favouriteCount"]];
    self.designerFlag = [NSString stringWithFormat:@"%@",[dict objectForKey:@"designerFlag"]];
    self.collocateRemind = [NSString stringWithFormat:@"%@",[dict objectForKey:@"collocateRemind"]];
    self.orderRemind = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderRemind"]];
    self.messageCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"newMess"]];

}
@end
