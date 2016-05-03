//
//  DiagramsDTO.m
//  JuPlus
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "DiagramsDTO.h"

@implementation DiagramsDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.imgUrl = [NSString stringWithFormat:@"%@",[dict objectForKey:@"cover_url"]];
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"reg_no"]];
    self.title = [NSString stringWithFormat:@"%@",[dict objectForKey:@"title"]];
    self.createTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"create_time"]];
    self.textString = [NSString stringWithFormat:@"%@",[dict objectForKey:@"simple_explain"]];
    self.spaceStyle = [NSString stringWithFormat:@"%@",[dict objectForKey:@"space_style"]];
    self.styleType = [NSString stringWithFormat:@"%@",[dict objectForKey:@"style_type"]];
}
@end
