//
//  JuPlusSystemInfo.m
//  JuPlus
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "JuPlusSystemInfo.h"
#include <sys/types.h>
#include <sys/sysctl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <netdb.h>
#include <arpa/inet.h>
#include <sys/sockio.h>
#include <net/if.h>
#include <errno.h>
#include <net/if_dl.h>
#import <AdSupport/AdSupport.h>
@implementation JuPlusSystemInfo
+ (NSString *)simplePlatform
{
    if (IS_IPAD) {
        return @"IPAD";
    }
    else
    {
        return @"IPHONE";
    }
    
}

+ (NSString *)osVersion
{
    return [[UIDevice currentDevice] systemVersion];
}

//获取系统当前时间
+ (NSString *)systemTimeInfo
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMddHHmmss"];
    NSString *currentDateString = [dateFormatter stringFromDate:[NSDate date]];
    return currentDateString;
}

+ (NSString *)appVersionInt
{
    
    return [NSString stringWithFormat:@"%ld", VERSION_INT];
}

+ (NSString *)appVersion
{
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    return [NSString stringWithFormat:@"%@", version];
}

+ (NSString *)platform
{
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    NSString *platform = [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    free(machine);
    return platform;
}
//硬件版本类型
+ (NSString *)platformString
{
    NSString *platform = [self platform];
    
    if ([platform isEqualToString:@"iPhone1,1"])   return @"iPhone1G";
    if ([platform isEqualToString:@"iPhone1,2"])   return @"iPhone3G";
    if ([platform isEqualToString:@"iPhone2,1"])   return @"iPhone3GS";
    if ([platform isEqualToString:@"iPhone3,1"])   return @"iPhone4 GSM";
    if ([platform isEqualToString:@"iPhone3,2"])   return @"iPhone4";
    if ([platform isEqualToString:@"iPhone3,3"])   return @"iPhone4 CDMA";
    if ([platform isEqualToString:@"iPhone4,1"])   return @"iPhone4S";
    if ([platform isEqualToString:@"iPhone5,1"])   return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,2"])   return @"iPhone5";
    if ([platform isEqualToString:@"iPhone5,3"])   return @"iPhone5C";
    if ([platform isEqualToString:@"iPhone5,4"])   return @"iPhone5C";
    if ([platform isEqualToString:@"iPhone6,1"])   return @"iPhone5S";
    if ([platform isEqualToString:@"iPhone6,2"])   return @"iPhone5S";
    if ([platform isEqualToString:@"iPhone7,1"])   return @"iPhone6Plus";
    if ([platform isEqualToString:@"iPhone7,2"])   return @"iPhone6";
    
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPodTouch1G";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPodTouch2G";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPodTouch3G";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPodTouch4G";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPodTouch5G";
    
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad1 WiFi";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad2 WiFi";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad2 GSM";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad2 CDMAV";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad2 CDMAS";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad mini WiFi";
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad3 WiFi";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad3 GSM";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad3 CDMA";
    if ([platform isEqualToString:@"i386"] || [platform isEqualToString:@"x86_64"])
        return @"iPhone Simulator";
    
    return platform;
    
}
//得到UUID
+ (NSString *)getUUID {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString];
}
//沙河路径
+(NSString *)sandboxFilePath
{
    
    NSArray *filePath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentPath = [filePath objectAtIndex:0];
    return documentPath;
    
}
@end
