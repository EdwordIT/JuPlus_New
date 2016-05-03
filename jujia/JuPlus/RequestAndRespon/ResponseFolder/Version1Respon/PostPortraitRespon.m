//
//  PostPortraitRespon.m
//  JuPlus
//
//  Created by admin on 15/7/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PostPortraitRespon.h"

@implementation PostPortraitRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.portrait = [NSString stringWithFormat:@"%@",[dict objectForKey:@"portraitPath"]];
}
@end
