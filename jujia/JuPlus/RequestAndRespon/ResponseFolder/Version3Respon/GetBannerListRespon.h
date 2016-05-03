//
//  GetBannerListRespon.h
//  JuPlus
//
//  Created by admin on 15/10/16.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "BannerItem.h"
//bannerlist
@interface GetBannerListRespon : JuPlusResponse
@property (nonatomic,strong)NSMutableArray *bannerListArray;
@end
