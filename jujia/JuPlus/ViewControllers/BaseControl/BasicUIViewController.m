//
//  BasicUIViewController.m
//  JuPlus
//
//  Created by admin on 15/8/14.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "BasicUIViewController.h"

@interface BasicUIViewController ()

@end

@implementation BasicUIViewController
{
    CGFloat statusY;
    NSString *appUrl;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    statusY = 20.0f;
    self.view.backgroundColor = Color_White;
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar addSubview:self.navView];
    [self.navView addSubview: self.titleLabel];
    [self.navView addSubview:self.leftBtn];
    [self.navView addSubview:self.rightBtn];
    [self.view addSubview:self.reloadImage];
    [self loadBaseUI];
    self.navigationController.navigationBarHidden = NO;
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //self.navigationController.navigationBarHidden = NO;
    [self startRequest];
}
//需要重写的init方法(自动调用，只要重写就行)
-(void)loadBaseUI
{
    
}
//网络请求
-(void)startRequest
{
    
}
-(UIButton *)leftBtn
{
    if(!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0.0f, statusY, 44.0f, 44.0f);
        [_leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [_leftBtn addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn
{
    if(!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.navView.width - 54.0f, statusY, 44.0f, 44.0f);
        [_rightBtn.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:FontSize]];
        [_rightBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        UIView *black = [[UIView alloc]initWithFrame:CGRectMake((_rightBtn.width - 15.0f)/2, 42.0f, 15.0f, 2.0f)];
        [black setBackgroundColor:Color_Basic];
        [_rightBtn addSubview:black];
        [_rightBtn setHidden:YES];
    }
    return _rightBtn;
}
-(void)backPress
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(UIView *)navView
{
    if(!_navView)
    {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0 - statusY, SCREEN_WIDTH, 44.0f+statusY)];
        [_navView setBackgroundColor:RGBACOLOR(255, 255, 255, 0.8)];
        UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0.0f, _navView.height - 1.0f, _navView.width, 1.0f)];
        [bottom setBackgroundColor:RGBCOLOR(247, 247, 247)];
        [_navView addSubview:bottom];
    }
    return _navView;
}
//标题
-(UILabel *)titleLabel
{
    CGFloat titleWidth = 120.0f;
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.view.width - titleWidth)/2, 20.0f, titleWidth, 44.0f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setFont:FontType(FontSize)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
    
}
-(UIImageView *)noDataImage
{
    if(!_noDataImage)
    {
        CGFloat W = 85.0f;
        _noDataImage = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - W)/2, 60.0f, W, W)];
        [_noDataImage setImage:[UIImage imageNamed:@"noData"]];
    }
    return _noDataImage;
}
//重置暂无数据的frame
-(void)setNoDataImageFrame:(UITableView *)tab
{
    CGRect frame1 = self.noDataImage.frame;
    frame1.origin.y = (tab.frame.size.height - frame1.size.height)/2;
    self.noDataImage.frame = frame1;
}
-(UIView *)reloadImage
{
    if(!_reloadImage)
    {
        _reloadImage = [[UIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, self.view.width, view_height)];
        _reloadImage.backgroundColor = [UIColor whiteColor];
        _reloadImage.userInteractionEnabled = YES;
        
        CGFloat W = 85.0f;
        
        UIImageView *imgV = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - W)/2, (view_height - W)/2 - 80.0f, W, W)];
        [imgV setImage:[UIImage imageNamed:@"reloadImage"]];
        [_reloadImage addSubview:imgV];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, imgV.bottom+10.0f, SCREEN_WIDTH, 30.0f)];
        [label1 setTextAlignment:NSTextAlignmentCenter];
        [label1 setFont:FontType(FontMaxSize)];
        [label1 setText:@"网络错误"];
        [_reloadImage addSubview:label1];
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, imgV.bottom+10.0f, SCREEN_WIDTH, 30.0f)];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [label2 setFont:FontType(FontSize)];
        [label1 setText:@"刷新试试 重启看看 喝点热水"];
        [_reloadImage addSubview:label2];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGesture:)];
        [_reloadImage addGestureRecognizer:tap];
        [_reloadImage setHidden:YES];
    }
    return _reloadImage;
}
//重新加载本界面内容
-(void)tapGesture:(UIGestureRecognizer *)ges
{
    [self reloadNetWorkError];
}
-(void)reloadNetWorkError
{
    
}

//提示信息显示
- (void)showAlertView:(NSString *)msg withTag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
    alert.tag=tag;
    [alert show];
}
-(void)errorExp:(ErrorInfoDto *)exp
{
    NSLog(@"reason = %@",exp.resMsg);
    //如果是网络请求失败(即为连接到后台，不是后台返回错误)
    if ([exp.resCode integerValue]==ERROR_SERVER_OUT) {
        [self.reloadImage setHidden:NO];
        [self.view bringSubviewToFront:self.reloadImage];
    }else
    {
        if([exp.resCode integerValue] ==ERROR_VERSON_OUT){
            appUrl = exp.downloadUrl;
        }
        //如果是后台返回的错误编码（得到的数据不是需要呈现的数据）
        if ([exp.reqMethod isEqualToString:@"GET"])
        {
            self.noDataImage.hidden=NO;
            [self.view bringSubviewToFront:self.noDataImage];
        }
        [self showAlertView:exp.resMsg withTag:[exp.resCode integerValue]];
    }
}
//一些系统的弹出处理,例如强制更新，登录失败
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //token失效处理
    if (alertView.tag==ERROR_TOKEN_INVALID) {
        [[JuPlusUserInfoCenter sharedInstance] resetUserInfo];
        LoginViewController *log = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
    }
    //版本过低，强制更新
    else if(alertView.tag==ERROR_VERSON_OUT)
    {
        NSString* path=appUrl;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
    } //单品或者套餐详情不存在
    else if (alertView.tag==ERROR_NO_COLLOCATION||alertView.tag==ERROR_NO_PRODUCT)
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //self.navigationController.navigationBarHidden = YES;
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
