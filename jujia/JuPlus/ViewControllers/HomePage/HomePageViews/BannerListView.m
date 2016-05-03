//
//  BannerListView.m
//  JuPlus
//
//  Created by admin on 15/10/16.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "BannerListView.h"
#import "SingleDetialViewController.h"
#import "PackageViewController.h"
#import "BasicWebViewViewController.h"
#import "GetBannerListReq.h"
#import "GetBannerListRespon.h"
@implementation BannerListView
{
    NSArray *bannerArray;
}
-(id)initWithFrame:(CGRect)frame
{
    self =  [super initWithFrame:frame];
    if (self) {
        [self uifig];
    }
    return self;
}
-(void)uifig
{
    [self addSubview:self.bannerScroll];
    [self addSubview:self.pageControl];
}
-(UIScrollView *)bannerScroll
{
    if (!_bannerScroll) {
        _bannerScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
        _bannerScroll.pagingEnabled = YES;
        _bannerScroll.delegate = self;
        _bannerScroll.showsHorizontalScrollIndicator = NO;
        _bannerScroll.scrollsToTop = NO;
    }
    return _bannerScroll;
}
-(UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0.0f, self.height - 30.0f, self.width, 30.0f)];
    }
    return _pageControl;
}
-(void)startRequestBannerList
{
    GetBannerListReq *listReq = [[GetBannerListReq alloc]init];
    GetBannerListRespon *listRespon = [[GetBannerListRespon alloc]init];
    [HttpCommunication request:listReq getResponse:listRespon Success:^(JuPlusResponse *response) {
        bannerArray = listRespon.bannerListArray;
        if (!IsArrEmpty(bannerArray)) {
            self.frame = CGRectMake(self.left, self.top, self.width, 120*(SCREEN_WIDTH/320.0f));
            self.bannerScroll.frame = CGRectMake(0.0f, 0.0f, self.width, self.height);
            self.pageControl.frame = CGRectMake(0.0f, self.height - 30.0f, self.width, 30.0f);
            for (int i=0; i<[bannerArray count]; i++) {
                BannerItem *item = [bannerArray objectAtIndex:i];
                UIButton *img = [UIButton buttonWithType:UIButtonTypeCustom];
                img.frame = CGRectMake(i*self.width, 0.0f, self.width, self.height);
                [img setimageUrl:item.imgUrl placeholderImage:nil];
                img.tag = i;
                [img addTarget:self action:@selector(bannerPress:) forControlEvents:UIControlEventTouchUpInside];
                [self.bannerScroll addSubview:img];
            }
            self.pageControl.numberOfPages = [listRespon.bannerListArray count];
            self.bannerScroll.contentSize = CGSizeMake(self.width*[bannerArray count], self.bannerScroll.height);
            [CommonUtil postNotification:@"resetHeaderView" Object:nil];
        }else
            self.frame = CGRectMake(0.f, 0.f, 0.f, 0.f);
        
    } failed:^(ErrorInfoDto *errorDTO) {
        //
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

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
