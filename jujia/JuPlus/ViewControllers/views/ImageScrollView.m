//
//  ImageScrollView.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ImageScrollView.h"

@implementation ImageScrollView
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = Color_Gray;
        [self addSubview:self.imageScroll];
        [self addSubview:self.pageControl];
        [self addSubview:self.priceLabel];
        [self addSubview:self.favBtn];
    }
    return self;
}
-(UIScrollView *)imageScroll
{
    if(!_imageScroll)
    {
        _imageScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, self.height)];
        _imageScroll.pagingEnabled = YES;
        _imageScroll.delegate = self;
    }
    return _imageScroll;
    
}
-(UIButton *)favBtn
{
    if(!_favBtn)
    {
        CGFloat btnR = 50.0f;
        _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _favBtn.frame = CGRectMake(self.width - btnR - 10.0f, 0.0f, btnR, btnR);
        [_favBtn setImage:[UIImage imageNamed:@"fav_unsel"] forState:UIControlStateNormal];
        [_favBtn setImage:[UIImage imageNamed:@"fav_sel"] forState:UIControlStateSelected];
    }
    return _favBtn;
}
-(UILabel *)priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, self.height - 40.0f , 220.0f, 30.0f)];
        _priceLabel.alpha = ALPHLA_BUTTON;
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        [_priceLabel setFont:[UIFont systemFontOfSize:FontMaxSize]];
        [_priceLabel setTextColor:Color_White];
    }
    return _priceLabel;
}
//页码控制器
-(UIPageControl *)pageControl
{
    if(!_pageControl)
    {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 200.0f)/2, self.height - 60.0f, 200.0f, 30.0f)];
    }
    return _pageControl;
}
#pragma mark --
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.pageControl.currentPage = self.imageScroll.contentOffset.x/SCREEN_WIDTH;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
