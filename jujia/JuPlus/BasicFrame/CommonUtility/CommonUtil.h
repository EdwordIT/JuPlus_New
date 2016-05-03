//
//  CommonUtil.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CommonUtil : NSObject


//是否为空或是[NSNull null]

#define NotNilAndNull(_ref)  (((_ref) != nil) && (![(_ref) isEqual:[NSNull null]]))
#define IsNilOrNull(_ref)   (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]))

//字符串是否为空
#define IsStrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref)isEqualToString:@""])||([(_ref)isEqualToString:@"<null>"])||([(_ref)isEqualToString:@"(null)"]))
//数组是否为空
#define IsArrEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))
#define IsDicEmpty(_ref)    (((_ref) == nil) || ([(_ref) isEqual:[NSNull null]]) ||([(_ref) count] == 0))

//----------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------

#pragma mark - Singleton Creation  functions单例创建，统一单例命名调用方式
//单例声明 .h中使用
#undef	AS_SINGLETON
#define AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;
//单例实现创建 .m中使用
#undef	DEF_SINGLETON
#define DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static dispatch_once_t once; \
static __class * __singleton__; \
dispatch_once( &once, ^{ __singleton__ = [[__class alloc] init]; } ); \
return __singleton__; \
}

//----------------------------------------------------------------------------------------------
/*／Atzuche_EXTERN 外联函数*/
#if !defined(JuPlus_EXTERN)
#  if defined(__cplusplus)
#   define JuPlus_EXTERN extern "C"
#  else
#   define JuPlus_EXTERN extern
#  endif
#endif
//----------------------------------------------------------------------------------------------
JuPlus_EXTERN NSString     * EncodeStringFromDic(NSDictionary *dic, NSString *key);
JuPlus_EXTERN void EncodeUnEmptyStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key);

#pragma userDefalut相关
+(id )getUserDefaultsValueWithKey:(NSString *) key;

+(void)setUserDefaultsValue:(id) value forKey:(NSString *)key;

+(void)removeUserDefaultsValue:(NSString *) key;
//----------------------------------------------------------------------------------------------
#pragma mark NSNotificationCenter
+(void)postNotification:(NSString *)name Object:(id)obj;

//----------------------------------------------------------------------------------------------

#pragma mark --token
//判断是否登录成功
+(BOOL)isLogin;
//得到token值
+(NSString *)getToken;
//----------------------------------------------------------------------------------------------
//根据label宽度得到字符串占用高度
+(CGSize)getLabelSizeWithString:(NSString *)Str andLabelWidth:(CGFloat)width  andFont:(UIFont *)font;
//根据label高度得到字符串占用宽度
+(CGSize)getLabelSizeWithString:(NSString *)Str andLabelHeight:(CGFloat)height  andFont:(UIFont *)font;
//----------------------------------------------------------------------------------------------

@end
