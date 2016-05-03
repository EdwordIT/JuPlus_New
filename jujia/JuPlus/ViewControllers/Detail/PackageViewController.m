//
//  PackageViewController.m
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PackageViewController.h"
#import "InfoDisplayView.h"
#import "PackageReq.h"
#import "PackageRespon.h"
#import "PostFaverReq.h"
#import "DeleteFavReq.h"
#import "SingleDetialViewController.h"
#import "LabelDTO.h"
#import "LabelView.h"
#import "LoginViewController.h"
#import "PlaceOrderViewController.h"
#import "productOrderDTO.h"
#import "UINavigationController+RadialTransaction.h"
#import "DesignerDetailViewController.h"
#import "ZoomImageViewController.h"
#import "ToastView.h"
#import "UMSocial.h"
#import "BespeakColRequest.h"
#import "MyAppointViewController.h"
#import "CommentLabel.h"
#import "CommentListViewController.h"
#import "PostCommentReq.h"
@interface PackageViewController ()<ToastViewDelegate,UMSocialUIDelegate>
#define space 10.0f
@property (nonatomic,strong)ToastView *toast;

@property (nonatomic,strong)UIView *backView;

//购买
@property (nonatomic,strong)UIButton *placeOrderBtn;
//套餐详情
@property(nonatomic,strong)UIButton *packageImageV;

@property (nonatomic,strong)UILabel *priceLabel;

@property (nonatomic,strong)UIButton *favBtn;
//可滑动的背景
@property (nonatomic,strong)UIScrollView *backScroll;

@property (nonatomic,strong)UIView *secBackScroll;
//搭配师头像
@property (nonatomic,strong)UIButton *designIcon;
//搭配师名称
@property (nonatomic,strong)UILabel *nameLabel;
//体验店
@property (nonatomic,strong)InfoDisplayView *addressView;
//简介
@property (nonatomic,strong)InfoDisplayView *displayView;
//套装下的单品介绍
@property (nonatomic,strong)JuPlusUIView *productListV;
//猜你喜欢
@property (nonatomic,strong)JuPlusUIView *relativedView;
//滚动层
@property (nonatomic,strong)UIScrollView *relativedScroll;
//添加评论层
@property (nonatomic,strong)JuPlusUIView *commentView;
//提交评论
@property (nonatomic,strong)UIView *postComView;
//输入框
@property (nonatomic,strong)UITextField *postTF;
//提交评论
@property (nonatomic,strong)UIButton *postBtn;

