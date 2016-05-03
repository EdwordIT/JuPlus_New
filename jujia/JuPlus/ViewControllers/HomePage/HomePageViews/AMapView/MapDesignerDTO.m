//
//  DesignerDTO.m
//  JuPlus
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MapDesignerDTO.h"

@implementation MapDesignerDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.name = EncodeStringFromDic(dict, @"name");
    self.lon = EncodeStringFromDic(dict, @"addressLon");
    self.lat = EncodeStringFromDic(dict, @"addressLat");
    self.portraitImg = EncodeStringFromDic(dict, @"portraitPath");
    self.regNo = EncodeStringFromDic(dict, @"regNo");
}
@end
