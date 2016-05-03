//
//  JuPlusUIView.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"
#define statusY 20.0f
#import "LoginViewController.h"
@implementation JuPlusUIView
{
    NSString *appUrl;
}
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        [self addSubview:self.navView];
        self.backgroundColor = [UIColor whiteColor];
        [self.navView addSubview: self.titleLabel];
        [self.navView addSubview:self.leftBtn];
        [self.navView addSubview:self.rightBtn];
        [self addSubview:self.reloadImage];
    }
    return self;
}
-(UIView *)navView
{
    if(!_navView)
    {
        _navView = [[UIView alloc]initWithFrame:CGRectMake(0.0f,20.0f - statusY, SCREEN_WIDTH, 44.0f+statusY)];
        [_navView setBackgroundColor:RGBACOLOR(255, 255, 255, 0.9)];
        UIView *bottom = [[UIView alloc]initWithFrame:CGRectMake(0.0f, _navView.height - 1.0f, _navView.width, 1.0f)];
        [bottom setBackgroundColor:RGBCOLOR(247, 247, 247)];
        [_navView addSubview:bottom];
        [_navView setHidden:YES];
    }
    return _navView;
}
//标题
-(UILabel *)titleLabel
{
    CGFloat titleWidth = 120.0f;
    if(!_titleLabel)
    {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake((self.width - titleWidth)/2, 20.0f, titleWidth, 44.0f)];
        _titleLabel.backgroundColor = [UIColor clearColor];
        [_titleLabel setFont:FontType(FontSize)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
    
}
-(UIButton *)leftBtn
{
    if(!_leftBtn)
    {
        _leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _leftBtn.frame = CGRectMake(0.0f, statusY, 44.0f, 44.0f);
    }
    return _leftBtn;
}
-(UIButton *)rightBtn
{
    if(!_rightBtn)
    {
        _rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _rightBtn.frame = CGRectMake(self.navView.width - 44.0f, statusY, 44.0f, 44.0f);
    }
    return _rightBtn;
}
-(UIView *)noDataImage
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
        _reloadImage = [[UIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, self.width, view_height)];
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
        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, label1.bottom+10.0f, SCREEN_WIDTH, 30.0f)];
        [label2 setTextAlignment:NSTextAlignmentCenter];
        [label2 setFont:FontType(FontSize)];
        
        [label2 setText:@"刷新试试 重启看看 喝点热水"];
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

#pragma 网络加载
-(void)startHomePageRequest
{
    
}
//提示信息显示
- (void)showAlertView:(NSString *)msg withTag:(int)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:msg delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    alert.tag=tag;
    [alert show];
}
//返回数据后台提示的错误信息处理
-(void)errorExp:(ErrorInfoDto *)exp
{
    NSLog(@"reason = %@",exp.resMsg);
    //如果是网络请求失败(即为连接到后台，不是后台返回错误)
    if ([exp.resCode integerValue]==ERROR_SERVER_OUT) {
        [self.reloadImage setHidden:NO];
        [self bringSubviewToFront:self.reloadImage];
    }else
    {
        if([exp.resCode integerValue] ==ERROR_VERSON_OUT){
            appUrl = exp.downloadUrl;
        }
        //如果是后台返回的错误编码（得到的数据不是需要呈现的数据）
        if ([exp.reqMethod isEqualToString:@"GET"])
        {
            self.noDataImage.hidden=NO;
            [self bringSubviewToFront:self.noDataImage];
        }
        [self showAlertView:exp.resMsg withTag:[exp.resCode integerValue]];
    }
}
//一些系统的弹出处理,例如强制更新，登录失败
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int alertTag = alertView.tag;
    //token失效处理
    if (alertTag==ERROR_TOKEN_INVALID) {
        [[JuPlusUserInfoCenter sharedInstance] resetUserInfo];
        LoginViewController *log = [[LoginViewController alloc]init];
        [[self getSuperViewController].navigationController pushViewController:log animated:YES];
    }
    //版本过低，强制更新
    else if(alertTag==ERROR_VERSON_OUT)
    {
        NSString* path=appUrl;
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:path]];
    }
    else if (alertTag==ERROR_NO_COLLOCATION||alertTag==ERROR_NO_PRODUCT)
    {
        [self.viewController.navigationController popViewControllerAnimated:YES];
    }
}
@end
