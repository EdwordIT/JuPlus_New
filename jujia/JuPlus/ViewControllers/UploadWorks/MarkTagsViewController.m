//
//  MarkTagsViewController.m
//  JuPlus
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MarkTagsViewController.h"
#import "SearchTagsTab.h"
#import "LabelDTO.h"
#import "MarkLabeiView.h"
#import "UploadNotesViewController.h"
#import "InfoChangeV.h"
#import "CollocationClassifyView.h"
#import "UMSocial.h"
#import "UIScrollView+UITouch.h"
#import "AddCollocationReq.h"
#import "MyWorksListViewController.h"
#import "ToastView.h"

@interface MarkTagsViewController ()<UITextViewDelegate,CollocationClassifyViewDelegate,UITextFieldDelegate,UMSocialUIDelegate,ToastViewDelegate>
{
    UIView *selectedView;
    
    CGPoint currentPoint;
    
    UIImageView *remindBtn;
    //得到需要分享的图片
    UIImage *shareImage;
    
    NSArray *randomArray;
}
@property (nonatomic,strong)UIImageView *topImgView;

@property (nonatomic,strong)JuPlusUIView *bottomView;
//标签筛选
@property (nonatomic,strong)SearchTagsTab *searchTab;
//添加的标签数组内容
@property (nonatomic,strong)NSMutableArray *tagsArray;
//添加单品标签相关内容
@property (nonatomic,strong)UIScrollView *backSCroll;
//输入内容
@property (nonatomic,strong)UITextView *detailView;
//字数限制
@property (nonatomic,strong)UILabel *countLabel;

@property (nonatomic,strong)UILabel *placeholderLabel;

@property (nonatomic,strong)InfoChangeV *clfyPickView;

@property (nonatomic,strong)UILabel *remindL;

@property (nonatomic,strong)UIButton *sureBtn;

@property (nonatomic,strong)CollocationClassifyView *classify;

@property (nonatomic,strong)ToastView *toast;

@property (nonatomic,strong)UIView *backView;
@end

@implementation MarkTagsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"添加标签";

    randomArray = [NSArray arrayWithObjects:@"世界上总有一半人不理解另一半人的快乐。",@"上帝会把我们身边最好的东西拿走，以提醒我们得到太多！",@"有信心不一定会成功，没信心一定不会成功。",@"有人就有恩怨，有恩怨就有江湖。人就是江湖，怎么退出？",@"最了解你的人不是你的朋友，而是你的敌人。",@"爱情这东西时间很关键，认识得太早或太晚，都不行。",@"生命中充满了巧合，两条平行线也会有相交的一天。",@"我手上的爱情线、生命线和事业线，都是你的名字拼成的。",@"我情愿做个犯错的人，也不愿错过你？",@"只要两个相爱的人在一起，哪里都是天堂。",@"对爱的人说心里话，不要等太久。",@"为了记住你的笑容，我拼命按下心中的快门。", nil];
    for (NSString *str in randomArray) {
        NSLog(@"%lu",(unsigned long)str.length);
    }
    self.tagsArray = [[NSMutableArray alloc]init];

    [self.view addSubview:self.backSCroll];
    
    [self.view addSubview:self.topImgView];
    
    remindBtn = [[UIImageView alloc]initWithFrame:_topImgView.frame];
    remindBtn.userInteractionEnabled = YES;
    [remindBtn setImage:[UIImage imageNamed:@"remind_Tag"]];
    //[remindBtn setHidden:YES];
    [self.view addSubview:remindBtn];

    
    [self.backSCroll addSubview:self.bottomView];
    
    
    [self.topImgView setImage:self.postImage];
    //选择标签栏
    [self.view addSubview:self.searchTab];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fileLabels:) name:AddLabels object:nil];
