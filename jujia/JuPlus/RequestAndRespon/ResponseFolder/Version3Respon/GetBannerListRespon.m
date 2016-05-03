//
//  GetBannerListRespon.m
//  JuPlus
//
//  Created by admin on 15/10/16.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "GetBannerListRespon.h"
@implementation GetBannerListRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.bannerListArray = [[NSMutableArray alloc]init];
    NSArray *bannerList = [dict objectForKey:@"bannerList"];
    for (NSDictionary *banner in bannerList) {
        BannerItem *item = [[BannerItem alloc]init];
        [item loadDTO:banner];
        [self.bannerListArray addObject:item];
    }
}
@end
