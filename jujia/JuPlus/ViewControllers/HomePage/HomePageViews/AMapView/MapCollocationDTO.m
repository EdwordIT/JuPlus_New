//
//  MapCollocationDTO.m
//  JuPlus
//
//  Created by admin on 15/8/27.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MapCollocationDTO.h"

@implementation MapCollocationDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.name = EncodeStringFromDic(dict, @"name");
    self.lon = EncodeStringFromDic(dict, @"visitLon");
    self.lat = EncodeStringFromDic(dict, @"visitLat");
    self.regNo = EncodeStringFromDic(dict, @"regNo");
}

@end
