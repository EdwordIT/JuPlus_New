//
//  ImportViewController.m
//  JuPlus
//
//  Created by admin on 15/9/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "ImportViewController.h"
#import "GuideViewController.h"
#import "HomeFurnishingViewController.h"
#import "FirstImgReq.h"
#import "FirstImgRespon.h"
#import "UIImage+JuPlusUIImage.h"
@interface ImportViewController ()
{
    UIImageView *bottom;
    UIImageView *left;
    UIImageView *right;
    UIImageView *backImg;
}
@end

@implementation ImportViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navView removeFromSuperview];
    [self loadAnimationView];
    // Do any additional setup after loading the view.
}
-(void)startRequestLoadImg
{
    [UIView animateWithDuration:1.0f animations:^{
        left.alpha = 0.0f;
        right.alpha = 0.0f;
        bottom.alpha = 0.0f;
    } completion:^(BOOL finished) {
        self.view.backgroundColor = [UIColor clearColor];
        [left removeFromSuperview];
        [right removeFromSuperview];
        [bottom removeFromSuperview];
        FirstImgReq *req = [[FirstImgReq alloc]init];
        FirstImgRespon *respon = [[FirstImgRespon alloc]init];
        [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
            if (!IsStrEmpty(respon.imgUrl)) {
                backImg = [[UIImageView alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
                [self.view addSubview:backImg];
            
                [backImg setimageUrl:respon.imgUrl placeholderImage:nil];
                
                [self performSelector:@selector(goNext) withObject:nil afterDelay:2.0];
                
            }else
            {
                [self performSelector:@selector(goNext) withObject:nil];
            }
        } failed:^(ErrorInfoDto *errorDTO) {
            [self performSelector:@selector(goNext) withObject:nil];
        } showProgressView:NO with:self.view];
    }];
    
}
-(void)loadAnimationView
{
    bottom = [[UIImageView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    if (iphone5) {
        bottom.image = [UIImage imageNamed:@"Default-568h"];
    }else if(iphone6){
        bottom.image = [UIImage imageNamed:@"Default-667"];
    }else if(iphone6P){
        bottom.image = [UIImage imageNamed:@"Default-736"];
    }else{
        bottom.image = [UIImage imageNamed:@"Default"];
    }
    //添加到场景
    [self.view addSubview:bottom];
    //放到最顶层;
    [self.view bringSubviewToFront:left];    //设置一个图片;
    left = [[UIImageView alloc] initWithFrame:CGRectMake(60.0f,SCREEN_HEIGHT/2+55.0f, 25.0f, 55.0f)];
    left.image = [UIImage imageNamed:@"Default_left"];
    //添加到场景
    [self.view addSubview:left];
    //放到最顶层;
    [self.view bringSubviewToFront:left];
    
    right = [[UIImageView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2,SCREEN_HEIGHT/2, 25.0f, 55.0f)];
    right.image = [UIImage imageNamed:@"Default_right"];
    right.alpha = 0.0f;
    //添加到场景
    [self.view addSubview:right];
    //放到最顶层;
    [self.view bringSubviewToFront:right];
    
    [UIView animateWithDuration:1.5f animations:^{
        right.alpha = 1.0f;
        left.frame = CGRectMake(SCREEN_WIDTH/2 - 25.0f, left.top, left.width, left.height);
    } completion:^(BOOL finished) {
        
        [self performSelector:@selector(startRequestLoadImg) withObject:nil afterDelay:1.0];
        
    }];
}

-(void)goNext
{
//    [UIView animateWithDuration:1.0f animations:^{
//        left.alpha = 0.0f;
//        right.alpha = 0.0f;
//        bottom.alpha = 0.0f;
//    } completion:^(BOOL finished) {
//        self.view.backgroundColor = [UIColor clearColor];
//        [left removeFromSuperview];
//        [right removeFromSuperview];
//        [bottom removeFromSuperview];
        //程序第一次启动
        if([CommonUtil getUserDefaultsValueWithKey:GetAppVerson]==nil||(![[CommonUtil getUserDefaultsValueWithKey:GetAppVerson] isEqualToString:VERSION_STRING]))
        {
            //版本更新或者第一次运行走引导页
            [self runGuideMethod];
            [CommonUtil setUserDefaultsValue:VERSION_STRING forKey:GetAppVerson];
        }
        else
        {
            // 正常流程
            [self runNormalMethod];
        }
        
  //  }];
    
}
//引导页
-(void)runGuideMethod
{
    GuideViewController *guide=[[GuideViewController alloc]init];
    [self.navigationController pushViewController:guide animated:NO];
}
//正常打开首页
-(void)runNormalMethod
{
    HomeFurnishingViewController *home = [[HomeFurnishingViewController alloc]init];
    [self.navigationController pushViewController:home animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
