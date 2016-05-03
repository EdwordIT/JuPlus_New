//
//  UIImageView+JuPlusUIImageView.h
//  JuPlus
//
//  Created by admin on 15/7/1.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIImage+JuPlusUIImage.h"
#import "UIImageView+WebCache.h"
@interface UIImageView (JuPlusUIImageView)
-(void)setimageUrl:(NSString *)url placeholderImage:(NSString *)defalutImage;
-(void)setLayerImage;
@end
