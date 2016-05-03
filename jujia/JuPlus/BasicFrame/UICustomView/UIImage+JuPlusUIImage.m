//
//  UIImage+FurnHUIImage.m
//  ImageTips
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UIImage+JuPlusUIImage.h"
#import <CoreText/CoreText.h>
@implementation UIImage (JuPlusUIImage)

CGFloat DegreesToRadians(CGFloat degrees)
{
    return degrees * M_PI / 180;
}

CGFloat RadiansToDegrees(CGFloat radians)
{
    return radians * 180/M_PI;
}

+ (UIImage *)noCachegetImageFromBundle:(NSString *)imageName
{
    NSString *imageFile = [[NSString alloc] initWithFormat:@"%@/%@",
                           [[NSBundle mainBundle] resourcePath], imageName];
    return [[UIImage alloc] initWithContentsOfFile:imageFile];
}

+ (UIImage *)stregetImageFromBundle:(NSString *)imageName
{
    if (imageName == nil) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *streImage = [image stretchableImageWithLeftCapWidth:image.size.width/2 topCapHeight:image.size.height/2];
    return streImage;
}

+ (UIImage *)stregetImageFromBundle:(NSString *)imageName capX:(CGFloat)x capY:(CGFloat)y
{
    if (imageName == nil) {
        return nil;
    }
    UIImage *image = [UIImage imageNamed:imageName];
    UIImage *streImage = [image stretchableImageWithLeftCapWidth:x topCapHeight:y];
    return streImage;
}

- (UIImage *)stretched
{
    CGFloat leftCap = floorf(self.size.width / 2.0f);
    CGFloat topCap = floorf(self.size.height / 2.0f);
    return [self stretchableImageWithLeftCapWidth:leftCap topCapHeight:topCap];
}

- (UIImage *)grayscale
{
    CGSize size = self.size;
    CGRect rect = CGRectMake(0.0f, 0.0f, self.size.width, self.size.height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, size.width, size.height, 8, 0, colorSpace, kCGBitmapAlphaInfoMask);
    CGColorSpaceRelease(colorSpace);
    
    CGContextDrawImage(context, rect, [self CGImage]);
    CGImageRef grayscale = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage * image = [UIImage imageWithCGImage:grayscale];
    CFRelease(grayscale);
    
    return image;
}


- (UIColor *)patternColor
{
    return [UIColor colorWithPatternImage:self];
}

+ (UIImage *)imageWithColor:(UIColor *)color
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    //   // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
//得到高斯模糊的图片
+ (UIImage *)filterImage:(UIImage *)image
{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:[NSNumber numberWithFloat:10.0] forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return newImage;
}
//得到图片上传信息(压缩0.1)
-(NSString *)getImageString
{
    NSData *pictureData = UIImageJPEGRepresentation(self,0.1);//进行图片压缩从0.0到1.0（0.0表示最大压缩，质量最低);
    NSString* pictureDataString = [pictureData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];//图片转码成为base64Encoding，
    //NSLog(@"%@++++是空值么？",pictureDataString);
    //NSLog(@"base64转码，的实验");
    return pictureDataString;
}
//压缩图片，发送数据
-(NSString *)getPostImageString
{
  UIImage *scanImage = [self getScanImage:self];
    NSData *pictureData = UIImageJPEGRepresentation(scanImage,1.0);//进行图片压缩从0.0到1.0（0.0表示最大压缩，质量最低);
        if (pictureData.length/1024>=1024) {
            pictureData = UIImageJPEGRepresentation(scanImage,MIN((1024*1024)/pictureData.length, 0.5));//进行图片压缩从0.0到1.0（0.0表示最大压缩，质量最低);
        }
    NSString* pictureDataString = [pictureData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];//图片转码成为base64Encoding，
    //NSLog(@"%@++++是空值么？",pictureDataString);
    return pictureDataString;
    
}
//压缩固定大小的图片
- (UIImage*)getScanImage:(UIImage *)sourceImage