#pragma mark --添加套餐介绍等信息
    
    [self.backSCroll addSubview:self.detailView];
    [self.backSCroll addSubview:self.placeholderLabel];
    [self.backSCroll addSubview:self.countLabel];
    [self.backSCroll addSubview:self.clfyPickView];
    [self.backSCroll addSubview:self.remindL];
    self.backSCroll.contentSize = CGSizeMake(self.backSCroll.width, self.remindL.bottom+TABBAR_HEIGHT+10.0f);
    [self.view addSubview:self.sureBtn];
    [self.view addSubview:self.classify];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];

    [self addToastView];
    // Do any additional setup after loading the view.
}
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
        [self gotoWorksList];
    }
    
}
//调用分享到朋友圈、微信好友
-(void)shareToUM:(NSString *)shareMehtod
{
    
    [[UMSocialControllerService defaultControllerService] setShareText:nil shareImage:shareImage socialUIDelegate:self];        //设置分享内容和回调对象
    [UMSocialSnsPlatformManager getSocialPlatformWithName:shareMehtod].snsClickHandler(self,[UMSocialControllerService defaultControllerService],YES);
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
-(void)sharePress:(UIButton *)sender
{
    [self showToastView];
    
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
        [self gotoWorksList];
    }
}
#pragma mark --uifig
-(UIScrollView *)backSCroll
{
    if(!_backSCroll)
    {
        _backSCroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
        _backSCroll.delegate = self;
    }
    return _backSCroll;
}
-(UITextView *)detailView
{
    if(!_detailView)
    {
        _detailView=[[UITextView alloc]initWithFrame:CGRectMake(10.0f, self.bottomView.bottom,SCREEN_WIDTH - 10.0f*2,50.0f)];
        _detailView.delegate=self;
        _detailView.backgroundColor=[UIColor whiteColor];
        [_detailView setEditable:YES];
        _detailView.layer.borderColor= [Color_Gray_lines CGColor];
        _detailView.returnKeyType=UIReturnKeyDone;
        _detailView.layer.borderWidth=1;
        _detailView.layer.cornerRadius=5.0;
        _detailView.layer.masksToBounds=YES;
        _detailView.textColor= Color_Gray;
        int a = arc4random()%[randomArray count];
        _detailView.text = [randomArray objectAtIndex:a];
        _detailView.font=FontType(FontSize);
    }
    
    return _detailView;
}
-(UILabel *)countLabel
{
    if(!_countLabel)
    {
        _countLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.detailView.right - 80.0f, 10.0f+self.detailView.bottom, 80.0f, 30.0f)];
        _countLabel.backgroundColor=[UIColor clearColor];
        _countLabel.font=FontType(FontSize);
        _countLabel.textAlignment=NSTextAlignmentRight;
        _countLabel.textColor=Color_Gray;
        _countLabel.text=[NSString stringWithFormat:@"%ld/26字",self.detailView.text.length];
        
    }
    return _countLabel;
}
-(UILabel *)placeholderLabel
{
    if(!_placeholderLabel)
    {
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(20.0f, self.detailView.top, 280.0f, 30.0f)];
        _placeholderLabel.backgroundColor=[UIColor clearColor];
        _placeholderLabel.numberOfLines = 0;
        _placeholderLabel.font=FontType(FontSize);
        _placeholderLabel.textAlignment=NSTextAlignmentLeft;
        _placeholderLabel.textColor=Color_Gray;
        _placeholderLabel.text=@"请添加内容";
        [_placeholderLabel setHidden:YES];
    }
    return _placeholderLabel;
}
-(InfoChangeV *)clfyPickView
{
    if(!_clfyPickView)
    {
        _clfyPickView = [[InfoChangeV alloc]initWithFrame:CGRectMake(0.0f, self.countLabel.bottom, self.backSCroll.width, 40.0f)];
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, _clfyPickView.width, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [_clfyPickView addSubview:line];
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0.0f, _clfyPickView.height - 1.0f, _clfyPickView.width, 1.0f)];
        [line1 setBackgroundColor:Color_Gray_lines];
        [_clfyPickView addSubview:line1];
        _clfyPickView.titleL.text = @"选择分类";
        [_clfyPickView.botomV removeFromSuperview];
        [_clfyPickView.clickBtn addTarget:self action:@selector(rightBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _clfyPickView;
}
-(ToastView *)toast
{
    if(!_toast)
    {
        CGFloat toastH = (SCREEN_WIDTH - 84.0f)+95.0f;
        _toast = [[ToastView alloc]initWithFrame:CGRectMake(40.0f, (SCREEN_HEIGHT - toastH)/2, SCREEN_WIDTH - 80.0f, toastH) title:@"发布成功"];
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
            UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes)];
            [_backView addGestureRecognizer:ges];

        }
    return _backView;
}
-(void)tapGes
{
    [self hiddenToastView];
    [self gotoWorksList];
}
-(UIButton *)sureBtn
{
    if(!_sureBtn)
    {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame=CGRectMake(0, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
        [_sureBtn setBackgroundColor:Color_Basic];
        _sureBtn.alpha = ALPHLA_BUTTON;
        [_sureBtn setTitle:@"发布" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font=FontType(FontMaxSize);
        [_sureBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _sureBtn;
}
-(CollocationClassifyView *)classify
{
    if(!_classify)
    {
        _classify = [[CollocationClassifyView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT) andSuperView:self.topImgView];
        _classify.delegate = self;
        [_classify setHidden:YES];
    }
    return _classify;
}
-(UILabel *)remindL
{
    if(!_remindL)
    {
        
        _remindL = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, self.clfyPickView.bottom+10.0f, self.backSCroll.width - 20.0f, 30.0f)];
        _remindL.numberOfLines = 0;
        [_remindL setFont:FontType(FontSize)];
        [_remindL setText:@"*我们的工作人员将在2个工作日内联系你"];
        [_remindL sizeToFit];
    }
    return _remindL;
}
#pragma mark --scrollView
-(void)setFront
{
    [self.view bringSubviewToFront:self.navView];
    [self.view bringSubviewToFront:self.sureBtn];
    [self.view bringSubviewToFront:self.searchTab];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self setFront];
    [self.view bringSubviewToFront:scrollView];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self setFront];
    CGFloat orignY = scrollView.contentOffset.y;
    self.topImgView.frame = CGRectMake(self.topImgView.left, nav_height -  orignY, self.topImgView.width, self.topImgView.height);
    remindBtn.frame = CGRectMake(remindBtn.left, nav_height -  orignY, remindBtn.width, remindBtn.height);

    
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.view bringSubviewToFront:self.topImgView];
    [self setFront];
}
#pragma mark --Click
//显示可选择的分类
-(void)rightBtnPress:(UIButton *)sender
{
    [self.view bringSubviewToFront:self.classify];
    [self.classify showClassify];
}
//代理回调，
-(void)reloadInfo:(ClassifyTagsDTO *)info
{
    [self.view sendSubviewToBack:self.classify];
    if (info) {
        [self.clfyPickView.textL setText:info.name];
        self.clfyPickView.tag = [info.tagId integerValue];
    }
    else
        [self.clfyPickView.textL setText:@""];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sureBtnPress:(UIButton *)sender
{
    
    if (IsArrEmpty(self.topImgView.subviews)) {
        [self showAlertView:@"请至少添加一种标签" withTag:0];
        [remindBtn setHidden:NO];
    }
   else if(IsStrEmpty(self.detailView.text)||self.clfyPickView.tag==0)
    {
        [self showAlertView:@"请补充完整信息" withTag:0];
        return;
    }
    else if(self.detailView.text.length>26)
    {
        [self showAlertView:@"您输入的描述信息过长" withTag:0];
    }
    else
    {
        shareImage = [self.postImage addText:self.detailView.text andNickname:[JuPlusUserInfoCenter sharedInstance].userInfo.nickname];
        [self.toast showShareView:shareImage];
        [self getTagsArray];
    }
}
//发送post表单，上送结果
-(void)postData
{
    self.sureBtn.userInteractionEnabled = NO;
    AddCollocationReq *req = [[AddCollocationReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.detailView.text forKey:@"explain"];
    [req setField:self.tagsArray forKey:@"productList"];
    [req setField:[self.postImage getPostImageString] forKey:@"picContent"];
    [req setField:[shareImage getPostImageString] forKey:@"sharePicContent"];

    [req setField:[NSString stringWithFormat:@"%ld",(long)self.clfyPickView.tag] forKey:@"tagIds"];
    JuPlusResponse *respon = [[JuPlusResponse alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        //
        [self showToastView];
        self.sureBtn.userInteractionEnabled = YES;
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        self.sureBtn.userInteractionEnabled = YES;
    } showProgressView:YES with:self.view];
}

//跳转到我的列表页面
-(void)gotoWorksList
{
    MyWorksListViewController *list = [[MyWorksListViewController alloc]init];
    [self.navigationController pushViewController:list animated:YES];
}
//退出键盘
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@"\n"])
    {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}

