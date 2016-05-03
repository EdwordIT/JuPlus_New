//
//  CommonUtil.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CommonUtil.h"

@implementation CommonUtil

//================================================================================================

+(id )getUserDefaultsValueWithKey:(NSString *) key
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
+(void)setUserDefaultsValue:(id ) value forKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}
+(void)removeUserDefaultsValue:(NSString *) key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}
//----------------------------------------------------------------------------------------------
#pragma mark Nsnotificationcenter
+(void)postNotification:(NSString *)name Object:(id)obj
{
    [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj];
}
//----------------------------------------------------------------------------------------------
#pragma sizeFont
+(CGSize)getLabelSizeWithString:(NSString *)Str andLabelWidth:(CGFloat)width  andFont:(UIFont *)font
{
    NSDictionary *attribute = @{ NSFontAttributeName: font};
    //NSStringDrawingUsesLineFragmentOrigin获得label的长度和宽度
    CGSize size = [Str boundingRectWithSize:CGSizeMake(width, 999.0f) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
    return size;
    
}
+(CGSize)getLabelSizeWithString:(NSString *)Str andLabelHeight:(CGFloat)height  andFont:(UIFont *)font
{
        NSDictionary *attribute = @{ NSFontAttributeName: font};
        //NSStringDrawingUsesLineFragmentOrigin获得label的长度和宽度
        CGSize size = [Str boundingRectWithSize:CGSizeMake(640.0f, height) options: NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil].size;
        //  NSLog(@"size.width:%f",size.width);
        return size;
}
//----------------------------------------------------------------------------------------------
#pragma mark --token
//判断是否登录成功
+(BOOL)isLogin
{
    if(IsStrEmpty([self getUserDefaultsValueWithKey:TOKEN])||[[self getUserDefaultsValueWithKey:TOKEN] isEqualToString:@"0"])
        return NO;
    else
        return YES;
}
//得到token值
+(NSString *)getToken
{
    return [self getUserDefaultsValueWithKey:TOKEN]?:@"0";
}
//----------------------------------------------------------------------------------------------
//从字典里拿数据
JuPlus_EXTERN NSString* EncodeStringFromDic(NSDictionary *dic, NSString *key)
{
//    id temp = [dic objectForKey:key];
//    if ([temp isKindOfClass:[NSString class]])
//    {
//        return temp;
//    }
//    else if ([temp isKindOfClass:[NSNumber class]])
//    {
//        return [temp stringValue];
//    }
//    return nil;
    return [NSString stringWithFormat:@"%@",[dic objectForKey:key]];
}
JuPlus_EXTERN void EncodeUnEmptyStrObjctToDic(NSMutableDictionary *dic,NSString *object, NSString *key)
{
    if (IsNilOrNull(dic))
    {
        return;
    }
    
    if (IsStrEmpty(object))
    {
//        return;
        object = @"0";
    }
    
    if (IsStrEmpty(key))
    {
        return;
    }
    
    [dic setObject:object forKey:key];
}

@end
