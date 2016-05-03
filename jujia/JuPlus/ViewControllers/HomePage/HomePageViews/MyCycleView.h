//
//  MyCycleView.h
//  JuPlus
//
//  Created by admin on 16/1/16.
//  Copyright © 2016年 居+. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "SingleDetialViewController.h"
#import "PackageViewController.h"
#import "BasicWebViewViewController.h"
#import "GetBannerListReq.h"
#import "GetBannerListRespon.h"
@protocol MyCycleViewDelegate;
@protocol MyCycleViewDataSource;

@interface MyCycleView : UIView


@property (nonatomic,assign)id <MyCycleViewDelegate>delegate;

@property (nonatomic,assign,setter=setDataSource:)id <MyCycleViewDataSource>dataSource;
/*
 *加载banner位
 */
-(void)startRequestBannerList;
/**
 *是否一开始就开启自动滚动,默认NO
 */
@property (nonatomic,assign) BOOL autoRoll;

@property (nonatomic,assign)NSInteger totalCount;

@property (nonatomic,retain) UIScrollView *scrollView;

/**
 *自动滚动间隔时间,默认2.0s
 */
@property (nonatomic,assign) NSTimeInterval rollTime;

/**
 *当前页,默认为0
 */
@property (nonatomic,assign) NSInteger currentPage;

/**
 *重载数据
 */
-(void)reloadData;

/**
 *开启自动滚动
 */
-(void)startRoll;

/**
 *关闭自动滚动
 */
-(void)stopRoll;

@end

//数据源代理
@protocol MyCycleViewDataSource <NSObject>

@required

/**
 *每一页对应的内容
 */
-(UIView *)viewAtPage:(NSInteger)page;


@end

@protocol MyCycleViewDelegate <NSObject>

@optional
/**
 *选择了哪一页
 */
-(void)myCycleView:(MyCycleView *)myCycleView didSelectedPage:(NSInteger)page;

@end


