//
//  MyCycleView.h
//  JuPlus
//
//  Created by admin on 16/1/16.
//  Copyright © 2016年 居+. All rights reserved.
//
#import "MyCycleView.h"

@interface MyCycleView ()<UIScrollViewDelegate>
{
    CGFloat _startContentOffsetX;//起始偏移量
    CGFloat _willEndContentOffsetX;//将要停止拖拽时的偏移量
    CGFloat _endContentOffsetX;//终止偏移量
    NSArray *bannerArray;
}

@property (nonatomic,retain)UIPageControl *pageControl;

@end

@implementation MyCycleView

#pragma mark scrollView
-(UIScrollView *)scrollView
{
    if (!_scrollView)
    {
        // Initialization code
        _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
        _scrollView.delegate = self;
        _scrollView.directionalLockEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

#pragma mark pageControl
-(UIPageControl *)pageControl
{
    if (!_pageControl)
    {
        _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.frame.size.height-30.0, self.frame.size.width, 30.0)];
        _pageControl.userInteractionEnabled = NO;
//        _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
        _pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    }
    return _pageControl;
}

#pragma mark 重写初始化方法
-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self addSubview:self.scrollView];
        [self addSubview:self.pageControl];
        
        //设置默认值
        self.autoRoll = NO;
        self.rollTime = 2.0;
        self.currentPage = 0;
        self.pageControl.currentPage = _currentPage;
        
    }
    return self;
}

#pragma mark 重写dataSource代理属性setter方法
-(void)setDataSource:(id<MyCycleViewDataSource>)dataSource
{
    _dataSource = dataSource;
  //  [self reloadData];
}



#pragma mark 重载数据
-(void)reloadData
{
    //获取总的页数
    NSInteger totalPages = self.totalCount;
    
    if (totalPages==0)
    {
        return;
    }
    
    //取消自动滚动
    if (_autoRoll)
    {
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoRollAction) object:nil];
    }
    
    _pageControl.numberOfPages = totalPages;
    _currentPage = 0;
    _pageControl.currentPage = _currentPage;
    _scrollView.contentSize = CGSizeMake(self.frame.size.width * totalPages, self.frame.size.height);
    
    //    //移除以前的subview
    //    if (_scrollView.subviews.count!=0)
    //    {
    //        NSArray *subViewArr = _scrollView.subviews;
    //        for (int i=0; i<subViewArr.count; i++)
    //        {
    //            UIView *subView = subViewArr[i];
    //            [subView removeFromSuperview];
    //        }
    //    }
    //
    //取回每页的View并加在scrollview上
    for (NSInteger i=0; i<totalPages; i++)
    {
        NSInteger rightI = [self getRightCurrentPage:i-1];
        
        
        BannerItem *item = [bannerArray objectAtIndex:rightI];
        UIButton *img = [UIButton buttonWithType:UIButtonTypeCustom];
        img.frame = CGRectMake(i*self.width, 0.0f, self.width, self.height);
        [img setimageUrl:item.imgUrl placeholderImage:nil];
        img.tag = i;
        [img addTarget:self action:@selector(bannerPress:) forControlEvents:UIControlEventTouchUpInside];
        [self.scrollView addSubview:img];
        UIView *subView = img;
        CGRect frame = subView.frame;
        //设置subview的frame
        frame.origin.y = 0.0;
        frame.origin.x = i*_scrollView.frame.size.width;
        frame.size.width = _scrollView.frame.size.width;
        frame.size.height = _scrollView.frame.size.height;
        subView.frame = frame;
        //添加点击手势
        //        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewTapAction)];
        //        [subView addGestureRecognizer:tap];
        //        [_scrollView addSubview:subView];
    }
    self.scrollView.contentSize = CGSizeMake(self.width*[bannerArray count], self.scrollView.height);
    [CommonUtil postNotification:@"resetHeaderView" Object:nil];
    _scrollView.contentOffset = CGPointMake(0, 0);
    
    
    //开始自动滚动
    if (_autoRoll)
    {
        [self performSelector:@selector(autoRollAction) withObject:nil afterDelay:_rollTime];
    }
    
}

#pragma mark 自动滚动动作
-(void)autoRollAction
{
    _currentPage = [self getRightCurrentPage:_currentPage+1];
    [self updateScrollViewSubViewAnimated:YES];
    
    //开启自动滚动
    [self performSelector:@selector(autoRollAction) withObject:nil afterDelay:_rollTime];
}

#pragma mark 开启自动滚动
-(void)startRoll
{
    _autoRoll = YES;
    [self performSelector:@selector(autoRollAction) withObject:nil afterDelay:_rollTime];
}

#pragma mark 关闭自动滚动
-(void)stopRoll
{
    _autoRoll = NO;
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoRollAction) object:nil];
}

#pragma mark 点击view的手势动作
-(void)viewTapAction
{
    //设置代理回值
    if ([self.delegate respondsToSelector:@selector(myCycleView:didSelectedPage:)])
    {
        [self.delegate myCycleView:self didSelectedPage:_currentPage];
    }
}

