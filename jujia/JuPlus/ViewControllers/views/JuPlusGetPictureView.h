//
//  AtzucheGetImageView.h
//  Autoyol
//
//  Created by 詹文豹 on 15-4-9.
//  Copyright (c) 2015年 Autoyol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JuPlusGetPictureDelegate <NSObject>

-(void)sendImage:(UIImage *)image;

@end

@interface JuPlusGetPictureView : UIView<UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
-(void)showView;
@property(nonatomic,strong)UIActionSheet *actionSheet;
@property(nonatomic,assign)id<JuPlusGetPictureDelegate>delegate;

@end