-(void)textViewDidChange:(UITextView *)textView
{
    if(textView.text.length>0)
    {
        [self.placeholderLabel setHidden:YES];
    }
    else
        [self.placeholderLabel setHidden:NO];
    self.countLabel.text = [NSString stringWithFormat:@"%lu/26字",(unsigned long)textView.text.length];
    
}

#pragma mark --keyboard
-(void)keyboardWillShow:(NSNotification *)noti
{
  
        CGRect frame = self.backSCroll.frame;
        frame.origin.y = - 140.0f;
    [self.backSCroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
        [UIView animateWithDuration:ANIMATION animations:^{
            self.backSCroll.frame = frame;
            self.topImgView.frame = CGRectMake(0.0f,  - 140.0f, self.topImgView.width, self.topImgView.height);
            remindBtn.frame = CGRectMake(0.0f,  - 140.0f , remindBtn.width, remindBtn.height);
        }];

    //    NSDictionary *info = [noti userInfo];
    //    CGFloat height = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
}
-(void)keyboardWillHidden:(NSNotification *)noti
{
    [self.backSCroll setContentOffset:CGPointMake(0.0f, 0.0f) animated:NO];
       [UIView animateWithDuration:ANIMATION animations:^{
        CGRect frame = self.backSCroll.frame;
        frame.origin.y = nav_height;
        self.backSCroll.frame = frame;

        self.topImgView.frame = CGRectMake(0.0f,nav_height, self.topImgView.width, self.topImgView.height);
        remindBtn.frame = CGRectMake(0.0f, nav_height , remindBtn.width, remindBtn.height);
    }];
 }

#pragma mark --labels相关
//添加标签
-(void)fileLabels:(NSNotification *)noti
{
    LabelDTO *dto = [noti object];
    CGFloat orignX = dto.locX;
    CGFloat orignY = dto.locY;
    CGSize size = [CommonUtil getLabelSizeWithString:dto.productName andLabelHeight:20.0f andFont:FontType(FontMaxSize)];
    orignY = MAX(dto.locY, 50.0f);
    
    MarkLabeiView *la;
    if(orignX<SCREEN_WIDTH - size.width -15.0f)
    {
        dto.direction = @"1";
        la = [[MarkLabeiView alloc]initWithFrame:CGRectMake(orignX, orignY-50.0f, size.width +15.0f, 50.0f) andDirect:dto.direction] ;

    }
        else
        {
        dto.direction = @"2";
        la = [[MarkLabeiView alloc]initWithFrame:CGRectMake(orignX - size.width - 15.0f, orignY-50.0f, size.width +15.0f, 50.0f) andDirect:dto.direction];

        }
    la.infoDTO = dto;
    UITapGestureRecognizer *gesTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(gesTap:)];
    [la addGestureRecognizer:gesTap];
    
    UILongPressGestureRecognizer *tap = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(longTap:)];
    [la addGestureRecognizer:tap];
    
    [la showText:dto.productName];
    
    [self.topImgView addSubview:la];
    
}
#pragma mark UItapGesture--

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    if (touch.view ==self.topImgView||touch.view==remindBtn) {
        //判断标签是否超过3个
        if ([self.topImgView.subviews count]>=3) {
            [self showAlertView:@"标签添加不超过3个" withTag:0];
        }
        else
        {
       
        CGPoint currTouchPoint = [touch locationInView:touch.view];
        LabelDTO *dto = [[LabelDTO alloc]init];
        dto.locX = currTouchPoint.x;
        dto.locY = currTouchPoint.y;
        self.searchTab.infoDTO = dto;
        [UIView animateWithDuration:ANIMATION animations:^{
            if (touch.view==remindBtn) {
                [remindBtn setHidden:YES];
            }
            [self.searchTab.searchBar setShowsCancelButton:YES animated:YES];
            [self.searchTab.searchBar becomeFirstResponder];
            self.searchTab.frame = CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, SCREEN_HEIGHT);
        }];
        }
    }
}
//标签点击触发此事件(改变标签朝向)
-(void)gesTap:(UITapGestureRecognizer *)tap
{
    MarkLabeiView *tapView = (MarkLabeiView *)tap.view;
    CGRect frame = tapView.frame;
    if (tapView.isLeft) {
        //判断切换朝向之后，是否会触碰到边界
        if (frame.origin.x>=tapView.width) {
            [tapView setDirectionWithDire];
        }
    }else{
        if (tapView.right+tapView.width<=SCREEN_WIDTH) {
            [tapView setDirectionWithDire];
        }
    }
    
}
//长按有两个状态，开始触发和结束触发，都会调用此方法
-(void)longTap:(UILongPressGestureRecognizer *)tap
{
    //长按开始触发
    if(tap.state == UIGestureRecognizerStateBegan)
    {
    selectedView = tap.view;
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:@"您确定要删除当前标签吗" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    alert.tag = 101;
    [alert show];
    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==101) {
        if(buttonIndex==1)
        {
            [selectedView removeFromSuperview];
        }
            [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }

}
#pragma mark --uifig
-(UIImageView *)topImgView
{
    if(!_topImgView)
    {
        _topImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, nav_height, PICTURE_HEIGHT, PICTURE_HEIGHT)];
        _topImgView.userInteractionEnabled = YES;
    }
    return _topImgView;
}

