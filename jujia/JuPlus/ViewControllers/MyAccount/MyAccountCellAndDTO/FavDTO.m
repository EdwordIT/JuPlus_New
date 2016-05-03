//
//  FavDTO.m
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "FavDTO.h"

@implementation FavDTO

-(void)loadDTO:(NSDictionary *)dict
{
    self.memberNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"memberNo"]];
    self.memPortraitPath = [NSString stringWithFormat:@"%@",[dict objectForKey:@"memPortraitPath"]];
    self.nickname = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickname"]];
    self.createTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"createTime"]];
}
@end
