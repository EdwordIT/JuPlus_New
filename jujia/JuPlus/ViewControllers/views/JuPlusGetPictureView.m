//
//  AtzucheGetImageView.m
//  Autoyol
//
//  Created by 詹文豹 on 15-4-9.
//  Copyright (c) 2015年 Autoyol. All rights reserved.
//

#import "JuPlusGetPictureView.h"

@implementation JuPlusGetPictureView
-(id)init
{
    self = [super init];
    if(self)
    {
        self.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
    }
    return self;
}
-(UIActionSheet *)actionSheet
{
    if(!_actionSheet)
    {
        _actionSheet = [[UIActionSheet alloc]initWithTitle:@"请选择" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"相机拍摄" otherButtonTitles:@"相片库", nil];
        _actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;

    }
    return _actionSheet;
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //相片库
        //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing=YES;
        picker.sourceType = sourceType;
        [[self getSuperViewController] presentViewController:picker animated:YES completion:nil];
        
        
    }else if (buttonIndex == 1) {
        //先设定sourceType为相机，然后判断相机是否可用（ipod）没相机，不可用将sourceType设定为相片库
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        
        if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
        //sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //相片库
        //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing=YES;
        picker.sourceType = sourceType;
        [[self getSuperViewController] presentViewController:picker animated:YES completion:nil];
    }
    [self setHidden:YES];
}
//调用相机
#pragma mark Camera View Delegate Methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage * image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    //不用压缩
    if(_delegate&&[_delegate respondsToSelector:@selector(sendImage:)])
    {
        [_delegate sendImage:image];
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
-(void)showView
{
    [self.actionSheet showInView:self];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
