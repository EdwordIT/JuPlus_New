//
//  JuPlusUIView.h
//  JuPlus
//
//  Created by 詹文豹 on 15/6/18.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JuPlusCustomMethod.h"
#import "JuPlusEnvironmentConfig.h"
#import "CommonUtil.h"
#import "TabBar_BottomBtn.h"
#import "HttpCommunication.h"
#import "JuPlusUILabel.h"
#import "JuPlusRefreshView.h"
#import "JuPlusUserInfoCenter.h"
@interface JuPlusUIView : UIView
@property(nonatomic,strong)UIView *navView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *viewBack;
@property(nonatomic,strong)UIButton *leftBtn;
@property(nonatomic,strong)UIButton *rightBtn;
//无数据
@property(nonatomic,strong)UIImageView *noDataImage;
//重新加载
@property(nonatomic,strong)UIView *reloadImage;

-(void)errorExp:(ErrorInfoDto *)exp;
//提示的错误消息
- (void)showAlertView:(NSString *)msg withTag:(int)tag;
//一些系统的弹出处理,例如强制更新，登录失败
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)startHomePageRequest;

//重置暂无数据的frame
-(void)setNoDataImageFrame:(UITableView *)tab;
//刷新本界面数据（重新请求一次）
-(void)reloadNetWorkError;

@end
