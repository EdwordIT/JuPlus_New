//
//  AppDelegate.h
//  FurnHouse
//
//  Created by 詹文豹 on 15/6/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//
typedef enum {
    GO_SINGLEDETAIL = 0,       //单品详情
    GO_WORKLIST = 1,           //作品列表
    GO_ORDERLIST = 2,          //订单列表
    GO_PACKAGETAIL = 3 ,       //套餐详情
    GO_PERSIONCENTER = 4,      //个人中心
    GO_ORDERDETAIL = 5,        //订单详情
   } JPushTag;//推送tag绑定

#import <UIKit/UIKit.h>
#import "JuPlusConstant.h"
@interface JuPlusAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@end

