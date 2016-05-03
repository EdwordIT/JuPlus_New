//
//  SettingViewController.m
//  JuPlus
//
//  Created by admin on 15/10/22.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "SettingViewController.h"
#import "InfoChangeV.h"
#import "GuideViewController.h"
#import "AboutUsViewController.h"
@interface SettingViewController ()
{
    UILabel *cacheLabel;
}
@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:@"个人设置"];
    
    // Do any additional setup after loading the view.
}
-(void)loadBaseUI
{
    self.view.backgroundColor = Color_Bottom;

    NSArray *titleArr = [NSArray arrayWithObjects:@"清除缓存",@"关于我们",@"教程指导",@"官人点个赞", nil];
    CGFloat space = 20.f;
    CGFloat viewH = 50.f;
    for (int i=0; i<4; i++) {
        CGFloat orignY = space + viewH*i+nav_height;
        if (i==3) {
            orignY +=10.f;
        }
        InfoChangeV *info = [[InfoChangeV alloc]initWithFrame:CGRectMake(0.0f, orignY, self.view.width, viewH)];
        [self.view addSubview:info];
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(space, 10.0f, 27.f, 27.f)];
        img.layer.cornerRadius = img.width/2;
        img.layer.masksToBounds = YES;
        [img setImage:[UIImage imageNamed:[NSString stringWithFormat:@"setting_0%d",i+1]]];
        [info addSubview:img];
        CGRect frame = info.titleL.frame;
        frame.origin.x = img.right+space/2;
        info.titleL.frame = frame;
        
        info.clickBtn.tag = i;
        [info.titleL setText:[titleArr objectAtIndex:i]];
        [info.clickBtn addTarget:self action:@selector(settingPress:) forControlEvents:UIControlEventTouchUpInside];
        
        if (i ==0) {
            //清除缓存
            float tmpSize = ([[SDImageCache sharedImageCache] getSize]/1024.f)/1024.f;
            if (tmpSize>0) {
                
                NSString *clearCache = tmpSize>1?[NSString stringWithFormat:@"%.2fM",tmpSize]:[NSString stringWithFormat:@"%.2fK",tmpSize*1024];
                cacheLabel = info.textL;
                [info.textL setText:clearCache];
            }
            
            
        }
    }
}
-(void)settingPress:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            if (!IsStrEmpty(cacheLabel.text)) {
                NSString *clearCache = [NSString stringWithFormat:@"清除所有%@缓存？",cacheLabel.text];
                UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:clearCache delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alt.tag = 101;
                [alt show];

            }else
                [self showAlertView:@"暂无缓存内容" withTag:0];
                   }
            break;
        case 1:
        {
            //关于我们
            AboutUsViewController *about = [[AboutUsViewController alloc]init];
            [self.navigationController pushViewController:about animated:YES];
        }
            break;
        case 2:
        {
            //教程指导
            GuideViewController *guide = [[GuideViewController alloc]init];
            guide.isFromSetting = YES;
            [self.navigationController pushViewController:guide animated:YES];
        }
            break;
        case 3:
        {
            //点赞
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:
                                                        APP_URL]];
        }
            break;
        default:
            break;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==101) {
        if (buttonIndex==1) {
            [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                [self showAlertView:@"清理缓存完成" withTag:0];
                [cacheLabel setText:@""];
            }];
        }
    }
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