@end
@implementation PackageViewController
{
    PackageReq *req;
    PackageRespon *respon;
    UIImage *shareImage;
    UIImageView *shareImgV;
    CGFloat rectW1;
    CGFloat rectW2;
    //评论相关
    NSMutableArray *comLabels;
    
    BOOL isShowKeyboard;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.frame = CGRectMake(50.0f, self.titleLabel.top, self.navView.width - 100.0f, self.titleLabel.height);
    rectW1 = (SCREEN_WIDTH - space*3)/2;
    rectW2 = (SCREEN_WIDTH - space*4)/3;
    [self.rightBtn setImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
    [self.rightBtn setHidden:NO];
    [self.rightBtn addTarget:self action:@selector(sharePress:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.backScroll];
    [self.view bringSubviewToFront:self.navView];
    [self.backScroll addSubview:self.packageImageV];
    [self.packageImageV addSubview:self.favBtn];
    [self.packageImageV addSubview:self.priceLabel];

    [self.backScroll addSubview:self.secBackScroll];
    [self.view addSubview:self.designIcon];
    //地址
    [self.secBackScroll addSubview:self.addressView];
    //搭配师理念介绍
    [self.secBackScroll addSubview:self.displayView];
    //添加评论相关内容
    [self.secBackScroll addSubview:self.commentView];
    [self.commentView addSubview:self.postComView];
    [self.postComView addSubview:self.postTF];
    [self.postComView addSubview:self.postBtn];
    //组成此搭配的单品列表
    [self.secBackScroll addSubview:self.productListV];
    //此搭配相关的其他搭配列表
    [self.secBackScroll addSubview:self.relativedView];
    [self.relativedView addSubview:self.relativedScroll];
    [self.view addSubview:self.placeOrderBtn];
    [self addToastView];
    // Do any additional setup after loading the view.
    //自定义转场动画
    [self.leftBtn setHidden:YES];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0.0f, self.navView.height -44.0f, 44.0f, 44.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];
    comLabels = [[NSMutableArray alloc]init];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}
-(void)backPress:(UIButton *)sender
{
    if(self.isAnimation)
    {
        for (UIView *view in self.packageImageV.subviews) {
            if (![view isKindOfClass:[UIImageView class]]) {
                [view removeFromSuperview];
            }
        }
    CGRect newF = CGRectMake(self.popSize.origin.x,+ self.backScroll.contentOffset.y+self.popSize.origin.y-nav_height, self.popSize.size.width, self.popSize.size.height);
    [UIView animateWithDuration:0.5 animations:^{
        self.secBackScroll.alpha = 0;
        self.designIcon.alpha = 0;
    } completion:^(BOOL finished) {
        [UIView  animateWithDuration:0.5f animations:^{
            self.packageImageV.frame = newF;
        } completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];
        }];
    }];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark --uifig
-(ToastView *)toast
{
    if(!_toast)
    {
        CGFloat toastH = (SCREEN_WIDTH - 84.0f)+95.0f;
        _toast = [[ToastView alloc]initWithFrame:CGRectMake(40.0f, (SCREEN_HEIGHT - toastH)/2, SCREEN_WIDTH - 80.0f, toastH) title:nil];
        _toast.delegate = self;
    }
    return _toast;
}
-(UIView *)backView
{
    if(!_backView)
    {
        _backView = [[UIView alloc]initWithFrame:self.view.bounds];
        _backView.userInteractionEnabled = YES;
        _backView.backgroundColor = RGBACOLOR(0, 0, 0, 0.7);
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hiddenToastView)];
        [_backView addGestureRecognizer:ges];
    }
    return _backView;
}
-(UIButton *)placeOrderBtn
{
    if(!_placeOrderBtn)
    {
        _placeOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _placeOrderBtn.frame = CGRectMake(0.0f, SCREEN_HEIGHT - 44.0f, SCREEN_WIDTH, 44.0f);
        [_placeOrderBtn.titleLabel setFont:FontType(FontSize)];
        [_placeOrderBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_placeOrderBtn setTitle:@"购买全部单品" forState:UIControlStateNormal];
        [_placeOrderBtn setBackgroundColor:Color_Pink];
        _placeOrderBtn.alpha = ALPHLA_BUTTON;
        [_placeOrderBtn addTarget:self action:@selector(payPress) forControlEvents:UIControlEventTouchUpInside];
    }
    return _placeOrderBtn;
}

-(UIButton *)packageImageV
{
    if(!_packageImageV)
    {
        _packageImageV = [UIButton buttonWithType:UIButtonTypeCustom];
        _packageImageV.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, PICTURE_HEIGHT);
        [_packageImageV setimageUrl:self.imgUrl placeholderImage:nil];
        [_packageImageV addTarget:self action:@selector(ZoomImage) forControlEvents:UIControlEventTouchUpInside];
    }
    return _packageImageV;
}
-(UIButton *)favBtn
{
    if(!_favBtn)
    {
        CGFloat btnR = 50.0f;
        _favBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_favBtn setImage:[UIImage imageNamed:@"fav_unsel"] forState:UIControlStateNormal];
        [_favBtn setImage:[UIImage imageNamed:@"fav_sel"] forState:UIControlStateSelected];
        _favBtn.frame = CGRectMake(self.packageImageV.width - btnR - 10.0f, 10.0f, btnR, btnR);
        [_favBtn addTarget:self action:@selector(favBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _favBtn;
}
-(UILabel *)priceLabel
{
    if(!_priceLabel)
    {
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0.0f, self.packageImageV.height - 40.0f , 220.0f, 30.0f)];
        _priceLabel.textAlignment = NSTextAlignmentCenter;
        _priceLabel.alpha = ALPHLA_BUTTON;
        [_priceLabel setFont:[UIFont systemFontOfSize:FontMaxSize]];
        [_priceLabel setTextColor:Color_White];
    }
    return _priceLabel;
}
-(UIScrollView *)backScroll
{
    if(!_backScroll)
    {
        _backScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
        _backScroll.delegate = self;
        _backScroll.showsVerticalScrollIndicator = NO;
    }
    return _backScroll;
}
-(UIView *)secBackScroll
{
    if(!_secBackScroll)
    {
        _secBackScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, PICTURE_HEIGHT, SCREEN_WIDTH, view_height)];
        _secBackScroll.backgroundColor = Color_White;
        _secBackScroll.alpha = 0;
    }
    return _secBackScroll;
}

