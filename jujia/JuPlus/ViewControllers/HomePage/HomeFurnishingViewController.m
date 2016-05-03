//
//  HomeFurnishingViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/19.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HomeFurnishingViewController.h"
#import "RegisterViewController.h"
#import "LoginViewController.h"
#import "UMSocial.h"
#import "UMSocialScreenShoter.h"
#import "BasicUIViewController.h"
#import "CameraViewController.h"
#import <CoreText/CoreText.h>
#import "DesignerMapView.h"
#import "APService.h"
#import "GetVersionReq.h"
#import "GetVersionRespon.h"
@interface HomeFurnishingViewController()<UMSocialUIDelegate>
{
    DesignerMapView *design;
    
    BOOL isShowMap;
    
    NSInteger remindTag;
    
    GetVersionRespon *versionRespon;
}
@end

@implementation HomeFurnishingViewController
{
    JuPlusUIView *backV;
}
-(void)viewDidLoad
{
    [super viewDidLoad];
   
    self.viewArray = [[NSMutableArray alloc]init];
    [self UIConfig];
}
-(void)rightPress
{

}
#pragma mark --版本检测
-(void)checkVersion
{
    //版本更新，每天提示一次
    NSDate *date=[NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:@"yyyyMMdd"];
    NSString *str=[NSString stringWithFormat:@"%@",[formatter stringFromDate:date]];
    if ([str isEqualToString:[CommonUtil getUserDefaultsValueWithKey:CheckAppVersion]]) {
        //已经提示了
        
    }else{
        GetVersionReq *versionReq = [[GetVersionReq alloc]init];
        [versionReq setField:@"IOS" forKey:@"platform"];
        versionRespon = [[GetVersionRespon alloc]init];
        [HttpCommunication request:versionReq getResponse:versionRespon Success:^(JuPlusResponse *response) {
            //添加标记，今天已经提示过
            [CommonUtil setUserDefaultsValue:str forKey:CheckAppVersion];

        if ([versionRespon.internalNo integerValue]>VERSION_INT) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:versionRespon.versionInfo delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"去更新", nil];
            alert.tag=VERSION_UPDATE;
            [alert show];
        }
    } failed:^(ErrorInfoDto *errorDTO) {
        //
    } showProgressView:NO with:self.view];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==VERSION_UPDATE) {
        if (buttonIndex==1) {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:versionRespon.downLink]];
        }
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:NO];
    }
}
-(void)UIConfig
{
    //  @param value 清除JPush服务器对badge值的设定.
    [APService resetBadge];
    //  本地仍须调用UIApplication:setApplicationIconBadgeNumber函数,来设置脚标数
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    [self.navView setHidden:YES];
    //如果此处直接用self.view则上层的标签选择页面也会随之变化，因此在self.view上加层透明view放置原来置于self.view层的内容，以方便处理高斯模糊效果
    backV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f,0.0f, SCREEN_WIDTH, self.view.height)];
    [self.view addSubview:backV];
    
    [backV addSubview:self.personCenterV];
    
    [backV addSubview:self.collectionV];

    
    [self.viewArray addObject:self.collectionV];
    [self.viewArray addObject:self.personCenterV];

    [backV addSubview:self.tabBarV];
    
    //原定标签选择按钮
    [self.collectionV.rightBtn addTarget:self action:@selector(classifyBtnPress:) forControlEvents:UIControlEventTouchUpInside];
    //个人中心
    [self.view addSubview:self.classifyV];
    [self.classifyV setHidden:YES];
    
     if (IsStrEmpty([CommonUtil getUserDefaultsValueWithKey:isShowClassify])) {
         [backV addSubview:self.remindView];
     }
    //版本检测
    [self checkVersion];
}
-(void)hiddenRemind
{
    [self.remindView removeFromSuperview];
}
-(UIImageView *)remindView
{
    if (!_remindView) {
        _remindView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _remindView.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        //[_remindView setImage:[UIImage imageNamed:@"remind_collocation"]];
        _remindView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenRemind)];
        [_remindView addGestureRecognizer:tap];
        [self loadRemindView];
        [CommonUtil setUserDefaultsValue:@"1" forKey:isShowClassify];
    }
    return _remindView;
}
-(void)loadRemindView
{
       UIImageView *remind3 = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f+30.0f, self.remindView.height - 139.0f - 30.0f, 160.0f, 139.0f)];
    remind3.tag = 3;
    [remind3 setImage:[UIImage imageNamed:@"remind_03"]];
    [_remindView addSubview:remind3];
    
    UIImageView *remind4 = [[UIImageView alloc]initWithFrame:CGRectMake(self.remindView.width - 219.0f -10.0f, 25.0f, 219.0f, 128.0f)];
    remind4.tag = 4;
    [remind4 setImage:[UIImage imageNamed:@"remind_04"]];
    [_remindView addSubview:remind4];
    remindTag = 1;
}
//九宫格相关
-(void)show
{
   [self.classifyV showClassify];
}

