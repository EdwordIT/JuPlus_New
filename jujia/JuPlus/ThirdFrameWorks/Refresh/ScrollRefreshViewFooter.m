//
//  ScrollRefreshViewFooter.m
//  refreshScroll
//
//  Created by lianggq on 13-12-12.
//  Copyright (c) 2013年 lianggq. All rights reserved.
//

#import "ScrollRefreshViewFooter.h"

#define kPullToRefresh @"上拉加载更多"

@implementation ScrollRefreshViewFooter

+(id)footer{
    return [[[ScrollRefreshViewFooter alloc] init]autorelease];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.viewType =RefreshViewTypeFooter;
        
    }
    return self;
}

- (void)removeFromSuperview
{
    [self.superview removeObserver:self forKeyPath:KEYPATHSIZE context:nil];
    [super removeFromSuperview];
}

#pragma mark - UIScrollView相关
#pragma mark 重写设置ScrollView
- (void)setScrollView:(UIScrollView *)theScrollView
{
    // 1.移除以前的监听器
    [self.scrollView removeObserver:self forKeyPath:KEYPATHSIZE context:nil];
    // 2.监听contentSize
    [theScrollView addObserver:self forKeyPath:KEYPATHSIZE options:NSKeyValueObservingOptionNew context:nil];
    
    // 3.父类的方法
    [super setScrollView:theScrollView];
    
    // 4.重新调整frame
    [self adjustFrame];
}

#pragma mark 监听UIScrollView的属性
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if ([KEYPATHSIZE isEqualToString:keyPath]) {
        [self adjustFrame];
    }
}

#pragma mark 重写调整frame
- (void)adjustFrame
{
    // 内容的高度
    CGFloat contentHeight = self.scrollView.contentSize.height;
    // 表格的高度
    CGFloat scrollHeight = self.scrollView.frame.size.height;
    CGFloat y = MAX(contentHeight, scrollHeight);
    // 设置边框
    self.frame = CGRectMake(0, y, self.scrollView.frame.size.width, kViewHeight);
    
    // 挪动标签的位置
    CGPoint center = self.statusLabel.center;
    center.y = self.arrowImage.center.y;
    self.statusLabel.center = center;
}

#pragma mark - 状态相关
#pragma mark 设置状态
- (void)setState:(RefreshState)state withAnimate:(BOOL)animate
{
    if (_state == state) return;
    
    [super setState:state withAnimate:animate];
    
	switch (_state = state)
    {
		case RefreshStatePulling:
        {
            self.statusLabel.text = kReleaseToRefresh;
            
            [UIView animateWithDuration:0.2 animations:^{
                self.arrowImage.transform = CGAffineTransformIdentity;
                UIEdgeInsets inset = self.scrollView.contentInset;
                inset.bottom = 0;
                self.scrollView.contentInset = inset;
            }];
			break;
        }
            
		case RefreshStateNormal:
        {
			self.statusLabel.text = kPullToRefresh;
            
            [UIView animateWithDuration:0.2 animations:^{
                self.arrowImage.transform = CGAffineTransformMakeRotation(M_PI);
                UIEdgeInsets inset = self.scrollView.contentInset;
                inset.bottom = 0;
                self.scrollView.contentInset = inset;
            }];
			break;
        }
            
        case RefreshStateRefreshing:
        {
            self.statusLabel.text = kRefreshing;
//            [UIView animateWithDuration:0.2 animations:^{
//                // 1.顶部多出65的滚动范围
//                UIEdgeInsets inset = self.scrollView.contentInset;
//                
//                inset.bottom = kViewHeight +self.frame.origin.y - self.scrollView.contentSize.height ;
//                self.scrollView.contentInset = inset;
//                
//                // 2.设置滚动位置
//                self.scrollView.contentOffset = CGPointMake(0, self.validY + kViewHeight);
//            }];
            //代理回调
            if([self.delegate respondsToSelector:@selector(refreshViewBeginRefreshing:)]){
                [self.delegate refreshViewBeginRefreshing:self];
            }

            
			break;
        }
        case RefreshStateALL:{
            self.statusLabel.text =LOADDATAALL;
            if(animate){
               // [self performSelector:@selector(setInSetBottom) withObject:nil afterDelay:0.5];
            }else{
                //[self setInSetBottom];
            }
            break;
        }
	}
}

-(void)setInSetBottom
{
    [UIView animateWithDuration:0.5 animations:^{
        //CGSize content =self.scrollView.contentSize;
        CGPoint contentP =self.scrollView.contentOffset;
        contentP.y=contentP.y-kViewHeight;
        self.scrollView.contentOffset =contentP;
    }];

}

#pragma mark - 在父类中用得上
// 合理的Y值
- (CGFloat)validY
{
//    CGFloat conHeight =self.scrollView.contentSize.height;
//    CGFloat bundleHeight =self.scrollView.bounds.size.height;
//    CGFloat frameHeight =self.scrollView.frame.size.height;
    
    CGFloat testy =MAX(self.scrollView.contentSize.height, self.scrollView.frame.size.height) - self.scrollView.frame.size.height;
    if(testy >0){
        //测试 查看
        //NSLog(@"y=%lf,state =%i",testY,_state);
    }
    
    return MAX(self.scrollView.contentSize.height, self.scrollView.frame.size.height) - self.scrollView.frame.size.height;
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
