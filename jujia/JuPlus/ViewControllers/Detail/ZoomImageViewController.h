//
//  ImageSCrollViewController.h
//  JuPlus
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VIPhotoView.h"
@interface ZoomImageViewController : UIViewController<UIScrollViewDelegate,UIApplicationDelegate>
{
    UIScrollView *myScrollView;
    UIImageView *selImageView;
    
}
@property (nonatomic,strong)NSArray *imageDataArray;
@property (nonatomic,assign)NSInteger tag;

@end
