//
//  ImageSCrollViewController.m
//  JuPlus
//
//  Created by admin on 15/7/24.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ZoomImageViewController.h"

@interface ZoomImageViewController ()

@end

@implementation ZoomImageViewController
{
    CGFloat _x;// 取得缩放图片的位置
    int _n; // scollview偏移量
    float _scale;// 缩放倍数
}
@synthesize imageDataArray;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title=@"详细大图";
        
    }
    return self;
}

-(void)backPress:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    //隐藏或显示导航栏。如果动画,它将使用
   	[self.navigationController setNavigationBarHidden:YES animated:NO];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSLog(@"%@",imageDataArray);
        
    //返回
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame=CGRectMake(0, 0, 52, 30);
    [button2 setImage:[UIImage imageNamed:@"back_n_g@2x.png"] forState:UIControlStateNormal];
    // [button2 setImage:[UIImage imageNamed:@"back_selected@2x.png"] forState:UIControlStateHighlighted];
    [button2 addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *barButton2=[[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.leftBarButtonItem=barButton2;
    
    
    [self.view setBackgroundColor:[UIColor blackColor]];
    
    
    //添加滚动视图
    myScrollView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    myScrollView.contentSize=CGSizeMake(SCREEN_WIDTH*[imageDataArray count], PICTURE_HEIGHT);
    myScrollView.delegate=self;
    myScrollView.pagingEnabled=YES;
    myScrollView.backgroundColor = [UIColor blackColor];
    
    
    for (int i=0; i<[imageDataArray count]; i++) {
        
        NSDictionary * dic=[imageDataArray objectAtIndex:i];
       VIPhotoView *imgView=[[VIPhotoView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*i, 0, SCREEN_WIDTH, myScrollView.height) andImage:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]]];
        [myScrollView addSubview:imgView];
    }
    [self.view addSubview:myScrollView];
    myScrollView.contentOffset =CGPointMake(SCREEN_WIDTH*self.tag, 0.0f);
    
}

-(void)changeImage:(UITapGestureRecognizer *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
