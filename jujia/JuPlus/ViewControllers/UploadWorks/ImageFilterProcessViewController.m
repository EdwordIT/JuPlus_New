//
//  ImageFilterProcessViewController.m
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-7-9.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import "ImageFilterProcessViewController.h"
#import "ImageUtil.h"
#import "ColorMatrix.h"
#import "IphoneScreen.h"
#import "MarkTagsViewController.h"
@interface ImageFilterProcessViewController ()<UIGestureRecognizerDelegate,UIScrollViewDelegate>
@property (nonatomic,strong)UIButton *sureBtn;
@end

@implementation ImageFilterProcessViewController
@synthesize currentImage = currentImage, delegate = delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.titleLabel.text = @"发布作品";
    
    [self.view setBackgroundColor:[UIColor colorWithWhite:0.388 alpha:1.000]];
    rootImageView = [[UIImageView alloc ] initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, PICTURE_HEIGHT)];
    rootImageView.image = currentImage;
    [self.view addSubview:rootImageView];
    
    NSArray *arr = [NSArray arrayWithObjects:@"原图",@"LOMO",@"复古",@"哥特",@"淡雅",@"酒红",@"青柠",@"浪漫",@"光晕",@"蓝调",@"梦幻",@"夜色", nil];
    scrollerView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, rootImageView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT - rootImageView.bottom)];
    scrollerView.backgroundColor = [UIColor whiteColor];
    scrollerView.indicatorStyle = UIScrollViewIndicatorStyleBlack;
    scrollerView.showsHorizontalScrollIndicator = NO;
    scrollerView.delegate = self;
    scrollerView.showsVerticalScrollIndicator = NO;//关闭纵向滚动条
    scrollerView.bounces = NO;
    [self.view addSubview:scrollerView];

    CGFloat orignX = 0 ;
    CGFloat imgW = 60.0f;
    CGFloat space = 10.0f;

    for(int i=0;i<[arr count];i++)
    {
        orignX = 10 + (imgW +space)*i;
        
        UIButton *bgImageView = [UIButton buttonWithType:UIButtonTypeCustom];
        bgImageView.frame = CGRectMake(orignX, space, imgW, imgW);
        [bgImageView setTag:i];
        bgImageView.layer.masksToBounds = imgW;
        bgImageView.layer.cornerRadius = imgW/2;
        UIImage *bgImage = [self changeImage:i imageView:nil];
        [bgImageView setImage:bgImage forState:UIControlStateNormal];;
        [scrollerView addSubview:bgImageView];
        [bgImageView addTarget:self action:@selector(setImageStyle:) forControlEvents:UIControlEventTouchUpInside];
        [bgImageView release];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(orignX, bgImageView.bottom+space/2, imgW, 20)];
        [label setBackgroundColor:[UIColor clearColor]];
        [label setText:[arr objectAtIndex:i]];
        [label setTextAlignment:NSTextAlignmentCenter];
        [label setFont:FontType(FontSize)];
        [label setTextColor:Color_Basic];
        [label setUserInteractionEnabled:YES];
        [label setTag:i];
        
        [scrollerView addSubview:label];
        [label release];

    }
    scrollerView.contentSize = CGSizeMake(orignX + imgW +space, scrollerView.height);
    
	// Do any additional setup after loading the view.
    [self.view addSubview:self.sureBtn];
}
#pragma mark --scrollViewDelegate
-(UIButton *)sureBtn
{
    if(!_sureBtn)
    {
        _sureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
        [_sureBtn.titleLabel setFont:FontType(FontSize)];
        [_sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sureBtn setTitle:@"确认" forState:UIControlStateNormal];
        [_sureBtn setBackgroundColor:Color_Basic];
        _sureBtn.alpha = ALPHLA_BUTTON;
        [_sureBtn addTarget:self action:@selector(sureBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sureBtn;
}
//确认进入打标签界面
-(void)sureBtnPress:(UIButton *)sender
{
    MarkTagsViewController *mark = [[MarkTagsViewController alloc]init];
    mark.postImage = rootImageView.image;
    [self.navigationController pushViewController:mark animated:YES];
}
//点击效果点击事件
- (void)setImageStyle:(UIButton *)sender
{
    UIImage *image =   [self changeImage:sender.tag imageView:nil];
    [rootImageView setImage:image];
   CGFloat orignX = (70.0f)*(sender.tag - 2);
    if (orignX>0) {
        [UIView animateWithDuration:0.5 animations:^{
            [scrollerView setContentOffset:CGPointMake(orignX, 0.0f)];
        }];
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(UIImage *)changeImage:(int)index imageView:(UIImageView *)imageView
{
    UIImage *image = nil;
    switch (index) {
        case 0:
        {
            return currentImage;
        }
            break;
        case 1:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_lomo];
        }
            break;
        case 2:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_huajiu];
        }
            break;
        case 3:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_gete];
        }
            break;
        case 4:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_danya];
        }
            break;
        case 5:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_jiuhong];
        }
            break;
        case 6:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_qingning];
        }
            break;
        case 7:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_langman];
        }
            break;
        case 8:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_guangyun];
        }
            break;
        case 9:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_landiao];
            
        }
            break;
        case 10:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_menghuan];
        
        }
            break;
        case 11:
        {
            image = [ImageUtil imageWithImage:currentImage withColorMatrix:colormatrix_yese];
            
        }
    }
    return image;
}

- (void)dealloc
{
    [super dealloc];
    scrollerView = nil;
    rootImageView = nil;
    [currentImage release],currentImage  =nil;
    
}
@end
