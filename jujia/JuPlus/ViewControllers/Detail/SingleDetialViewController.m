//
//  SingleDetialViewController.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "SingleDetialViewController.h"
#import "SingleDetailReq.h"
#import "SingleDetailRespon.h"
#import "SingleDetailDTO.h"
#import "PostFaverReq.h"
#import "DeleteFavReq.h"
#import "PlaceOrderViewController.h"
#import "LoginViewController.h"
#import "productOrderDTO.h"
#import "ZoomImageViewController.h"
#import "UINavigationController+RadialTransaction.h"
#import "PackageViewController.h"
@implementation SingleDetialViewController
{
    SingleDetailReq *detailReq;
    SingleDetailRespon *detailRespon;
    
    UIView *topV;
}
#define space 20.0f
-(void)viewDidLoad
{
    [super viewDidLoad];
    self.titleLabel.text = @"单品详情";
    [self.leftBtn setHidden:NO];
}
-(void)loadBaseUI
{
    //滚动展示图层
    [self.view addSubview:self.backScroll];
    [self.backScroll addSubview:self.topView];
    [self.backScroll addSubview:self.attractivedImg];
    //需要出层级显示效果的view
    [self.backScroll addSubview:self.bottomV];
    [self.bottomV addSubview:self.titleL];
    [self.bottomV addSubview:self.descripLabel];
    [self.leftBtn setHidden:YES];
   
      UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0.0f, self.navView.height -44.0f, 44.0f, 44.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];
    //信息展示
    [self.bottomV addSubview:self.basisView];
    [self.basisView addSubview:self.basisLabel];
    [self.basisView addSubview:self.basisScroll];
    [self.view addSubview:self.placeOrderBtn];
    //猜你喜欢
    [_backScroll addSubview:self.relativedView];
    

}
-(void)backPress:(UIButton *)button
{
    if(self.isfromPackage)
    {
        UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
        backV.alpha = 0.99;
        backV.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
        [self.view addSubview:backV];
        [UIView animateWithDuration:1.0f animations:^{
            backV.alpha = 1;
        } completion:^(BOOL finished) {
            [backV removeFromSuperview];
        }];

    [self.navigationController radialPopViewControllerWithDuration:0.8 withStartFrame:CGRectMake(self.point.x, self.point.y, 50.0f, 50.0f) comlititionBlock:^{
    }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }

}
#pragma mark --Reqeust
#pragma mark --数据刷新
-(void)reloadNetWorkError
{
    [self startRequest];
}
-(void)startRequest
{
    detailReq = [[SingleDetailReq alloc]init];
    [detailReq setField:self.singleId forKey:@"productNo"];
    [detailReq setField:[CommonUtil getToken] forKey:TOKEN];
    detailRespon = [[SingleDetailRespon alloc]init];
    [HttpCommunication request:detailReq getResponse:detailRespon Success:^(JuPlusResponse *response) {
        //请求成功之后 处理
        if ([detailRespon.status integerValue]==3) {
            [self.topView setHidden:NO];
            [self.attractivedImg setHidden:YES];
            //图片数据
            [self fileImageData];
            topV = self.topView;
        }else
        {
            [self.topView setHidden:YES];
            [self.attractivedImg setHidden:NO];
            topV = self.attractivedImg;
        }
        
        if (IsStrEmpty(detailRespon.htmlString)) {


            self.descripLabel.frame = CGRectMake(space,space, SCREEN_WIDTH - space*2, 0.0f);
            self.bottomV.frame = CGRectMake(self.bottomV.left, topV.bottom, self.bottomV.width, self.basisView.height);
            [self.titleL setHidden:YES];
            [self.descripLabel setHidden:YES];

        }else{
            //加载描述
            [self fileExplainTxt];
        }
        if (IsArrEmpty(detailRespon.basisArray)) {
        
            self.basisView.frame = CGRectMake(0.0f, self.descripLabel.bottom+space, SCREEN_WIDTH, 0.0f);
            self.bottomV.frame = CGRectMake(self.bottomV.left, topV.bottom, self.bottomV.width, self.descripLabel.bottom);
            [self.basisView setHidden:YES];
        }else{
            //加载主要成分
            [self fileBasisScroll];
        }
        //重置布局
        [self reloadRect];
        //猜你喜欢view值
        
        [self fileRelative];

        if (IsArrEmpty(detailRespon.packageList)) {
            
        self.relativedView.frame = CGRectMake(self.relativedView.left, topV.bottom+2*space+self.basisView.height+self.descripLabel.height+self.titleL.height, SCREEN_WIDTH, self.relativedView.height);

   
            [self.relativedView setHidden:YES];
        }
        self.relativedView.frame = CGRectMake(self.relativedView.left, self.bottomV.bottom, SCREEN_WIDTH, self.relativedView.height);

        
        self.backScroll.contentSize = CGSizeMake(SCREEN_WIDTH, self.relativedView.bottom);
        
        
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    
}
#pragma mark --fileData
-(void)fileImageData
{
    [self.topView.favBtn addTarget:self action:@selector(favBtnClick:) forControlEvents:UIControlEventTouchUpInside];

    if ([detailRespon.isFav intValue]==1) {
        [self.topView.favBtn setSelected:YES];
    }
    for(int i=0;i<[detailRespon.imageArray count];i++)
    {
        NSDictionary *dic = [detailRespon.imageArray objectAtIndex:i];
        UIButton *img = [[UIButton alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0.0f, self.topView.imageScroll.width, self.topView.imageScroll.height)];
        [img setBackgroundImage:[UIImage imageNamed:@"default_square"] forState:UIControlStateNormal];
        [img setimageUrl:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]] placeholderImage:nil];
        img.tag = i;
        [img addTarget:self action:@selector(imgPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.topView.imageScroll addSubview:img];
    }
    
    self.topView.imageScroll.contentSize = CGSizeMake(SCREEN_WIDTH*[detailRespon.imageArray count], PICTURE_HEIGHT);
    
    [self.topView bringSubviewToFront:self.topView.pageControl];
    [self.topView.priceLabel setPriceTxt:detailRespon.price];
    
}
-(void)imgPressed:(UIButton *)sender
{
    ZoomImageViewController *img = [[ZoomImageViewController alloc]init];
    img.imageDataArray = detailRespon.imageArray;
    img.tag = sender.tag;
    [self presentViewController:img animated:YES completion:^{
        
    }];
}
-(void)fileExplainTxt
{
    //描述文字
    [self.descripLabel setText:detailRespon.htmlString];
    CGSize optimumSize = [self.descripLabel optimumSize];
    CGRect frame = [self.descripLabel frame];
    frame.size.height = (int)optimumSize.height+10; //
    [self.descripLabel setFrame:frame];
}
//主要成分内容
-(void)fileBasisScroll
{
    if ([detailRespon.packageList count]!=0) {
        for(int i=0;i<[detailRespon.packageList count];i++)
        {
            CGFloat imgW = 50.0f;
            NSDictionary *dic = [detailRespon.packageList objectAtIndex:i];
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgBtn.frame = CGRectMake(space, i*(imgW+space/2),imgW, imgW);
            imgBtn.layer.masksToBounds = YES;
            imgBtn.layer.cornerRadius = imgW/2;
            [imgBtn setimageUrl:[NSString stringWithFormat:@"%@",[dic objectForKey:@"imgUrl"]] placeholderImage:nil];

            [self.basisScroll addSubview:imgBtn];
        }
        self.basisScroll.contentSize = CGSizeMake(60*[detailRespon.packageList count], self.basisScroll.height);
        self.basisView.frame = CGRectMake(0.0f, self.descripLabel.bottom +space, SCREEN_WIDTH,130.0f);
    }
    else
        self.basisView.frame = CGRectMake(0.0f, self.descripLabel.bottom +space, self.basisView.width, 0.0f);
}
//滚动范围
-(void)reloadRect
{

    self.bottomV.frame = CGRectMake(0.0f, topV.bottom, SCREEN_WIDTH,self.basisView.bottom+10.0f);

}
#pragma mark --loadUI
-(ImageScrollView *)topView
{
    if(!_topView)
    {
        _topView = [[ImageScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT)];
    }
    return _topView;
}
-(UIImageView *)attractivedImg
{
    if(!_attractivedImg)
    {
        _attractivedImg = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, (SCREEN_WIDTH * 21)/64)];
        [_attractivedImg setImage:[UIImage imageNamed:@"attractiving@2x.jpg"]];
        [_attractivedImg setHidden:YES];
    }
    return _attractivedImg;
}
-(UIScrollView *)backScroll
{
    if(!_backScroll)
    {
        _backScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f , self.navView.bottom, SCREEN_WIDTH, view_height)];
    }
    return _backScroll;
}
-(JuPlusUIView *)bottomV
{
    if(!_bottomV)
    {
        _bottomV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.topView.bottom, SCREEN_WIDTH, view_height - self.topView.top)];
    }
    return _bottomV;
}
-(UILabel *)titleL
{
    if(!_titleL)
    {
        _titleL = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, space, self.bottomV.width, 20.0f)];
        _titleL.textAlignment = NSTextAlignmentCenter;
        _titleL.textColor = Color_Basic;
        _titleL.text = @"单品详情";
        [_titleL setFont:FontType(FontSize)];

    }
    return _titleL;
}
-(RTLabel *)descripLabel
{
    if(!_descripLabel)
    {
        _descripLabel = [[RTLabel alloc]initWithFrame:CGRectMake(space,self.titleL.bottom, SCREEN_WIDTH - space*2, 100.0f)];
        [_descripLabel setFont:FontType(FontSize)];
        
    }
    return _descripLabel;
}
-(JuPlusUIView *)basisView
{
    if(!_basisView)
    {
        _basisView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.descripLabel.bottom+space, SCREEN_WIDTH, 120.0f)];
        _basisView.layer.masksToBounds = YES;
    }
    return _basisView;
}
-(UILabel *)basisLabel
{
    if (!_basisLabel) {
        
        _basisLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, space, self.basisView.width, 20.0f)];
        _basisLabel.textAlignment = NSTextAlignmentCenter;
        _basisLabel.textColor = Color_Basic;
        self.basisLabel.text = @"主要成分";
        [_basisLabel setFont:FontType(FontSize)];
        
    }
    return _basisLabel;
}
-(UIScrollView *)basisScroll
{
    if(!_basisScroll)
    {
        _basisScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(space, self.basisLabel.bottom + space, self.basisView.width, 60.0f)];
    }
    return _basisScroll;
}
-(UIButton *)placeOrderBtn
{
    if(!_placeOrderBtn)
    {
        _placeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _placeOrderBtn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
        [_placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_placeOrderBtn setTitle:@"单品购买" forState:UIControlStateNormal];
        [_placeOrderBtn setBackgroundColor:Color_Pink];
        [_placeOrderBtn.titleLabel setFont:FontType(FontSize)];
        _placeOrderBtn.alpha = ALPHLA_BUTTON;
        [_placeOrderBtn addTarget:self action:@selector(payPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeOrderBtn;
}
//猜你喜欢
-(JuPlusUIView *)relativedView
{
    if(!_relativedView)
    {
        _relativedView = [[JuPlusUIView alloc]init];
        _relativedView.autoresizingMask = YES;
        UILabel *title  = [[UILabel alloc]initWithFrame:CGRectMake(space, 0.0f, self.backScroll.width - space*2, 30.0f)];
        [title setText:@"猜你喜欢"];
        [title setFont:FontType(FontSize)];
        [title setTextColor:Color_Basic];
        title.textAlignment = NSTextAlignmentCenter;
        [_relativedView addSubview:title];
        
    }
    return _relativedView;
    
}
////猜你喜欢
-(void)fileRelative
{
    if([detailRespon.packageList count]>0)
    {
        for (int i =0; i<[detailRespon.packageList count]; i++) {
            
            NSDictionary *relateDic = [detailRespon.packageList objectAtIndex:i];
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            CGFloat btnH = (SCREEN_WIDTH - 2*space-space/2) / 2;

            imgBtn.frame = CGRectMake(space+(i%2)*(space/2 +btnH), 2*space +(i/2)*(btnH +space/2), btnH, btnH);

            [imgBtn setBackgroundImage:[UIImage imageNamed:@"default_square"] forState:UIControlStateNormal];
            [imgBtn setimageUrl:[relateDic objectForKey:@"coverUrl"] placeholderImage:nil];
            [imgBtn setTitle:[relateDic objectForKey:@"coverUrl"] forState:UIControlStateNormal];
            [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            imgBtn.tag = [[relateDic objectForKey:@"collocatePicNo"] intValue];
            [imgBtn addTarget:self action:@selector(relativBut:) forControlEvents:UIControlEventTouchUpInside];
            [self.relativedView addSubview:imgBtn];

            if (i==[detailRespon.packageList count]-1) {
                 self.relativedView.frame = CGRectMake(self.relativedView.left, self.relativedView.top, self.relativedView.width, imgBtn.bottom +TABBAR_HEIGHT+space/2);
              
            }
        }
    }
}
//猜你喜欢点击事件
-(void)relativBut:(UIButton *)sender
{
    //先给本界面加白色底层
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
    backV.backgroundColor = Color_White;
    [self.view addSubview:backV];
    //在白色底层上添加转场动画
    UIImageView *imageView = [[UIImageView alloc] initWithImage:sender.currentBackgroundImage];
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
//    CGRect frameInSuperview = [sender convertRect:sender.frame toView:self.view];
    // frameInSuperview.origin.y -=39;
    CGRect frameInSuperview = [self.view convertRect:sender.frame fromView:self.relativedView];

    frameInSuperview.origin.x = sender.origin.x;
    imageView.frame = frameInSuperview;
    [backV addSubview:imageView];
    
    CGRect rect = imageView.frame;
    [UIView animateWithDuration:0.5 animations:^{
        imageView.frame = CGRectMake(0.0f, nav_height, PICTURE_HEIGHT, PICTURE_HEIGHT);
    } completion:^(BOOL finished) {
        PackageViewController *pack = [[PackageViewController alloc]init];
        pack.regNo = [NSString stringWithFormat:@"%ld",(long)sender.tag];
        pack.popSize = rect;
        pack.imgUrl = sender.titleLabel.text;
        pack.isAnimation = YES;
        [self.navigationController pushViewController:pack animated:NO];
        [backV setHidden:YES];
        
    }];
    
}
#pragma mark --btnPress
//收藏、取消收藏
-(void)favBtnClick:(UIButton *)sender
{
    if([CommonUtil isLogin])
    {
        if(sender.selected==YES)
        {
            [self cancelFav];
        }
        else
        {
            [self postFav];
        }
    }
    else
    {
        [self login];
    }
}
//取消收藏
-(void)cancelFav
{
    DeleteFavReq *req = [[DeleteFavReq alloc]init];
    JuPlusResponse *respon =[[JuPlusResponse alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.singleId forKey:@"objNo"];
    [req setField:@"1" forKey:@"objType"];

    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self.topView.favBtn startAnimation];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];

}
//添加收藏
-(void)postFav
{
    PostFaverReq *req = [[PostFaverReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.singleId forKey:@"objNo"];
    [req setField:@"1" forKey:@"objType"];

    JuPlusResponse *respon =[[JuPlusResponse alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self.topView.favBtn startAnimation];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
//点击购买
-(void)payPress
{
    if([CommonUtil isLogin])
    {
        if([detailRespon.status intValue]!=3)
        {
            [self showAlertView:@"该单品尚未通过审核" withTag:0];
        }
        else
        {
        PlaceOrderViewController *order = [[PlaceOrderViewController alloc]init];
        productOrderDTO *singleDTO = [[productOrderDTO alloc]init];
        singleDTO.productNo = self.singleId;
        singleDTO.regNo = self.regNo;
        singleDTO.imgUrl = [[detailRespon.imageArray firstObject] objectForKey:@"imgUrl"];
        singleDTO.price = detailRespon.price;
        singleDTO.productName = detailRespon.proName;
        singleDTO.countNum = @"1";
        order.regArray = [NSArray arrayWithObjects:singleDTO, nil];
      [self.navigationController pushViewController:order animated:YES];
        }
    }
    else
    {
        [self login];
    }
}
-(void)login
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}
@end