#pragma mark 移动位置方法
-(void)updateScrollViewSubViewAnimated:(BOOL)animated
{
    _pageControl.currentPage = _currentPage;
    
    NSArray *subViews = [self changeSubViewsArrayWithIndex:_currentPage];

    //更改subview位置
    for (int i=0; i<subViews.count; i++)
    {
        UIView *subView = subViews[i];
        CGRect frame = subView.frame;
        frame.origin.x = i*_scrollView.frame.size.width;
        subView.frame = frame;
    }
    if (animated)
    {
        _scrollView.contentOffset = CGPointZero;
    }
    [_scrollView setContentOffset:CGPointMake(self.width, 0) animated:animated];
    

}

#pragma mark 移动view数组中的数据顺序
-(NSArray *)changeSubViewsArrayWithIndex:(NSInteger)index
{
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:_scrollView.subviews];
 
    for (NSInteger i=0; i<index; i++)
    {
        id tempOb = [tempArr firstObject];
        [tempArr removeObject:tempOb];
        [tempArr addObject:tempOb];
    }
    return [NSArray arrayWithArray:tempArr];
}

#pragma mark 获取正确的当前页
-(NSInteger)getRightCurrentPage:(NSInteger)page
{
    NSInteger totalPage = self.totalCount;
    if (page<0)
    {
        page = totalPage-1;
    }
    else if (page>totalPage-1)
    {
        page = 0;
    }
    return page;
}

#pragma mark UIScrollViewDelegate
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _startContentOffsetX = scrollView.contentOffset.x;
    
    //取消自动滚动
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(autoRollAction) object:nil];
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    _willEndContentOffsetX = scrollView.contentOffset.x;
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat bound = 30.0;
    _endContentOffsetX = scrollView.contentOffset.x;
    
    //判断滑动方向
    if (_endContentOffsetX==_startContentOffsetX)
    {
        if (_willEndContentOffsetX<-bound)
        {
            _currentPage = [self getRightCurrentPage:_currentPage-1];
            [self updateScrollViewSubViewAnimated:NO];
        }
        else if (_willEndContentOffsetX>scrollView.contentSize.width+bound-scrollView.frame.size.width)
        {
            _currentPage = [self getRightCurrentPage:_currentPage+1];
            [self updateScrollViewSubViewAnimated:NO];
        }
    }

   else if (_endContentOffsetX < _willEndContentOffsetX && _willEndContentOffsetX < _startContentOffsetX)
        {
            _currentPage = [self getRightCurrentPage:_currentPage-1];
            [self updateScrollViewSubViewAnimated:NO];
        }
   else if (_endContentOffsetX > _willEndContentOffsetX && _willEndContentOffsetX > _startContentOffsetX)
        {
            _currentPage = [self getRightCurrentPage:_currentPage+1];
            [self updateScrollViewSubViewAnimated:NO];
        }
    
    if (_autoRoll)
    {
        //恢复自动滚动
        [self performSelector:@selector(autoRollAction) withObject:nil afterDelay:_rollTime];
    }
}
#pragma mark --图片点击事件
-(void)startRequestBannerList
{
    GetBannerListReq *listReq = [[GetBannerListReq alloc]init];
    GetBannerListRespon *listRespon = [[GetBannerListRespon alloc]init];
    [HttpCommunication request:listReq getResponse:listRespon Success:^(JuPlusResponse *response) {
        bannerArray = listRespon.bannerListArray;
        if (!IsArrEmpty(bannerArray)) {
            self.frame = CGRectMake(self.left, self.top, self.width, 120*(SCREEN_WIDTH/320.0f));
            self.scrollView.frame = CGRectMake(0.0f, 0.0f, self.width, self.height);
            self.pageControl.frame = CGRectMake(0.0f, self.height - 30.0f, self.width, 30.0f);
            self.totalCount = [bannerArray count];
            self.pageControl.numberOfPages = self.totalCount;
            [self reloadData];
        }else
            self.frame = CGRectMake(0.f, 0.f, 0.f, 0.f);
        
    } failed:^(ErrorInfoDto *errorDTO) {
        //
        self.frame = CGRectMake(0.f, 0.f, 0.f, 0.f);
    } showProgressView:NO with:self];
}

//广告位点击事件
-(void)bannerPress:(UIButton *)sender
{
    BannerItem *item = [bannerArray objectAtIndex:sender.tag];
    
    if ([item.type integerValue]==1) {
        //跳转H5
        BasicWebViewViewController *web = [[BasicWebViewViewController alloc]init];
        web.htmlUrl = item.param;
        web.titleStr = item.title;
        [[self getSuperViewController].navigationController pushViewController:web animated:YES];
        
    }else if ([item.type integerValue]==2){
        //跳转效果图详情
        PackageViewController *package = [[PackageViewController alloc]init];
        package.regNo = item.param;
        [[self getSuperViewController].navigationController pushViewController:package animated:YES];
    }else if ([item.type integerValue]==3){
        //跳转单品详情
        SingleDetialViewController *single = [[SingleDetialViewController alloc]init];
        single.singleId = item.param;
        [[self getSuperViewController].navigationController pushViewController:single animated:YES];
    }
}

@end
