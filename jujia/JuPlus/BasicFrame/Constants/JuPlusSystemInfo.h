//
//  JuPlusSystemInfo.h
//  JuPlus
//
//  Created by admin on 16/1/5.
//  Copyright © 2016年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IOS8_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"8.0"] != NSOrderedAscending )
#define IOS7_OR_LATER	( [[[UIDevice currentDevice] systemVersion] compare:@"7.0"] != NSOrderedAscending )


#define IS_IPAD         ((UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad))
#define IS_IPADz         ([(UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad) intValue])

#define IS_IPHONE_6_PLUS ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

#define IS_IPHONE_4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

@interface JuPlusSystemInfo : NSObject



+ (NSString *)simplePlatform;

/*系统版本*/
+ (NSString *)osVersion;

///*硬件版本*/
+ (NSString *)platform;

/*硬件版本名称*/
+ (NSString *)platformString;

/*系统当前时间 格式：yyyyMMddHHmmss*/
+ (NSString *)systemTimeInfo;

/*软件内部版本*/
+ (NSString *)appVersionInt;

/*软件版本*/
+ (NSString *)appVersion;

///*是否是iPhone5*/
////+ (BOOL)is_iPhone_5;
//
///*是否越狱*/
//+ (BOOL)isJailBroken;
//
///*越狱版本*/
//+ (NSString *)jailBreaker;

/*macAddress在iOS7中失效，故改为uuid，使用keychain永久保存达到udid的效果*/
+ (NSString *)getUUID;

+(NSString *)sandboxFilePath;
@end
