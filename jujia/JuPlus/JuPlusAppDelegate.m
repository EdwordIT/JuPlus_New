//
//  AppDelegate.m
//  FurnHouse
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusAppDelegate.h"
#import "CommonUtil.h"
#import "GuideViewController.h"
#import "HomeFurnishingViewController.h"
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialSinaHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "MobClick.h"
#import "UMessage.h"
#import <MAMapKit/MAMapKit.h>
#import <AlipaySDK/AlipaySDK.h>
#import "ImportViewController.h"
#import "APService.h"
#import "MyWorksListViewController.h"
#import "OrderListViewController.h"
#import "JuPlusGetLocation.h"
/* */
@interface JuPlusAppDelegate ()
{
    BOOL isAPNS;
    
    BOOL isNeedNewRoot;
}
@property(nonatomic,strong)ImportViewController *import;

@end

@implementation JuPlusAppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
   // sleep(1);//设置启动页面时间
#pragma mark --UM sign

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = Color_White;
    //[self loadAnimationView];
    //注册地图
    [MAMapServices sharedServices].apiKey = AMap_Key;
    
    [[JuPlusGetLocation sharedInstance] getLocation];
    //注册分享
    [self signUM:launchOptions];
    
    // Override point for customization after application launch.
    //    [self runNormalMethod];
    [self.window makeKeyAndVisible];
    
    NSDictionary * userInfo = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    if ([userInfo count]!=0) {

    }else
        [self runImport];
    
    return YES;
}
-(void)upPackage:(NSDictionary *)dic
{

}
-(void)startupAnimationDone
{
    [self.window removeAllSubviews];
}
-(void)signUM:(NSDictionary *)launchOptions
{
    [UMSocialData setAppKey:UM_APPKey];
    //设置微信AppId、appSecret，分享url
    [UMSocialWechatHandler setWXAppId:WeiChatAppKey appSecret:WeiChatAppKey url:WeiChatShareUrl];
    //友盟统计添加
    [MobClick startWithAppkey:UM_APPKey reportPolicy:BATCH channelId:nil];
    //打开新浪微博
    [UMSocialSinaSSOHandler openNewSinaSSOWithRedirectURL:nil];
    /*替换友盟推送为极光推送*/
    //友盟推送添加
    //[UMessage startWithAppkey:UM_APPKey launchOptions:launchOptions];
    
   // [self loadUMMessage];
    
    [self loadJPushMessage];
    
    [APService setupWithOption:launchOptions];
    

}

//-(void)loadUMMessage
//{
//#define Version ios8.0 and Later
//    if(VERSION>=8.0)
//    {
//        //register remoteNotification types （iOS 8.0及其以上版本）
//        UIMutableUserNotificationAction *action1 = [[UIMutableUserNotificationAction alloc] init];
//        action1.identifier = @"action1_identifier";
//        action1.title=@"Accept";
//        action1.activationMode = UIUserNotificationActivationModeForeground;//当点击的时候启动程序
//        
//        UIMutableUserNotificationAction *action2 = [[UIMutableUserNotificationAction alloc] init];  //第二按钮
//        action2.identifier = @"action2_identifier";
//        action2.title=@"Reject";
//        action2.activationMode = UIUserNotificationActivationModeBackground;//当点击的时候不启动程序，在后台处理
//        action2.authenticationRequired = YES;//需要解锁才能处理，如果action.activationMode = UIUserNotificationActivationModeForeground;则这个属性被忽略；
//        action2.destructive = YES;
//        
//        UIMutableUserNotificationCategory *categorys = [[UIMutableUserNotificationCategory alloc] init];
//        categorys.identifier = @"category1";//这组动作的唯一标示
//        [categorys setActions:@[action1,action2] forContext:(UIUserNotificationActionContextDefault)];
//        
//        UIUserNotificationSettings *userSettings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge|UIUserNotificationTypeSound|UIUserNotificationTypeAlert
//                                                                                     categories:[NSSet setWithObject:categorys]];
//        [UMessage registerRemoteNotificationAndUserNotificationSettings:userSettings];
//    }
//        [UMessage setLogEnabled:YES];
//
//}
-(void)loadJPushMessage
{
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        //categories
        [APService
         registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                             UIUserNotificationTypeSound |
                                             UIUserNotificationTypeAlert)
         categories:nil];
    }
}
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    return  [UMSocialSnsService handleOpenURL:url];
}
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    NSRange userNameRange = [url.absoluteString rangeOfString:ALI_APPKEY];    //如果是支付宝跳转
    if (userNameRange.location != NSNotFound) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
                NSLog(@"resultReason = %@",[resultDic objectForKey:@"memo"]);
            }];
            
            return YES;
    }else
        //新浪微博、腾讯微博、微信等分享
    return  [UMSocialSnsService handleOpenURL:url];
    

}
//正常打开首页
-(void)runImport
{
    self.import = [[ImportViewController alloc]init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:self.import];

    self.window.rootViewController = nav;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}
- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
#define UM_Message Delegate
//- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
//{
//    NSLog(@"%@",[[[[deviceToken description] stringByReplacingOccurrencesOfString: @"<" withString: @""]                  stringByReplacingOccurrencesOfString: @">" withString: @""]                 stringByReplacingOccurrencesOfString: @" " withString: @""]);
//    [UMessage registerDeviceToken:deviceToken];
//    
//}
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
//{
//    [UMessage didReceiveRemoteNotification:userInfo];
//}
//-(void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
//{
//    NSLog(@"error = %@",error);
//}

#define JPush Delegate
- (void)application:(UIApplication *)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    // Required
   NSLog(@"registerID = %@",[APService registrationID]);
    
    [APService registerDeviceToken:deviceToken];
}
-(void)unPackageUserInfo:(NSDictionary *)userInfo
{
    //数据内容
    NSDictionary *dic = [userInfo objectForKey:@"aps"];
    NSString *alertStr = [dic objectForKey:@"alert"];
    NSString *str = [userInfo objectForKey:@"flag"];
    if (!IsStrEmpty(str)) {
        if (isAPNS) {
            [self Notification:[str integerValue]];
        }else{
            [self showMessage:alertStr andTag:[str integerValue]];
        }
    }else
    {
        if (!isAPNS)
       [self showMessage:alertStr andTag:0];
    }
}
//应用正在使用时候的推送处理
//此处处理所有接收到的推送信息

//- (void)application:(UIApplication *)application
//didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    
//    [self unPackageUserInfo:userInfo];
//    // Required
//    [APService handleRemoteNotification:userInfo];
//    
//}
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [APService handleRemoteNotification:userInfo];
    if (application.applicationState==UIApplicationStateInactive) {
        //程序在后台已经停止，需要重新root
        isNeedNewRoot=YES;
    }
    else
    {
        //程序处于后台运行中，或者正在运行UIApplicationStatebackground，UIApplicationStateactive
        isNeedNewRoot=NO;
    }
    
     if (application.applicationState==UIApplicationStateActive) {
         isAPNS = NO;
     }else
         isAPNS = YES;
        [self unPackageUserInfo:userInfo];

}
-(void)showMessage:(NSString *)str andTag:(int)tag
{
    if (tag==0) {
         UIAlertView *alt1 = [[UIAlertView alloc]initWithTitle:Remind_Title message:str delegate:nil cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alt1 show];
    }else{
    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:str delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alt.tag = tag;
    [alt show];
    }
}
//消息处理
-(void)Notification:(NSInteger)tag
{
    if (isNeedNewRoot) {
        HomeFurnishingViewController *homeController = [[HomeFurnishingViewController alloc] init];
        //去homepage得第二页第三个按钮
        UINavigationController * rootController = [[UINavigationController alloc] initWithRootViewController:homeController];
        rootController.navigationBarHidden = YES;
        self.window.rootViewController = rootController;
    }
    //作品列表
    if (tag==GO_WORKLIST) {
        MyWorksListViewController *list = [[MyWorksListViewController alloc]init];
        [(UINavigationController *)self.window.rootViewController pushViewController:list animated:YES];
    }else if(tag==GO_ORDERLIST)
    {
        OrderListViewController *list = [[OrderListViewController alloc]init];
        [(UINavigationController *)self.window.rootViewController pushViewController:list animated:YES];
    }

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    if (buttonIndex==1) {
        [self Notification:alertView.tag];
    }
}
#pragma mark 接收本地通知时触发
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    NSDictionary *userInfo=notification.userInfo;
    NSLog(@"didReceiveLocalNotification:The userInfo is %@",userInfo);
}
- (void)application:(UIApplication *)application
didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"did Fail To Register For Remote Notifications With Error: %@", error);
}
@end
