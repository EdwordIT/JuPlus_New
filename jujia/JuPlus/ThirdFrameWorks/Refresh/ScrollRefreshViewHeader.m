//
//  ScrollRefreshViewHead.m
//  refreshScroll
//
//  Created by lianggq on 13-12-12.
//  Copyright (c) 2013年 lianggq. All rights reserved.
//

#import "ScrollRefreshViewHeader.h"


#define kPullToRefresh @"下拉即可刷新"
#define kTimeKey  @"lastTime"

@interface ScrollRefreshViewHeader()

@property (nonatomic,strong) UILabel *lastUpdateTimeLabel;
// 最后的更新时间
@property (nonatomic, strong) NSDate *lastUpdateTime;
@end



@implementation ScrollRefreshViewHeader



+(id)header
{
    
    return [[[ScrollRefreshViewHeader alloc ] init]autorelease];
    
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        self.message =kPullToRefresh;
        self.viewType =RefreshViewTypeHeader;
    }
    return self;
}

-(void)setMessage:(NSString *)message
{
    _message =message;
    self.statusLabel.text =message;
}

-(void)setIsShowTime:(BOOL)isShowTime
{
    _isShowTime =isShowTime;
    if(_isShowTime &&!self.lastUpdateTime){
        [self addLastTimeLabel];
    }
}

-(void)addLastTimeLabel
{
    //调整显示状态label
    CGRect staFrame = self.statusLabel.frame;
    CGPoint staPoint =staFrame.origin;
    staPoint.y =0.0f;
    staFrame.origin =staPoint;
    self.statusLabel.frame =staFrame;
    //添加时间label
    CGFloat timeLabelY =staFrame.origin.y + staFrame.size.height;
    CGFloat timeLabelHeight =self.bounds.size.height - timeLabelY;
    CGRect timeRect =CGRectMake(0.0f, timeLabelY, self.bounds.size.width, timeLabelHeight);
    self.lastUpdateTimeLabel =[[[UILabel alloc] initWithFrame:timeRect]autorelease];
    self.lastUpdateTimeLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    self.lastUpdateTimeLabel.font = [UIFont boldSystemFontOfSize:FontSize];
    self.lastUpdateTimeLabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    self.lastUpdateTimeLabel.backgroundColor = [UIColor clearColor];
    self.lastUpdateTimeLabel.textAlignment =NSTextAlignmentCenter;
    
    [self addSubview:self.lastUpdateTimeLabel];
    _lastUpdateTime = [[NSUserDefaults standardUserDefaults] objectForKey:kTimeKey];
    [self updateTimeLabel];
}

-(void)setLastUpdateTime:(NSDate *)lastUpdateTime
{
    _lastUpdateTime =lastUpdateTime;

    // 归档
    [[NSUserDefaults standardUserDefaults] setObject:_lastUpdateTime forKey:kTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];

    // 更新时间
    [self updateTimeLabel];
}

#pragma mark 更新时间字符串
- (void)updateTimeLabel
{
    if (!_lastUpdateTime) {
        // 3.显示日期
        self.lastUpdateTimeLabel.text = [NSString stringWithFormat:@"无更新记录" ];
        return;
    }
    
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay |NSCalendarUnitHour |NSCalendarUnitMinute;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:_lastUpdateTime];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    // 2.格式化日期
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    if ([cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    } else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:_lastUpdateTime];
    
    // 3.显示日期
    self.lastUpdateTimeLabel.text = [NSString stringWithFormat:@"最后更新：%@", time];
}




#pragma mark - UIScrollView相关
#pragma mark 重写设置ScrollView
-(void)setScrollView:(UIScrollView *)scrollView
{
    self.frame =CGRectMake(0, (0-kViewHeight), scrollView.frame.size.width, kViewHeight);
   
    [super setScrollView:scrollView];
    
    
}

#pragma mark override设置状态
-(void)setState:(RefreshState)state withAnimate:(BOOL)animate
{
    if(_state ==state ) return;
    [super setState:state withAnimate:animate];
    //保留旧址状态
    RefreshState oldState = _state;
    _state =state;
    switch (_state) {
        case RefreshStatePulling:{
            self.statusLabel.text =kReleaseToRefresh;
            [UIView animateWithDuration:0.2 animations:^{
                //图片旋转180°
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                
            }];
            break;
        }
        case RefreshStateRefreshing:{
            self.statusLabel.text = kRefreshing;
            
            [UIView animateWithDuration:0.2 animations:^{
                // 1.顶部多出kViewHeight的滚动范围
                UIEdgeInsets inset = self.scrollView.contentInset;
                inset.top = kViewHeight;
                self.scrollView.contentInset = inset;
                // 2.设置滚动位置
                self.scrollView.contentOffset = CGPointMake(0, -kViewHeight);
            }];
            //代理回调
            if([self.delegate respondsToSelector:@selector(refreshViewBeginRefreshing:)]){
                [self.delegate refreshViewBeginRefreshing:self];
            }
            
            
        
            break;
        }
        case RefreshStateNormal:{
            self.statusLabel.text = self.message;
            //
            [UIView animateWithDuration:0.2 animations:^{
                self.arrowImage.transform =CGAffineTransformIdentity;
                //边隙上面多出kViewHeight 40 高度
                UIEdgeInsets inset =self.scrollView.contentInset;
                inset.top =0;
                self.scrollView.contentInset =inset;
            }];
            
            if(self.isShowTime && oldState == RefreshStateRefreshing){
                self.lastUpdateTime =[NSDate date];
            }
                
            break;
        }
        case RefreshStateALL:
            self.statusLabel.text =LOADDATAALL;
            if(animate){
                [self performSelector:@selector(setInSetTop) withObject:nil afterDelay:0.5];
            }else{
                //[self setInSetTop];
            }
            break;

    }
}

-(void)setInSetTop
{
    [UIView animateWithDuration:0.5 animations:^{

        self.scrollView.contentOffset = CGPointMake(0, 0);
    }];
}

#pragma mark - 在父类中用得上
// 合理的Y值
- (CGFloat)validY
{
    return 0;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/



@end
