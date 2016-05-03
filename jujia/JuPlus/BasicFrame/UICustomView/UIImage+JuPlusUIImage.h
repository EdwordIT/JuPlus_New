//
//  UIImage+FurnHUIImage.h
//  ImageTips
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (JuPlusUIImage)
+ (UIImage *)noCachegetImageFromBundle:(NSString *)imageName;

+ (UIImage *)stregetImageFromBundle:(NSString *)imageName;
+ (UIImage *)stregetImageFromBundle:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y;
+ (UIImage *)imageWithColor:(UIColor *)color;
//得到高斯模糊
+ (UIImage *)filterImage:(UIImage *)image;
- (UIImage *)stretched;
- (UIImage *)grayscale;


- (UIColor *)patternColor;


- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
//得到缩放的图片
-(NSString *)getImageString;
//得到固定尺寸的压缩图片上传
-(NSString *)getPostImageString;
//给图像绘制文字
-(UIImage *)addText:(NSString *)text andNickname:(NSString *)name;

@end
