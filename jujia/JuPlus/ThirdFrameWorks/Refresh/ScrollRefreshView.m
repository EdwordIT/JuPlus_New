//
//  ScrollRefreshView.m
//  refreshScroll
//
//  Created by lianggq on 13-12-12.
//  Copyright (c) 2013年 lianggq. All rights reserved.
//

#import "ScrollRefreshView.h"

@interface ScrollRefreshView()

// 合理的Y值
- (CGFloat)validY; //子类实现
//// view的类型
//- (int)viewType; //子类实现

@end

@implementation ScrollRefreshView
@synthesize statusLabel,scrollView,arrowImage,activityView;
@synthesize delegate;
//@synthesize beginRefreshingBlock;
@synthesize viewType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initial];
    }
    return self;
}

//-(void)setDelegate:(id<ScrollRefreshViewDegegate>)theDelegate
//{
//    _delegate =theDelegate;
//}



-(id)initWithScrollView:(UIScrollView *)superView
{
    self =[super init];
    if(self){
        self.scrollView =superView;
    }
    return  self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

#pragma mark 加载控件
-(void)initial
{
    //1
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.backgroundColor = [UIColor clearColor];
    //2
    statusLabel = [self labelWithFontSize:FontSize];
    //3
    [self addSubview:statusLabel];
    
    //4
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow.png"]];
    arrowImage =image;
    arrowImage.autoresizingMask =UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin;
    [self addSubview:arrowImage];
    [image release];
    
    // 5.指示器
    UIActivityIndicatorView *activity =[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.bounds = arrowImage.bounds;
    activity.autoresizingMask = arrowImage.autoresizingMask;
    activityView =activity;
    [self addSubview:activityView];
    [activity release];
    
    // 6.设置默认状态
    [self setState:RefreshStateNormal withAnimate:NO];
}

-(UILabel *)labelWithFontSize:(CGFloat)size
{
    UILabel *label = [[[UILabel alloc] init]autorelease];
    label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    label.font = [UIFont boldSystemFontOfSize:size];
    label.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    //label.textColor = [UIColor whiteColor];
    label.backgroundColor = [UIColor clearColor];
    label.textAlignment =NSTextAlignmentCenter;
    return label;
   
}
#pragma mark 重写frame
-(void)setFrame:(CGRect)frame
{
    frame.size.height = kViewHeight;
    [super setFrame:frame];
    
    CGFloat statusY = 0;
    CGFloat w = frame.size.width;
//    if(w==0 || statusLabel.frame.origin.y == statusY) return;
    
    // 1.状态标签
    CGFloat statusX = 0; //x 坐标
    CGFloat statusHeight = 20;
    CGFloat statusWidth = w;
    statusY =(kViewHeight -statusHeight)/2.0;
    
    statusLabel.frame = CGRectMake(statusX, statusY, statusWidth, statusHeight);
    
    // 3.箭头
    CGFloat arrowX = w * 0.5 - 100;
    arrowImage.center = CGPointMake(arrowX, frame.size.height * 0.5);
    
    // 4.指示器
    activityView.center = arrowImage.center;
}

#pragma mark override removeFromSuperview
-(void)removeFromSuperview
{
    [self.scrollView removeObserver:self forKeyPath:KEYPATHOFFSET context:nil];
    [super removeFromSuperview];
}

#pragma mark - UIScrollView相关
#pragma mark 设置UIScrollView
-(void)setScrollView:(UIScrollView *)theScrollView
{
    [scrollView removeObserver:self forKeyPath:KEYPATHOFFSET context:nil];
    scrollView =theScrollView;
    [scrollView addSubview:self];
    [scrollView addObserver:self forKeyPath:KEYPATHOFFSET options:NSKeyValueObservingOptionNew context:nil];
}


#pragma mark 监听UIScrollView的contentOffset属性
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([KEYPATHOFFSET isEqualToString:keyPath]){
        //已经没有数据加载了 return
        if(_state ==RefreshStateALL){
            //[self setHidden:YES];
            return;
        }
        //如果还有
        CGFloat offsetY = scrollView.contentOffset.y * self.viewType; //手拉倒的位置
        CGFloat validY = self.validY;
        if (!self.userInteractionEnabled || self.alpha <= 0.01 || self.hidden
            || _state == RefreshStateRefreshing
            || offsetY <= validY) return;
        //手在拉动 没松开
        if(scrollView.isDragging){
            CGFloat validOffsetY =validY +kViewHeight ;
            //当在拉 切还没完全显示自身高度时 状态
            if(_state == RefreshStatePulling && offsetY <=validOffsetY){
                [self setState:RefreshStateNormal withAnimate:NO];
            //当已经显示自身高度 还没松手时 状态
            }else if (_state == RefreshStateNormal &&offsetY >validOffsetY){
                [self setState:RefreshStatePulling withAnimate:NO];
            }
        //手松开时
        }else{
            if(_state ==RefreshStatePulling){
                [self setState:RefreshStateRefreshing withAnimate:NO];
               
            }
        }
    }
}

#pragma  mark 设置状态
-(void)setState:(RefreshState)state withAnimate:(BOOL)animate
{
    switch (state) {
        case RefreshStateNormal:
            arrowImage.hidden =NO;
            [activityView stopAnimating];
            break;
        case RefreshStatePulling:
            break;
        case RefreshStateRefreshing:
            [activityView startAnimating];
            arrowImage.hidden =YES;
            arrowImage.transform =CGAffineTransformIdentity;
//            //代理回调
//            if([self.delegate respondsToSelector:@selector(refreshViewBeginRefreshing:)]){
//                [self.delegate refreshViewBeginRefreshing:self];
//            }
//            
//            //block为了防止循环引用 常规不默认  &&可用来多线程执行注意防止retain circle
//            if(self.beginRefreshingBlock){
//                beginRefreshingBlock(self);
//            }
            break;
        case RefreshStateALL:{
            if(activityView.isAnimating){
                [activityView stopAnimating];
            }
            if(!arrowImage.hidden){
                arrowImage.hidden=YES;
            }
            break;
        }
    }
}

-(RefreshState)state
{
    return _state;
}

#pragma mark 开始刷新
- (void)beginRefreshing
{
    [self setState:RefreshStateRefreshing withAnimate:NO];
}
#pragma mark 结束刷新
- (void)endRefreshing
{
    [self setState:RefreshStateNormal withAnimate:NO];
}


-(void)free
{
    //arc 自动释放 不是arc 自行控制释放
   
}

-(CGFloat)validY
{
    return 0.f;
}

-(BOOL)reRreshing
{
    return RefreshStateRefreshing ==_state;
}
@end