{
    CGSize targetSize = CGSizeMake(640.0f, 640.0f);
    
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    
    CGFloat width = imageSize.width;
    
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    
    CGFloat scaledWidth = targetWidth;
    
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
        
    {
        
        CGFloat widthFactor = targetWidth / width;
        
        CGFloat heightFactor = targetHeight / height;
        
        
        if (widthFactor > heightFactor)
            
            scaleFactor = widthFactor; // scale to fit height
        
        else
            
            scaleFactor = heightFactor; // scale to fit width
        
        scaledWidth= width * scaleFactor;
        
        scaledHeight = height * scaleFactor;
        
        
        // center the image
        
        if (widthFactor > heightFactor)
            
        {
            
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
            
        }
        
        else if (widthFactor < heightFactor)
            
        {
            
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
            
        }
        
    }
    
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    
    CGRect thumbnailRect = CGRectZero;
    
    thumbnailRect.origin = thumbnailPoint;
    
    thumbnailRect.size.width= scaledWidth;
    
    thumbnailRect.size.height = scaledHeight;
    
    
    [sourceImage drawInRect:thumbnailRect];
    
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil)
        
        NSLog(@"could not scale image");
    
    
    //pop the context to get back to the default
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}
//绘制图像上的文字
-(UIImage *)addText:(NSString *)text andNickname:(NSString *)name
{
   UIImage *img = [self getScanImage:self];
    //上下文的大小
    CGFloat imgW = img.size.width;
    CGFloat imgH = img.size.height;
//    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();//创建颜色
//    //创建上下文
//    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 22 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
//    CGContextDrawImage(context, CGRectMake(0, 0, w, h),self.CGImage);//将img绘至context上下文中
//    //设置字体
//    CTFontRef font = CTFontCreateWithName(CFSTR("-"), 25, NULL);
//    NSString *strNS = text;
//    CFStringRef strRef = (__bridge CFStringRef)strNS;
//    
//    // Create an attributed string
//    CFStringRef keys[] = { kCTFontAttributeName };
//    CFTypeRef values[] = { font };
//    CFDictionaryRef attr = CFDictionaryCreate(NULL, (const void **)&keys, (const void **)&values,
//                                              sizeof(keys) / sizeof(keys[0]), &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
//    CFAttributedStringRef attrString = CFAttributedStringCreate(NULL, strRef, attr);
//    CFRelease(attr);
//    CGContextSetTextDrawingMode(context, kCGTextFillStroke);//设置字体绘制方式
//    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0); //白色
//    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);//设置字体绘制的颜色
//    // Draw the string
//    CTLineRef line = CTLineCreateWithAttributedString(attrString);
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);  //Use this one when using standard view coordinates
//    CGContextSetTextPosition(context, (w - 22.0f*text.length)/2, 30.0f);
//     CGContextSetLineWidth(context, 1.0);
//    CTLineDraw(line, context);
//    
//    // Clean up
//    CFRelease(line);
//    CFRelease(attrString);
//    CFRelease(font);
//    
//    //    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 44 * w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
//    //    CGContextDrawImage(context, CGRectMake(0, 0, w, h), img.CGImage);//将img绘至context上下文中
//    //    char* text = (char *)[text1 cStringUsingEncoding:NSUTF8StringEncoding];
//    //    // CGContextSelectFont(context, "Georgia", 30, kCGEncodingMacRoman);//设置字体的大小
//    //    CGContextSetTextDrawingMode(context, kCGTextFill);//设置字体绘制方式
//    //    CGContextSetRGBFillColor(context, 255, 0, 0, 1);//设置字体绘制的颜色
//    //
//    //    CGContextShowTextAtPoint(context, w/2-strlen(text)*5, h/2, text, strlen(text));//设置字体绘制的位置
//    CGContextSetRGBFillColor(context, 1.0, 1.0, 1.0, 1.0); //白色
//    CGContextSetRGBStrokeColor(context, 1.0, 1.0, 1.0, 1.0);//设置字体绘制的颜色
//    CGContextStrokePath(context);
//    CGContextFillPath(context);
//    //Create image ref from the context
//    CGImageRef imageMasked = CGBitmapContextCreateImage(context);//创建CGImage
//        CGContextRelease(context);
//    CGColorSpaceRelease(colorSpace);
//    return [UIImage imageWithCGImage:imageMasked];//获得添加水印后的图片
    
    CGSize size = CGSizeMake(imgW, imgH);          //设置上下文（画布）大小
    UIGraphicsBeginImageContext(size);                       //创建一个基于位图的上下文(context)，并将其设置为当前上下文
    CGContextRef contextRef = UIGraphicsGetCurrentContext(); //获取当前上下文
    CGContextTranslateCTM(contextRef, 0, imgH);   //画布的高度
    CGContextScaleCTM(contextRef, 1.0, -1.0);                //画布翻转
    CGContextDrawImage(contextRef, CGRectMake(0, 0, imgW, imgH), [img CGImage]);  //在上下文种画当前图片
    //上下文种的文字属性
    CGContextTranslateCTM(contextRef, 0, img.size.height);
    CGContextScaleCTM(contextRef, 1.0, -1.0);
    CGFloat currentFont = 32.0f;
    