-(UIButton *)designIcon
{
    if(!_designIcon)
    {
        CGFloat imgW = 50.0f;
        _designIcon = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width - 60.0f,nav_height + PICTURE_HEIGHT -imgW/2, imgW, imgW)];
        _designIcon.layer.borderColor = [Color_White CGColor];
        _designIcon.layer.borderWidth = 1.0f;
        _designIcon.layer.cornerRadius = imgW/2;
        _designIcon.layer.masksToBounds =YES;
        _designIcon.alpha = 0;
        [_designIcon addTarget:self action:@selector(designerPress:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _designIcon;
}
-(InfoDisplayView *)addressView
{
    if(!_addressView)
    {
        _addressView = [[InfoDisplayView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.backScroll.width, 70.0f)];
        _addressView.headerL.text = @"预约地址";
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, _addressView.width, _addressView.height);
        [btn addTarget:self action:@selector(addressPress:) forControlEvents:UIControlEventTouchUpInside];
        [_addressView addSubview:btn];
    }
    return _addressView;
}
#pragma mark --About Comment
-(JuPlusUIView *)commentView
{
    if (!_commentView) {
        _commentView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.displayView.bottom+space, SCREEN_WIDTH, 50.0f)];
    }
    return _commentView;
}
-(UIView *)postComView
{
    if (!_postComView) {
        _postComView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, self.commentView.height - 50.f, self.secBackScroll.width, 50.0f)];
        
    }
    return _postComView;
}
-(UITextField *)postTF
{
    if (!_postTF) {
        _postTF = [[UITextField alloc]initWithFrame:CGRectMake(space, space, self.postComView.width - 70.0f, 30.0f)];
        _postTF.backgroundColor = Color_Bottom;
        _postTF.placeholder = @" 我要评论";
        _postTF.font = FontType(FontSize);
    }
    return _postTF;
}
-(UIButton *)postBtn
{
    if (!_postBtn) {
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _postBtn.frame = CGRectMake(self.postComView.width - 60.0f, space, 60.0f, 30.0f);
        [_postBtn setTitle:@"发送" forState:UIControlStateNormal];
        [_postBtn.titleLabel setFont:FontType(FontSize)];
        [_postBtn setTitleColor:Color_Pink forState:UIControlStateNormal];
        [_postBtn addTarget:self action:@selector(postComment:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _postBtn;
}
#pragma mark --评论相关内容
//提交评论
-(void)postComment:(UIButton *)sender
{
    if (self.postTF.text.length==0) {
        [self showAlertView:@"内容不能为空" withTag:0];
    }else{
        [self.postTF resignFirstResponder];
        PostCommentReq *comReq = [[PostCommentReq alloc]init];
        [comReq setField:[CommonUtil getToken] forKey:TOKEN];
        [comReq setField:self.regNo forKey:@"collocateNo"];
        [comReq setField:self.postTF.text forKey:@"contentText"];
        [comReq setField:@"0" forKey:@"answeredNo"];
        JuPlusResponse *comRespon = [[JuPlusResponse alloc]init];
        [HttpCommunication request:comReq getResponse:comRespon Success:^(JuPlusResponse *response) {
            [self startRequest];
            self.postTF.text = @"";
            //提交评论成功
        } failed:^(ErrorInfoDto *errorDTO) {
            [self errorExp:errorDTO];
        } showProgressView:YES with:self.view];
    }
}
#pragma mark --keyboardWillShow
-(void)keyboardWillShow:(NSNotification *)noti
{
    isShowKeyboard = YES;
    NSDictionary *info = [noti userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGFloat keyboardHeight = [value CGRectValue].size.height;
    [UIView animateWithDuration:ANIMATION animations:^{
        CGFloat designOrign = self.designIcon.origin.y - keyboardHeight;
        if(designOrign<nav_height)
            designOrign = nav_height;
        self.designIcon.frame = CGRectMake(self.designIcon.left, designOrign, self.designIcon.width, self.designIcon.height);
        self.backScroll.frame = CGRectMake(0.0f, self.backScroll.top - keyboardHeight, self.backScroll.width, self.backScroll.height);
    }];
    
}
-(void)keyboardWillHidden:(NSNotification *)noti
{
    isShowKeyboard = NO;
    [UIView animateWithDuration:ANIMATION animations:^{
        self.backScroll.frame = CGRectMake(0.0f,  nav_height, self.backScroll.width, self.backScroll.height);
        CGFloat iconY = nav_height+PICTURE_HEIGHT - 25.0f - self.backScroll.contentOffset.y;
        if(iconY<nav_height)
            iconY = nav_height;
        self.designIcon.frame = CGRectMake(self.designIcon.left, iconY, self.designIcon.width, self.designIcon.height);

    }];
}

#pragma mark --bespeak

//点击做客地址，弹出预约
-(void)addressPress:(UIButton *)sender
{
    if ([respon.visitFlag integerValue]==1) {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"您是否确定预约" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alt.tag = 10;
        [alt show];
    }
}
//确认预约
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag == 10){
        if (buttonIndex == 1) {
            //网络请求
            BespeakColRequest *appointReq = [[BespeakColRequest alloc]init];
            [appointReq setField:self.regNo forKey:@"objNo"];
            [appointReq setField:[CommonUtil getToken] forKey:TOKEN];
            [appointReq setField:@"2" forKey:@"objType"];
            JuPlusResponse *respon1 = [[JuPlusResponse alloc]init];
            [HttpCommunication request:appointReq getResponse:respon1 Success:^(JuPlusResponse *response) {
                [self appoin];
            } failed:^(ErrorInfoDto *errorDTO) {
                [self errorExp:errorDTO];
            } showProgressView:YES with:self.view];
            
        }
    }else if (alertView.tag ==11)
    {
        //预约成功后，跳转到预约列表界面
        MyAppointViewController *appoint = [[MyAppointViewController alloc]init];
        [self.navigationController pushViewController:appoint animated:YES];
    }
}
- (void)appoin
{
    
    [self showAlertView:@"恭喜您已预约成功" withTag:11];
    
}

-(InfoDisplayView *)displayView
{
    if(!_displayView)
    {
        _displayView = [[InfoDisplayView alloc]initWithFrame:CGRectMake(0.0f, self.addressView.bottom, self.backScroll.width, 70.0f)];
        _displayView.headerL.text = @"搭配师理念";
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(0.0f, 0.0f, _addressView.width, _addressView.height);
    }
    return _displayView;
}
-(JuPlusUIView *)productListV
{
    if(!_productListV)
    {
        _productListV = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.commentView.bottom+space, SCREEN_WIDTH, 100.0f)];
    }
    return _productListV;
}
-(JuPlusUIView *)relativedView
{
    if(!_relativedView)
    {
        _relativedView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, self.productListV.bottom, SCREEN_WIDTH, 140.0f)];
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
-(UIScrollView *)relativedScroll
{
    if(!_relativedScroll)
    {
        _relativedScroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 30.0f, self.relativedView.width, 110.0f)];
        _relativedScroll.showsVerticalScrollIndicator = NO;

    }
    return _relativedScroll;
}
#pragma mark --frame reload
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];

}
-(void)startRequest
{
    req = [[PackageReq alloc]init];

    [req setField:self.regNo forKey:@"collocateNo"];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    respon = [[PackageRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self fileData];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
#pragma mark --dataRequest
-(void)reloadNetWorkError
{
    [self startRequest];
}

#pragma mark --数据加载

-(void)fileData
{
    shareImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",FRONT_PICTURE_URL,respon.shareImgUrl]]]];
    [self.toast showShareView:shareImage];
    //是否收藏
    if([respon.isFav intValue]==1)
    {
        [self.favBtn setSelected:YES];
    }
    //价格
    [self.priceLabel setPriceTxt:respon.price];
    //底图
    [self.packageImageV setimageUrl:respon.imgUrl placeholderImage:nil];
    //加标签
    [self fileLabels];
    //搭配师
    [self.titleLabel setText:[NSString stringWithFormat:@"%@ 的作品",respon.designer]];
    [self.designIcon setimageUrl:respon.portraitUrl placeholderImage:nil];
    //地址
    if(IsStrEmpty(respon.address))
    {
        [self.addressView setHidden:YES];
        self.addressView.frame = CGRectMake(self.addressView.left, self.addressView.top, self.addressView.width, 0.0f);
    }else
    [self.addressView.textL setText:respon.address];
    //简介
    [self fileContent:respon.content];
    //添加评论内容
    [self fileCommentView];
    //单品介绍
    CGFloat productListVHeight;
    if([respon.labelArray count]<=1)
    {
        productListVHeight = 0.f;
    }
    else if ([respon.labelArray count]==2)
    {
        productListVHeight = rectW1+20.0f;
    }
    else if([respon.labelArray count]==3)
    {
        productListVHeight = rectW2+20.0f;
    }
    else
    {
        productListVHeight = rectW2+rectW1+30.0f;
    }
    self.productListV.frame = CGRectMake(0.0f,self.commentView.bottom , self.productListV.width, productListVHeight);

    //添加单品
    int count = [respon.labelArray count];
    if(count>1)
    {
        [self fileProductList:count];
    }
    //添加喜欢
    [self fileRelative];
    //重置frame
    [self layoutSubFrame];
    
    [self.view bringSubviewToFront:self.designIcon];
}
//添加标签
-(void)fileLabels
{
    for(int i=0;i<[respon.labelArray count];i++)
    {
        LabelDTO *dto = [respon.labelArray objectAtIndex:i];
        CGFloat orignX = (dto.locX/100)*self.packageImageV.width;
        CGFloat orignY = (dto.locY/100)*self.packageImageV.height - 50.0f;
        
        CGSize size = [CommonUtil getLabelSizeWithString:dto.productName andLabelHeight:20.0f andFont:FontType(12.0f)];
        LabelView *la;
        if ([dto.direction floatValue]==1) {
            la = [[LabelView alloc]initWithFrame:CGRectMake(orignX, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];
        }
        else
        {
            la = [[LabelView alloc]initWithFrame:CGRectMake(orignX - size.width - 15.0f, orignY, size.width +15.0f, 50.0f) andDirect:dto.direction];
            
        }
        
        la.tag = [dto.productNo intValue];
        [la showText:dto.productName];
        [self.packageImageV addSubview:la];
    }
    
}
//简介
-(void)fileContent:(NSString *)str
{
    //描述文字
    [self.displayView.textL setText:str];

    CGSize optimumSize = [self.displayView.textL optimumSize];
    
    CGRect frame = [self.displayView.textL frame];
    frame.size.height = (int)optimumSize.height+10; // +10 to fix height issue, this should be automatically fixed in iOS5
    [self.displayView.textL setFrame:frame];
    [self.displayView setFrame:CGRectMake(self.displayView.left, self.addressView.bottom, self.displayView.width, self.displayView.height)];
//    [self.displayView setFrame:CGRectMake(self.displayView.left, self.displayView.top, self.displayView.width, frame.size.height+30.f)];
    [self.view layoutSubviews];
}
//填充评论相关内容
-(void)fileCommentView
{
   
    if (IsArrEmpty(respon.commentList)) {
        self.commentView.frame = CGRectMake(self.commentView.left, self.displayView.bottom+space, self.commentView.width, self.postComView.bottom);
    }else{
        [comLabels removeAllObjects];
        for (UIView *view in self.commentView.subviews) {
            if ([view isKindOfClass:[CommentLabel class]]) {
                [view removeFromSuperview];
            }
        }
        for (int i=0; i<respon.commentList.count; i++) {
            
            CommentItem *item = [respon.commentList objectAtIndex:i];
            CGFloat orignY;
            if ([comLabels count]==0) {
                orignY  = 0.f;
            }else
            {
                orignY = ((CommentLabel *)[comLabels lastObject]).bottom;
            }
            CommentLabel *label = [[CommentLabel alloc]initWithFrame:CGRectMake(0.0f, orignY, self.commentView.width, 30.0f)];
            [label resetFrame:item isHomepage:NO];
            [comLabels addObject:label];
            [label.textButton addTarget:self action:@selector(goAllComment) forControlEvents:UIControlEventTouchUpInside];
            [self.commentView addSubview:label];
            if (i==respon.commentList.count-1) {
                //重置提交框的起始位置
                self.postComView.frame = CGRectMake(self.postComView.left, label.bottom, self.postComView.width, self.postComView.height);
                //重置整个评论框架的大小
                self.commentView.frame = CGRectMake(self.commentView.left, self.displayView.bottom+space, self.commentView.width, self.postComView.bottom);
            }
        }
    }
}
-(void)goAllComment
{
    CommentListViewController *list = [[CommentListViewController alloc]init];
    list.collocateNo = self.regNo;
    [self.navigationController pushViewController:list animated:YES];
}
//填充单品详情内容
-(void)fileProductList:(int)count
{
   
    for(int i=0;i<[respon.labelArray count];i++)
    {
        LabelDTO *dic = [respon.labelArray objectAtIndex:i];
        UIButton *btn  = [UIButton buttonWithType:UIButtonTypeCustom];
        if(count==2)
        {
            btn.frame = CGRectMake(space+(space+rectW1)*i, space, rectW1, rectW1);
        }
        else if(count==3)
        {
            btn.frame = CGRectMake(space+(space+rectW2)*i, space, rectW2, rectW2);
        }
        else
        {
            if(i<2)
                btn.frame = CGRectMake(space+(space+rectW1)*i, space, rectW1, rectW1);
            else
                btn.frame = CGRectMake(space+(space+rectW2)*(i-2), space*2+rectW1, rectW2, rectW2);
        }
        btn.tag = [dic.productNo intValue];
        [btn setimageUrl:dic.coverUrl placeholderImage:nil];
        [btn addTarget:self action:@selector(productClick:) forControlEvents:UIControlEventTouchUpInside];
        [self.productListV addSubview:btn];
    }
}
//猜你喜欢
-(void)fileRelative
{
    if([respon.packageList count]>0)
    {
        for (int i =0; i<[respon.packageList count]; i++) {
            CGFloat imgW = 90.0f;
            NSDictionary *relateDic = [respon.packageList objectAtIndex:i];
            UIButton *imgBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            imgBtn.frame = CGRectMake(space+(space+imgW)*i, space, imgW, imgW);
            [imgBtn setBackgroundImage:[UIImage imageNamed:@"default_square"] forState:UIControlStateNormal];
            [imgBtn setimageUrl:[relateDic objectForKey:@"coverUrl"] placeholderImage:nil];
            [imgBtn setTitle:[relateDic objectForKey:@"coverUrl"] forState:UIControlStateNormal];
            [imgBtn setTitleColor:[UIColor clearColor] forState:UIControlStateNormal];
            imgBtn.tag = [[relateDic objectForKey:@"collocatePicNo"] intValue];
            [imgBtn addTarget:self action:@selector(relativedClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.relativedScroll addSubview:imgBtn];
            self.relativedScroll.contentSize = CGSizeMake((space+imgW)*[respon.packageList count]+space*2, self.relativedScroll.height);
        }
    }
    else
    {
        self.relativedView.frame = CGRectMake(self.relativedView.left, self.productListV.bottom, self.relativedView.width, 0.0f);
    }
}
#define ZoomImageScl
-(void)ZoomImage
{
    ZoomImageViewController *zoom = [[ZoomImageViewController alloc]init];
    zoom.tag = 0;
    NSDictionary *dic = [NSDictionary dictionaryWithObject:respon.imgUrl forKey:@"imgUrl"];
    zoom.imageDataArray = [NSArray arrayWithObject:dic];
    [self presentViewController:zoom animated:YES completion:^{
        
    }];
}
#pragma mark --scrollViewDelegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(scrollView==self.backScroll)
    {
        CGFloat orignY = scrollView.contentOffset.y;
        if(orignY>0)
           [self.view bringSubviewToFront:self.backScroll];
        else
            [self.view bringSubviewToFront:self.packageImageV];
        /*
         搭配师头像、导航栏、确认购买保持在最前边儿
         */
        [self.view bringSubviewToFront:self.designIcon];
        [self.view bringSubviewToFront:self.placeOrderBtn];
        [self.view bringSubviewToFront:self.navView];
        CGFloat backY =  2*orignY/3;
        
        if(!isShowKeyboard)
        {
        CGFloat iconY = nav_height+PICTURE_HEIGHT - 25.0f - orignY;
        if(iconY<nav_height)
            iconY = nav_height;
        self.designIcon.frame = CGRectMake(self.designIcon.left, iconY, self.designIcon.width, self.designIcon.height);
        }
        
        self.packageImageV.frame = CGRectMake(self.packageImageV.left, backY, self.packageImageV.width, self.packageImageV.height);

    }
}
#pragma mark --buttonPress 
#pragma mark --toastView
-(void)Method:(NSInteger)tag
{
    //分享到微信好友
    if (tag==ShareToWechatSession) {
        [self shareToUM:UMShareToWechatSession];
    }
    //分享到朋友圈
    else if(tag==ShareToWechatTimeline)
    {
        [self shareToUM:UMShareToWechatTimeline];
    }
        else
    {
        [self hiddenToastView];
    }
    //分享到腾讯微博
    if(tag==ShareToWechatTencent)
    {
        [self shareToUMT:UMShareToTencent];
    }
    if (tag == ShareToWechatSina)
    {
        [self shareToUMS:UMShareToSina];
    }
}
//调用分享到朋友圈、微信好友
-(void)shareToUM:(NSString *)shareMehtod
{
    
    [[UMSocialControllerService defaultControllerService] setShareText:nil shareImage:shareImage socialUIDelegate:self];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:shareMehtod].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
    
}
-(void)shareToUMT:(NSString *)shareMehtod
{
    //腾讯
    shareImgV = [[UIImageView alloc]init];
    shareImgV.image = [UIImage imageNamed:@"tencent twitter.jpg"];
    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[shareMehtod] content:@"腾讯微博" image:shareImgV.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}
-(void)shareToUMS:(NSString *)shareMehtod
{
    //新浪
    shareImgV = [[UIImageView alloc]init];
    shareImgV.image = [UIImage imageNamed:@"sina twitter.jpg"];

    [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:@"新浪微博" image:shareImgV.image location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *shareResponse){
        if (shareResponse.responseCode == UMSResponseCodeSuccess) {
            NSLog(@"分享成功！");
        }
    }];
}

#pragma mark --UM_Delegate
-(void)didSelectSocialPlatform:(NSString *)platformName withSocialData:(UMSocialData *)socialData
{
    //微信分享纯图片，不需要文字信息
    [UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
}
-(void)didFinishGetUMSocialDataInViewController:(UMSocialResponseEntity *)response
{
    //如果分享成功，回调方法
    if (response.responseCode == UMSResponseCodeSuccess) {
        //
        [self hiddenToastView];
    }
}
//弹出分享界面
-(void)addToastView
{
    UIWindow*  Hywindow = [[[UIApplication sharedApplication] delegate] window];
    [Hywindow addSubview:self.backView];
    [self.backView addSubview:self.toast];
    [self.backView setHidden:YES];
}
-(void)showToastView
{
    [self.backView setHidden:NO];
}
-(void)hiddenToastView
{
    [self.backView setHidden:YES];
}
//分享按钮
-(void)sharePress:(UIButton *)sender
{
    [self showToastView];
    
}
//头像按钮
-(void)designerPress:(UIButton *)sender
{
    DesignerDetailViewController *design = [[DesignerDetailViewController alloc]init];
    design.userId = respon.memerNo;
    [self.navigationController pushViewController:design animated:YES];
}
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
-(void)login
{
    LoginViewController *login = [[LoginViewController alloc]init];
    [self.navigationController pushViewController:login animated:YES];
}

//取消收藏
-(void)cancelFav
{
    DeleteFavReq *favReq = [[DeleteFavReq alloc]init];
    JuPlusResponse *favRespon =[[JuPlusResponse alloc]init];
    [favReq setField:[CommonUtil getToken] forKey:TOKEN];
    [favReq setField:self.regNo forKey:@"objNo"];
    [favReq setField:@"2" forKey:@"objType"];
    
    [HttpCommunication request:favReq getResponse:favRespon Success:^(JuPlusResponse *response) {
        [self.favBtn startAnimation];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    
}
//添加收藏
-(void)postFav
{
    PostFaverReq *favReq = [[PostFaverReq alloc]init];
    [favReq setField:[CommonUtil getToken] forKey:TOKEN];
    [favReq setField:self.regNo forKey:@"objNo"];
    [favReq setField:@"2" forKey:@"objType"];
    
    JuPlusResponse *favRespon =[[JuPlusResponse alloc]init];
    [HttpCommunication request:favReq getResponse:favRespon Success:^(JuPlusResponse *response) {
        [self.favBtn startAnimation];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}

//猜你喜欢相关点击事件
-(void)relativedClick:(UIButton *)sender
{
    //先给本界面加白色底层
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
    backV.backgroundColor = Color_White;
    [self.view addSubview:backV];
    //在白色底层上添加转场动画
    UIImageView *imageView = [[UIImageView alloc] initWithImage:sender.currentBackgroundImage];
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    CGRect frameInSuperview = [sender convertRect:sender.frame toView:self.view];
    frameInSuperview.origin.x = sender.origin.x - self.relativedScroll.contentOffset.x;
    frameInSuperview.origin.y -=10.0f;
    
    //从在父类中的frame可以反推到self.view的frame，两种方法任选其一
//    CGRect frameInSuperview = [self.view convertRect:sender.frame fromView:self.relativedView];

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
-(void)layoutSubFrame
{
    self.productListV.frame = CGRectMake(self.productListV.left, self.commentView.bottom+space, self.productListV.width, self.productListV.height);
    self.relativedView.frame = CGRectMake(self.relativedView.left, self.productListV.bottom, self.relativedView.width, self.relativedView.height);
    self.secBackScroll.frame = CGRectMake(self.secBackScroll.left, self.secBackScroll.top, self.secBackScroll.width,self.relativedView.bottom);
    self.backScroll.contentSize = CGSizeMake(self.backScroll.width, self.relativedView.bottom+PICTURE_HEIGHT+TABBAR_HEIGHT);
    [self.view bringSubviewToFront:self.packageImageV];
    
}
//单品详情点击事件
-(void)productClick:(UIButton *)sender
{

    CGPoint point2 = [sender convertPoint:sender.center toView:nil];
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.width, self.view.height)];
    backV.alpha = 0.99;
    backV.backgroundColor = RGBACOLOR(255, 255, 255, 0.6);
    [self.view addSubview:backV];
    [UIView animateWithDuration:1.0f animations:^{
        backV.alpha = 1;
    } completion:^(BOOL finished) {
        [backV removeFromSuperview];
    }];
    
    CGPoint startPoint = CGPointMake(sender.center.x-25.0f,point2.y-25.0f);
    SingleDetialViewController *sing = [[SingleDetialViewController alloc]init];
    sing.regNo = self.regNo;
    sing.isfromPackage = YES;
    sing.singleId =  [NSString stringWithFormat:@"%ld",(long)sender.tag];
    sing.point = startPoint;
    [self.navigationController radialPushViewController:sing withDuration:1.0f withStartFrame:CGRectMake(startPoint.x,startPoint.y,50.0f,50.0f) comlititionBlock:^{
        
    }];
    

   }
//购买
-(void)payPress
{
    if([CommonUtil isLogin])
    {
        if([respon.status intValue]!=3)
        {
            [self showAlertView:@"该套餐中含有未审核的单品" withTag:0];
        }
        else
        {
        PlaceOrderViewController *order = [[PlaceOrderViewController alloc]init];
        NSMutableArray *regArr = [[NSMutableArray alloc]init];
        for (int i=0; i<[respon.labelArray count]; i++) {
            productOrderDTO *singleDTO = [[productOrderDTO alloc]init];
            LabelDTO *dto = [respon.labelArray objectAtIndex:i];
            singleDTO.productNo = dto.productNo;
            singleDTO.regNo = self.regNo;
            singleDTO.imgUrl = dto.coverUrl;
            
            singleDTO.price = dto.price;
            singleDTO.productName = dto.productName;
            singleDTO.countNum = @"1";
            [regArr addObject:singleDTO];
        }
        order.regArray = regArr;
        [self.navigationController pushViewController:order animated:YES];
        }
    }
    else
    {
        [self login];
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:ANIMATION animations:^{
        self.secBackScroll.alpha = 1;
        self.designIcon.alpha = 1;
    }];
}
-(void)viewWillDisppear:(BOOL)animated
{
    [super viewWillDisappear:animated];
//    [UIView animateWithDuration:0.3 animations:^{
//        self.secBackScroll.alpha = 0;
//        self.designIcon.alpha = 0;
//
//    }];
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
