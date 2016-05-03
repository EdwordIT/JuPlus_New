//
//  PostViewController.m
//  SCCaptureCameraDemo
//
//  Created by Aevitx on 14-1-21.
//  Copyright (c) 2014年 Aevitx. All rights reserved.
//

#import "PostViewController.h"
#import "ImageFilterProcessViewController.h"
@interface PostViewController ()<ImageFitlerProcessDelegate>
//图片编辑
@property (nonatomic,strong)UIImageView *backImage;
//滤镜、标签处理
@property (nonatomic,strong)JuPlusUIView *bottomView;
//下一步
@property (nonatomic,strong)UIButton *nextBtn;
//滤镜
@property (nonatomic,strong)UIButton *filterBtn;
//标签
@property (nonatomic,strong)UIButton *labelBtn;
@end

@implementation PostViewController

-(UIImageView *)backImage
{
    if(!_backImage)
    {
        _backImage = [[UIImageView alloc]init];
        _backImage.clipsToBounds = YES;
        _backImage.contentMode = UIViewContentModeScaleAspectFill;
        _backImage.frame = CGRectMake(0, self.navView.bottom, SCREEN_WIDTH, PICTURE_HEIGHT);
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
        _filterBtn.frame = CGRectMake( 100.0f, 50.0f, 27.0f, 45.0f);
        [_filterBtn setImage:[UIImage imageNamed:@"camera_tag_01"] forState:UIControlStateNormal];
        [_filterBtn addTarget:self action:@selector(filterBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _filterBtn;
}
-(UIButton *)labelBtn
{
    if(!_labelBtn)
    {
        _labelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _labelBtn.frame = CGRectMake( SCREEN_WIDTH - 100.0f - 27.0f, 50.0f, 27.0f, 45.0f);
        [_labelBtn setImage:[UIImage imageNamed:@"camera_tag_02"] forState:UIControlStateNormal];
        [_labelBtn addTarget:self action:@selector(labelBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _labelBtn;
}

-(UIButton *)nextBtn
{
    if(!_nextBtn)
    {
        _nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _nextBtn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
        [_nextBtn.titleLabel setFont:FontType(FontSize)];
        [_nextBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_nextBtn setTitle:@"下一步" forState:UIControlStateNormal];
        [_nextBtn setBackgroundColor:Color_Basic];
        _nextBtn.alpha = ALPHLA_BUTTON;
        [_nextBtn addTarget:self action:@selector(nextPress) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _nextBtn;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.titleLabel setText:@"发布作品"];
    
    [self.view addSubview:self.backImage];
    
    [self.view addSubview:self.bottomView];
    
    [self.bottomView addSubview:self.filterBtn];
    [self.bottomView addSubview:self.labelBtn];
    
    [self.view addSubview:self.nextBtn];
    
    [self.backImage setImage:self.postImage];
//    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    backBtn.frame = CGRectMake(0, self.view.frame.size.height - 40, 80, 40);
//    [backBtn setTitle:@"back" forState:UIControlStateNormal];
//    [backBtn addTarget:self action:@selector(backBtnPressed:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:backBtn];
    
}
//滤镜
-(void)filterBtnPress:(UIButton *)sender
{
    ImageFilterProcessViewController *fitler = [[ImageFilterProcessViewController alloc] init];
    [fitler setDelegate:self];
    fitler.currentImage = self.postImage;
    [self.navigationController pushViewController:fitler animated:YES];

}
- (void)imageFitlerProcessDone:(UIImage *)image
{
    [self.backImage setImage:image];
}
//标签
-(void)labelBtnPress:(UIButton *)sender
{
    
}
//下一步
-(void)nextPress
{
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)backBtnPressed:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}






@end
