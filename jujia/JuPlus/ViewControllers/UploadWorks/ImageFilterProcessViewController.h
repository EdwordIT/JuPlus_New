//
//  ImageFilterProcessViewController.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import "JuPlusUIViewController.h"
@protocol ImageFitlerProcessDelegate;
@interface ImageFilterProcessViewController : JuPlusUIViewController
{
    UIImageView *rootImageView;
    UIScrollView *scrollerView;
    UIImage *currentImage;
    id <ImageFitlerProcessDelegate> delegate;
}
@property(nonatomic,assign) id<ImageFitlerProcessDelegate> delegate;
@property(nonatomic,retain)UIImage *currentImage;
@end

@protocol ImageFitlerProcessDelegate <NSObject>

- (void)imageFitlerProcessDone:(UIImage *)image;
@end