//    //毛笔
//    UIFont *font = [UIFont fontWithName:@"-" size:currentFont];
//    UIFont *nameFont = [UIFont fontWithName:@"-" size:22.0f];
//
    //刘江硬笔草体
    UIFont *font = [UIFont fontWithName:@"LiuJiang-Cao-1.0" size:currentFont];
    UIFont *nameFont = [UIFont fontWithName:@"LiuJiang-Cao-1.0" size:22.0f];
//    //方正洪俊硬笔草体
//    UIFont *font = [UIFont fontWithName:@"FZZJ-HJYBXCJW" size:currentFont];
//    UIFont *nameFont = [UIFont fontWithName:@"FZZJ-HJYBXCJW" size:22.0f];

    
    
    
//    CTParagraphStyleSetting lineBreakMode;
//    CTLineBreakMode lineBreak = kCTLineBreakByCharWrapping; //换行模式
//    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
//    lineBreakMode.value = &lineBreak;
//    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
//    //行间距
//    CTParagraphStyleSetting LineSpacing;
//    CGFloat spacing = 4.0;  //指定间距
//    LineSpacing.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
//    LineSpacing.value = &spacing;
//    LineSpacing.valueSize = sizeof(CGFloat);
//    
//    CTParagraphStyleSetting settings[] = {lineBreakMode,LineSpacing};
//    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 2);
    /*
     1、NSFontAttributeName 字体（包括fontSize，fontName）；
     2、NSParagraphStyle 段落对齐方式，默认向左；
     3、NSForegroundColorAttributeName 字体颜色；
     4、NSStrokeColorAttributeName 和 NSStrokeWidthAttributeName必须同时使用，描边颜色；NSStrokeWidthAttributeName这个属性所对应的值是一个 NSNumber 对象(小数)。该值改变描边宽度（相对于字体size 的百分比）。默认为 0，即不改变。正数只改变描边宽度。负数同时改变文字的描边和填充宽度。例如，对于常见的空心字，这个值通常为3.0。
     同时设置了空心的两个属性，并且NSStrokeWidthAttributeName属性设置为整数，文字前景色就无效果了
     5、NSVerticalGlyphFormAttributeName 排列方式，目前ios仅支持横向，默认是0
     
     */
    NSDictionary* dic = @{NSFontAttributeName:font,NSParagraphStyleAttributeName:[NSParagraphStyle defaultParagraphStyle],NSForegroundColorAttributeName:Color_White,NSStrokeColorAttributeName:Color_Basic,NSStrokeWidthAttributeName:@-0.5,NSVerticalGlyphFormAttributeName:@(0)};
  
    NSDictionary* nameDic = @{NSFontAttributeName:nameFont,NSParagraphStyleAttributeName:[NSParagraphStyle defaultParagraphStyle],NSForegroundColorAttributeName:Color_White,NSStrokeColorAttributeName:Color_Basic,NSStrokeWidthAttributeName:@-0.5,NSVerticalGlyphFormAttributeName:@(0)};

    CGSize nameSize = [CommonUtil getLabelSizeWithString:name andLabelWidth:20.0f andFont:nameFont];
    //分列显示，最多每8个为一列
    int count = text.length/8+1;
    //切割文本
    for (int j=0; j<count; j++) {
        NSString *subTxt = [text substringWithRange:NSMakeRange(j*8,MIN(8,abs((int)text.length-j*8)))];
        [subTxt drawInRect:CGRectMake(img.size.width - (j+1)*40.0f - 45.0f, 20.0f, 40.0f, img.size.height - 40.0f) withAttributes:dic];       //此处设置文字显示的位置
    }
    //添加昵称
    [name drawInRect:CGRectMake( 28.0f, img.size.height - nameSize.height - 70.0f, 25.0f, nameSize.height) withAttributes:nameDic];       //此处设置文字显示的位置

    UIImage *targetimg =UIGraphicsGetImageFromCurrentImageContext();  //从当前上下文种获取图片
    UIGraphicsEndImageContext();//移除栈顶的基于当前位图的图形上下文。

    return [self addImage:targetimg addMsakImage:[UIImage imageNamed:@"icon_sign"]];
}

- (UIImage *)addImage:(UIImage *)useImage addMsakImage:(UIImage *)maskImage
{
    UIGraphicsBeginImageContext(useImage.size);
    [useImage drawInRect:CGRectMake(0, 0, useImage.size.width, useImage.size.height)];
    
    //四个参数为水印图片的位置
    [maskImage drawInRect:CGRectMake(22.0f, useImage.size.height - 60.0f, 35.5f, 49.5f)];
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultingImage;
}

@end
