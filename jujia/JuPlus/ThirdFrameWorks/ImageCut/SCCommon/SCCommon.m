//
//  SCCommon.m
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-19.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import "SCCommon.h"
#import "SCDefines.h"
#import <QuartzCore/QuartzCore.h>
@implementation SCCommon

@synthesize library;

/**
 *  UIColor生成UIImage
 *
 *  @param color     生成的颜色
 *  @param imageSize 生成的图片大小
 *
 *  @return 生成后的图片
 */
+ (UIImage*)createImageWithColor:(UIColor*)color size:(CGSize)imageSize {
    CGRect rect=CGRectMake(0.0f, 0.0f, imageSize.width, imageSize.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

//画一条线
+ (void)drawALineWithFrame:(CGRect)frame andColor:(UIColor*)color inLayer:(CALayer*)parentLayer {
    CALayer *layer = [CALayer layer];
    layer.frame = frame;
    layer.backgroundColor = color.CGColor;
    [parentLayer addSublayer:layer];
}

#pragma mark -------------save image to local---------------
//保存照片至本机(新建/调用居+文件夹，用于在手机上建立系统之外的文件夹内容)
+ (void)saveImageToPhotoAlbum:(UIImage*)image {
    
    ALAssetsLibrary *libaray1 = [[ALAssetsLibrary alloc]init];
    [libaray1 saveImage:image toAlbum:@"居+" withCompletionBlock:^(NSError *error) {
        
        
        if (error!=nil) {
            NSLog(@"Big error: %@", [error description]);
        }
    }];
   // UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}

+ (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    if (error != NULL) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"出错了!" message:@"存不了T_T" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    } else {
        SCDLog(@"保存成功");
    }
}

@end
