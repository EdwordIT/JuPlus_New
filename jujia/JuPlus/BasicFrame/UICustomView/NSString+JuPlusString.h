//
//  NSString+FurnHString.h
//  FurnHouse
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JuPlusString)
//字符串转化为三位分割显示
- (NSString *)toFormatNumberString;
//字符串处理
+(NSString *)getStringValue:(int)intValue;
@end
