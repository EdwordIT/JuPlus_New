//
//  GuideViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "GuideViewController.h"
#import "HomeFurnishingViewController.h"
@interface GuideViewController()<UIScrollViewDelegate>
{
    NSArray *guideArr1;
}
@property(nonatomic,strong)UIPageControl *pageControl;
@end

@implementation GuideViewController
@synthesize pageControl;
-(void)viewDidLoad
{
    [super viewDidLoad];
    [self initGuide];
    if (self.isFromSetting) {
        UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        leftBtn.frame = CGRectMake(0.0f, 20.0f, 44.0f, 44.0f);
        [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
        [leftBtn addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:leftBtn];
    }
}
-(void)backPress
{
    [self.navigationController popViewControllerAnimated:YES];
}
//隐藏状态栏                                                                                                                                                                                                                
-(BOOL)prefersStatusBarHidden
{
   // setStatusBarHidden:withAnimation 3.2之后不再使用
    return YES;
}
#pragma mark initGuide

-(void)initGuide
{
    UIScrollView *sv=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH , SCREEN_HEIGHT)];
    sv.delegate=self;
    sv.showsHorizontalScrollIndicator = NO;  //控制是否显示水平方向的滚动条
    sv.showsVerticalScrollIndicator = NO;     //是否显示垂直方向滚动条
    sv.bounces = NO;      //控制触到边缘是否反弹
    sv.alwaysBounceHorizontal = NO;   //触到垂直方向是否反弹
    sv.alwaysBounceVertical = NO;      //触到水平方向是否反弹
    sv.pagingEnabled = YES;               //控制翻动时是否整页翻动
    [self.view addSubview:sv];
    
    CGFloat pageControlHeight = 20.0f;
    pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 100.0f)/2, SCREEN_HEIGHT-30.0f, 100.0f, pageControlHeight)];
    pageControl.layer.masksToBounds = YES;
    pageControl.layer.cornerRadius = 10.0f;
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.pageIndicatorTintColor = RGBACOLOR(242, 114, 128, 0.4);
    pageControl.currentPageIndicatorTintColor = Color_Pink;
    pageControl.userInteractionEnabled = NO;
    [self.view addSubview:pageControl];
    
//   guideArr1 = [NSArray arrayWithObjects:@"yd1@2x.jpg",@"yd2@2x.jpg",@"yd3@2x.jpg", nil];
    guideArr1 = [NSArray arrayWithObjects:@"yd1@2x.jpg", nil];

    sv.contentSize=CGSizeMake(SCREEN_WIDTH*[guideArr1 count]+0.5, SCREEN_HEIGHT);
    pageControl.numberOfPages = [guideArr1 count];
    
    
    for(int i=0;i<[guideArr1 count];i++)
    {
        NSString *imageString = [guideArr1 objectAtIndex:i];
        
        UIImageView *guideImageView=[[UIImageView alloc]initWithImage:[UIImage imageNamed:imageString]];
        guideImageView.frame = CGRectMake(SCREEN_WIDTH*i, 0.0f, sv.width, sv.height);
        guideImageView.userInteractionEnabled=YES;
        [sv addSubview:guideImageView];
        
        if (!self.isFromSetting) {
            if(i+1==[guideArr1 count])
            {
                CGFloat btnHeight = 120.0f;
                CGFloat btnWidth  = SCREEN_WIDTH;
                guideImageView.userInteractionEnabled = YES;
                CGRect frame = CGRectMake((SCREEN_WIDTH-btnWidth)/2, SCREEN_HEIGHT-btnHeight, btnWidth, btnHeight);
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = frame;
                
                [btn addTarget:self action:@selector(goMain) forControlEvents:UIControlEventTouchUpInside];
                [guideImageView addSubview:btn];
                
            }
            
        }
    }
}
-(void)goMain
{
    HomeFurnishingViewController *home = [[HomeFurnishingViewController alloc]init];
    [self.navigationController pushViewController:home animated:NO];
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!self.isFromSetting) {
        if (scrollView.contentOffset.x>([guideArr1 count]-1)*SCREEN_WIDTH) {
            [self goMain];
        }
    }
   }
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    pageControl.currentPage = scrollView.contentOffset.x/SCREEN_WIDTH;
}
@end
