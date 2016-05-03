//
//  JuPlusGlobalData.m
//  JuPlus
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "JuPlusGlobalData.h"
#import "JuPlusGetLocation.h"
#import "JuPlusSystemInfo.h"
#import "CommonUtil.h"
@implementation JuPlusGlobalData
DEF_SINGLETON(JuPlusGlobalData);

- (id)init
{
    self = [super init];
    if (self)
    {
    }
    return self;
}

/*
 cliVer(客户端版本)、
 dType(设备类型)、
 udid(设备唯一识别码)、
 locX(纬度)、
 locY(经度)
 */
+(NSDictionary *)getAppInfoDic
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    EncodeUnEmptyStrObjctToDic(dic, [JuPlusSystemInfo getUUID], @"appid");
//    EncodeUnEmptyStrObjctToDic(dic, [JuPlusSystemInfo appVersionInt], @"AppVersion");
//    EncodeUnEmptyStrObjctToDic(dic, @"IOS", @"OS");
//    EncodeUnEmptyStrObjctToDic(dic, [JuPlusSystemInfo osVersion], @"OsVersion");
//    EncodeUnEmptyStrObjctToDic(dic, [JuPlusSystemInfo platformString], @"deviceName");
//    if (IsStrEmpty([CommonUtil getToken])) {
//        EncodeUnEmptyStrObjctToDic(dic, @"0", @"publicToken");
//    }
//    else
//    {
//        EncodeUnEmptyStrObjctToDic(dic, [CommonUtil getToken], @"publicToken");
//    }
    
        if ([JuPlusGetLocation sharedInstance].locLat==31.243466)
    {
        EncodeUnEmptyStrObjctToDic(dic, @"0", @"lat");
    }
    else
    {
        EncodeUnEmptyStrObjctToDic(dic,[NSString stringWithFormat:@"%f", [JuPlusGetLocation sharedInstance].locLat], @"lat");
    }
    if ([JuPlusGetLocation sharedInstance].locLong==121.491121)
    {
        EncodeUnEmptyStrObjctToDic(dic, @"0", @"lon");
    }
    else
    {
        EncodeUnEmptyStrObjctToDic(dic, [NSString stringWithFormat:@"%f", [JuPlusGetLocation sharedInstance].locLong], @"lon");
    }
    
    EncodeUnEmptyStrObjctToDic(dic, [JuPlusGetLocation sharedInstance].cityName, @"cityName");
//        EncodeUnEmptyStrObjctToDic(dic,@"", @"cityName");

    NSLog(@"cityName = %@",[JuPlusGetLocation sharedInstance].cityName);
    EncodeUnEmptyStrObjctToDic(dic, [JuPlusUserInfoCenter sharedInstance].userInfo.regNo, @"memberNo");

    return dic;
}

@end