//标签选择界面
-(ClassifyView *)classifyV
{
    if(!_classifyV)
    {
        _classifyV = [[ClassifyView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT) andView:backV];
        _classifyV.backgroundColor = [UIColor clearColor];

    }
    return _classifyV;
}
//搭配界面（默认）
-(CollectionView *)collectionV
{
    if(!_collectionV)
    {
        _collectionV = [[CollectionView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    return _collectionV;
}
//个人中心
-(PersonCenterView *)personCenterV
{
    if(!_personCenterV)
    {
        _personCenterV = [[PersonCenterView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT)];
        
    }
    return _personCenterV;
}
-(JuPlusTabBarView *)tabBarV
{
    if(!_tabBarV)
    {
        _tabBarV = [[JuPlusTabBarView alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT - 49.0f, SCREEN_WIDTH, 49.0f)
                    ];
        _tabBarV.delegate = self;
        _tabBarV.backgroundColor = [UIColor clearColor];
    }
    return _tabBarV;
}
#pragma mark --ClickMethod
/*
 原来需求中的首页切换显示图章效果图，现在改为切换显示图片浏览 date:2016-03-17
 */
-(void)reloadCollectionTab
{
    
                [self.collectionV.listTab setHidden:!self.collectionV.listTab.hidden];
//                [self.collectionV.diagramsScroll setHidden:!self.collectionV.diagramsScroll.hidden];
    
//    //点击切换按钮，查看是否显示当前页面，如果不是当前页面，则切回到collectionView
//    if (!self.collectionV.listTab.hidden) {
//        
//        if(self.collectionV.isShared)
//        {
//            self.collectionV.isShared = NO;
//        }
//        else
//        {
//            self.collectionV.isShared = YES;
//            
//        }
//        self.collectionV.Animationed = YES;
//      //  [self.collectionV.listTab reloadData];
//    }else{
//    }
}

//筛选按钮点击（跳转到九宫格）
-(void)gotoCarma
{
    if ([CommonUtil isLogin]) {
        
        CameraViewController *ca = [[CameraViewController alloc]init];
        [self.navigationController pushViewController:ca animated:YES];
    }else{
        
        LoginViewController *log = [[LoginViewController alloc]init];
        [self.navigationController pushViewController:log animated:YES];
    }
}
-(void)classifyBtnPress:(UIButton *)sender
{
    [self.classifyV showClassify];
}
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    //微信分享纯图片，不需要文字信息
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
}

#pragma mark 视图切换（个人中心与主页之间切换）
-(void)showCurrentView:(JuPlusUIView *)view
{
    //只有当点击页面不是屏幕显示内容时候才会重新分布位置，否则不做处理
    if(view.origin.x!=0)
    {
    [UIView animateWithDuration:ANIMATION animations:^{
        [backV bringSubviewToFront:view];
        [backV bringSubviewToFront:self.tabBarV];
        [view startHomePageRequest];
        view.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH,view.height);
        if(view==self.collectionV)
            self.personCenterV.frame = CGRectMake(SCREEN_WIDTH, 0.0f, SCREEN_WIDTH,view.height);
        else
            self.collectionV.frame = CGRectMake(-SCREEN_WIDTH, 0.0f, SCREEN_WIDTH,view.height);

    } completion:^(BOOL finished) {
    
    }];
    }
    else
    {
    
    }
}
#pragma mark --tabBarDelegate

//点击事件的代理
-(void)changeTo:(UIButton *)sender
{
    //点击首页
    /*
     */
    if(sender.tag==ShowCollocation)
    {
        if (self.collectionV.origin.x!=0) {
            [self showCurrentView:self.collectionV];
        }else
        {
//            if([self.collectionV.diagramsScroll.subviews count]!=0){
//            //居家按钮旋转，体现伸缩效果
//            [sender CATransform3D:CATransform3DMakeRotation(M_PI, 1, 0.0f,0.0f)];
//            
//                [self reloadCollectionTab];
//            }
        }
    }
    //点击个人中心
    else if(sender.tag==ShowPerson)
    {
        if([CommonUtil isLogin])
        {
            [self showCurrentView:self.personCenterV];
        }
        else
        {
            LoginViewController *log = [[LoginViewController alloc]init];
            [self.navigationController pushViewController:log animated:YES];
        }

    }
    else
    {
        [self gotoCarma];
    }

}
#pragma mark --切换tabBar的显示效果
-(void)viewWillAppear:(BOOL)animated
{
    
    if (self.collectionV.isPackage) {
        self.collectionV.isPackage = NO;
    }
    else
    {
        [self.collectionV.listTab reloadData];
    }
    
    if (self.personCenterV.origin.x==0&&[CommonUtil isLogin]) {
        [self.personCenterV startHomePageRequest];
    }

    
    [super viewWillAppear:animated];
    if(![CommonUtil isLogin])
    {
        self.tabBarV.personBtn.selected = NO;
        ((UIButton *)[self.tabBarV.buttonArr firstObject]).selected = YES;
    [self showCurrentView:self.collectionV];
    }
    else
    {
       
    }
    [UIView animateWithDuration:ANIMATION animations:^{
        self.tabBarV.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 49.0f, SCREEN_WIDTH, 49.0f);
    }];
}
-(void)viewWillDisappear:(BOOL)animated
{
    
    [UIView animateWithDuration:ANIMATION animations:^{
        self.tabBarV.frame = CGRectMake(0.0f, SCREEN_HEIGHT, SCREEN_WIDTH, 49.0f);
    }];
    [super viewWillDisappear:animated];
}

@end
