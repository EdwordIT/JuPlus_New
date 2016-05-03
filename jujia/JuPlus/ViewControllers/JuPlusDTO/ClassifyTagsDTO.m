//
//  ClassifyTagsDTO.m
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ClassifyTagsDTO.h"

@implementation ClassifyTagsDTO

-(void)loadDTO:(NSDictionary *)dict
{
    self.name = [NSString stringWithFormat:@"%@",[dict  objectForKey:@"name"]];
    self.tagId = [NSString stringWithFormat:@"%@",[dict  objectForKey:@"id"]];
    self.sortId = [NSString stringWithFormat:@"%@",[dict  objectForKey:@"sortId"]];

    self.imgUrl = [NSString stringWithFormat:@"%@",[dict  objectForKey:@"imgUrl"]];

    self.selImgUrl = [NSString stringWithFormat:@"%@",[dict  objectForKey:@"hoverImgUrl"]];

}
@end
