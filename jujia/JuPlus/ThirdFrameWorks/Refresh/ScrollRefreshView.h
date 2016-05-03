//
//  ScrollRefreshView.h
//  refreshScroll
//
//  Created by lianggq on 13-12-12.
//  Copyright (c) 2013年 lianggq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

#define kViewHeight 40.0 // 自身高度
#define KEYPATHOFFSET @"contentOffset"
#define KEYPATHSIZE   @"contentSize"


#define kReleaseToRefresh @"松开立即刷新"
#define kRefreshing @"正在帮你加载..."
#define LOADDATAALL   @"没有数据加载了"


typedef enum{
    RefreshStatePulling = 1,  //在拉动
	RefreshStateNormal , //正常状态
	RefreshStateRefreshing,//刷新状态
    RefreshStateALL //数据已加载完成 状态
} RefreshState;


typedef enum {
    RefreshViewTypeHeader = -1, // -1 表示头 坐标Y负数
    RefreshViewTypeFooter = 1  //   1 表示底
} RefreshViewType;

//相关代理
@class ScrollRefreshView;
//block 默认不启用
//typedef void  (^BeginRefreshingBlock)(ScrollRefreshView * refreshView);

@protocol ScrollRefreshViewDegegate<NSObject>

//开始刷新
@required
-(void)refreshViewBeginRefreshing:(ScrollRefreshView *)refreshView;

@end

@interface ScrollRefreshView : UIView{
    // 状态
    RefreshState _state;
    //RefreshViewType viewType;
    //id<ScrollRefreshViewDegegate> delegate;
}

// 内部的控件
//@property (nonatomic, retain, readonly) UILabel *lastUpdateTimeLabel;
@property (nonatomic, retain, readonly) UILabel *statusLabel; //
@property (nonatomic, retain, readonly) UIImageView *arrowImage;//
@property (nonatomic, retain, readonly) UIActivityIndicatorView *activityView;
@property (nonatomic, assign) UIScrollView *scrollView;//

@property (nonatomic, assign) id<ScrollRefreshViewDegegate>delegate;

////回调函数 最好用代理回调 内部属性是weak 用block也无妨
//@property (nonatomic, copy) BeginRefreshingBlock beginRefreshingBlock;
//是否在刷新
@property (nonatomic,readonly,getter = reRreshing) BOOL refreshing;

@property(nonatomic) RefreshViewType viewType;


// 开始刷新
- (void)beginRefreshing;
// 结束刷新
- (void)endRefreshing;
// 结束使用、释放资源
- (void)free;

// 交给子类去实现
- (void)setState:(RefreshState)state withAnimate:(BOOL)animate;


//指定父容器的构造方法
-(id)initWithScrollView:(UIScrollView *)superView;
@end
