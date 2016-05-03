//
//  AutoyolProgressView.h
//  progress
//
//  Created by 詹文豹 on 14-4-23.
//  Copyright (c) 2014年 詹文豹. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface JuPlusLoadingView : UIImageView
-(void)showActivityViewFrame:(CGRect)frame AndTag:(int)vieTag;
-(void)hideActivityView;
@end
