//
//  ViewController.m
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-18.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import "CameraViewController.h"
#import "PostViewController.h"
#import "ImageCropper.h"
#import "ImageFilterProcessViewController.h"
@interface CameraViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
//图片编辑
@property (nonatomic,strong)UIButton *backImage;
//滤镜、标签处理
@property (nonatomic,strong)JuPlusUIView *bottomView;
//下一步
@property (nonatomic,strong)UIButton *nextBtn;
//拍照
@property (nonatomic,strong)UIButton *filterBtn;
//相册
@property (nonatomic,strong)UIButton *labelBtn;
//弹出
@property(nonatomic,strong)UIActionSheet *actionSheet;

@end

@implementation CameraViewController

-(UIButton *)backImage
{
    if(!_backImage)
    {
        _backImage = [UIButton buttonWithType:UIButtonTypeCustom];
        _backImage.clipsToBounds = YES;
        _backImage.frame = CGRectMake(0, self.navView.bottom, SCREEN_WIDTH, PICTURE_HEIGHT);
        _backImage.contentMode = UIViewContentModeScaleAspectFill;
        [_backImage setImage:[UIImage imageNamed:@"bg_upload.jpg"] forState:UIControlStateNormal];
        [_backImage setImage:[UIImage imageNamed:@"bg_upload.jpg"] forState:UIControlStateHighlighted];
        [_backImage addTarget:self action:@selector(showActionSheet:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _backImage;
}
-(JuPlusUIView *)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.backImage.bottom, SCREEN_WIDTH, view_height - self.backImage.bottom - TABBAR_HEIGHT)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(UIButton *)filterBtn
{
    if(!_filterBtn)
    {
        _filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _filterBtn.frame = CGRectMake( 80.0f, 50.0f, 29.0f, 45.0f);
        [_filterBtn setImage:[UIImage imageNamed:@"tag_carmera"] forState:UIControlStateNormal];
        [_filterBtn addTarget:self action:@selector(btnPressed:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _filterBtn;
}
-(UIButton *)labelBtn
{
    if(!_labelBtn)
    {
        _labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _labelBtn.frame = CGRectMake( SCREEN_WIDTH - 80.0f - 29.0f, 50.0f, 27.0f, 45.0f);
        [_labelBtn setImage:[UIImage imageNamed:@"tag_album"] forState:UIControlStateNormal];
        [_labelBtn addTarget:self action:@selector(labelBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _labelBtn;
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
//


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.titleLabel setText:@"发布作品"];
    
    [self configureNotification:YES];
    
    [self.view addSubview:self.backImage];
    
    [self.view addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.filterBtn];
    [self.bottomView addSubview:self.labelBtn];
    
    
    
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        
        [self btnPressed:self.filterBtn];
    
    }
    else if(buttonIndex ==1)
    {
        [self labelBtnPress:self.labelBtn];
    }
    else
    {
    
    }

    [actionSheet setHidden:YES];
}
//弹出actionsheet
-(void)showActionSheet:(UIButton *)sender
{
    [self.actionSheet showFromRect:self.view.bounds inView:self.view animated:YES];
}
//拍照
- (void)btnPressed:(id)sender {
    SCNavigationController *nav = [[SCNavigationController alloc] init];
    nav.scNaigationDelegate = self;
    [nav showCameraWithParentController:self];
}
//相册
-(void)labelBtnPress:(UIButton *)sender
{
    
    UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    if (![UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary]) {
        sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    //sourceType = UIImagePickerControllerSourceTypeCamera; //照相机
    sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //相片库
    //sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum; //保存的相片
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing=YES;
    picker.sourceType = sourceType;
    [self presentViewController:picker animated:YES completion:nil];
}
#pragma mark --imagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
    didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:NO completion:nil];
    
    UIImage * image=[info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    //[fitler setDelegate:self];
    fitler.currentImage = image;
    [self.navigationController pushViewController:fitler animated:YES];
//    PostViewController *post = [[PostViewController alloc]init];
//    post.postImage = image;
//    [self.navigationController pushViewController:post animated:YES];
    
//由于系统自带有截屏功能，因此不需要再重新截屏
//    ImageCropper *cropper = [[ImageCropper alloc] initWithImage:image];
//    [cropper setDelegate:self];
//    
//    [self presentViewController:cropper animated:YES completion:^{
//        
//    }];

}
/*
//裁剪过后
- (void)imageCropper:(ImageCropper *)cropper didFinishCroppingWithImage:(UIImage *)image {
    PostViewController *post = [[PostViewController alloc]init];
    post.postImage = image;
    [self.navigationController pushViewController:post animated:YES];
}

- (void)imageCropperDidCancel:(ImageCropper *)cropper {
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault animated:YES];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
*/
- (void)dealloc {
    [self configureNotification:NO];
    [super dealloc];
}

- (void)configureNotification:(BOOL)toAdd {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNotificationTakePicture object:nil];
    if (toAdd) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(callbackNotificationForFilter:) name:kNotificationTakePicture object:nil];
    }
}

- (void)callbackNotificationForFilter:(NSNotification*)noti {
    UIViewController *cameraCon = noti.object;
    if (!cameraCon) {
        return;
    }
    UIImage *finalImage = [noti.userInfo objectForKey:kImage];
    if (!finalImage) {
        return;
    }
    PostViewController *con = [[PostViewController alloc] init];
    con.postImage = finalImage;
    
    if (cameraCon.navigationController) {
        [cameraCon.navigationController pushViewController:con animated:YES];
    } else {
        [cameraCon presentViewController:con animated:YES completion:^{
            
        }];
    }
}
#pragma mark - SCNavigationController delegate
- (void)didTakePicture:(SCNavigationController *)navigationController image:(UIImage *)image {
    
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
   // [fitler setDelegate:self];
    fitler.currentImage = image;
    [navigationController pushViewController:fitler animated:YES];

//    PostViewController *con = [[PostViewController alloc] init];
//    con.postImage = image;
//    [navigationController pushViewController:con animated:YES];
    
}

@end
