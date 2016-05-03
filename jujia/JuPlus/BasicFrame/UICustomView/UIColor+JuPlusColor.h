//
//  UIColor+FurnHColor.h
//  FurnHouse
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>

#undef  RGBCOLOR
//不带透明度的rgb值
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

#undef  RGBACOLOR
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]

#undef	HEX_RGB
#define HEX_RGB(hex)		[UIColor colorWithHexString:(hex)]

#define ALPHLA_BUTTON 0.9

#define Color_Pink RGBCOLOR(242, 114, 128)
#define Color_Basic HEX_RGB(@"c08c54")
#define Color_Gray_lines RGBCOLOR(242, 242, 242)
#define Color_Gray [UIColor grayColor]
#define Color_Black RGBCOLOR(0, 0, 0)
#define Color_White RGBCOLOR(255, 255, 255)

//灰色背景
#define Color_Bottom RGBCOLOR(239, 239, 239)
//输入框文字颜色
#define Color_FieldText RGBCOLOR(128, 128, 128)
#define Color_Red RGBCOLOR(251, 62, 69)

@interface UIColor (JuPlusColor)

+ (UIColor *)colorWithRGBHex:(UInt32)hex;
+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithCssName:(NSString *)cssColorName;

+ (UIColor *)bgColor_nav;
+ (UIColor *)bgColor_view;
+ (UIColor *)bgColor_cell;

+ (UIColor *)textColor_dark;
+ (UIColor *)textColor_light;

@end