-(JuPlusUIView *)bottomView
{
    if(!_bottomView)
    {
        _bottomView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, PICTURE_HEIGHT, SCREEN_WIDTH, 10.0f)];
        _bottomView.backgroundColor = [UIColor whiteColor];
    }
    return _bottomView;
}
-(SearchTagsTab *)searchTab
{
    if(!_searchTab)
    {
        _searchTab = [[SearchTagsTab alloc]initWithFrame:CGRectMake(0.0f, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT)];
    }
    return _searchTab;
}

#pragma fileData
//得到上传标签的所有信息
-(void)getTagsArray
{
    [self.tagsArray removeAllObjects];
    for(UIView *view in self.topImgView.subviews)
    {
        if ([view isKindOfClass:[MarkLabeiView class]]) {
            MarkLabeiView *mark = (MarkLabeiView *)view;
            NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
            [dic setObject:[NSString stringWithFormat:@"%.2f",(mark.infoDTO.locX/SCREEN_WIDTH)*100] forKey:@"positionX"];
            [dic setObject:[NSString stringWithFormat:@"%.2f",(mark.infoDTO.locY/SCREEN_WIDTH)*100] forKey:@"positionY"];
            [dic setObject:mark.infoDTO.productNo forKey:@"productNo"];
            [dic setObject:mark.infoDTO.direction forKey:@"direction"];
            [self.tagsArray addObject:dic];
        }
    }
    [self postData];
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
