//
//  BannerItem.m
//  JuPlus
//
//  Created by admin on 15/10/16.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "BannerItem.h"

@implementation BannerItem
-(void)loadDTO:(NSDictionary *)dict
{
    self.title = EncodeStringFromDic(dict, @"title");
    self.imgUrl = EncodeStringFromDic(dict, @"imgUrl");
    self.param = EncodeStringFromDic(dict, @"param");
    self.type = EncodeStringFromDic(dict, @"type");

}
@end
