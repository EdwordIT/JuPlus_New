//
//  UploadNotesViewController.m
//  JuPlus
//
//  Created by admin on 15/8/5.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UploadNotesViewController.h"
#import "UMSocial.h"
#import "PostProductReq.h"
#import "PostProductRespon.h"
@interface UploadNotesViewController ()<UITextFieldDelegate,UMSocialUIDelegate>

@property (nonatomic,strong)UIScrollView *backSCroll;
//输入内容
@property (nonatomic,strong)UILabel *detailView;

@property (nonatomic,strong)UITextField *urlTextView;

@property (nonatomic,strong)UILabel *remindL;

@property (nonatomic,strong)UIButton *sureBtn;

@end

@implementation UploadNotesViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"发布作品";
    
    [self.view addSubview:self.backSCroll];

    UILabel *tagL =[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 200.0f, 30.0f)];
    [tagL setFont:FontType(FontSize)];
    tagL.text = @"标签名称";
    [self.backSCroll addSubview:tagL];
    
    [self.backSCroll addSubview:self.detailView];
    
    UILabel *urlL =[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 70.0f, 200.0f, 30.0f)];
    [urlL setFont:FontType(FontSize)];
    urlL.text = @"请输入相关购买地址或者链接";
    [self.backSCroll addSubview:urlL];

    [self.backSCroll addSubview:self.urlTextView];
    [self.backSCroll addSubview:self.remindL];
    self.backSCroll.contentSize = CGSizeMake(self.backSCroll.width, self.remindL.bottom+TABBAR_HEIGHT);
    [self.view addSubview:self.sureBtn];
    
    // Do any additional setup after loading the view from its nib.
}

#pragma mark --uifig
-(UIScrollView *)backSCroll
{
    if(!_backSCroll)
    {
        _backSCroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
    }
    return _backSCroll;
}
-(UILabel *)detailView
{
    if(!_detailView)
    {
        _detailView=[[UILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, SCREEN_WIDTH - 10.0f*2 ,30.0f)];
        _detailView.text = self.infoDTO.productName;
        _detailView.backgroundColor=[UIColor whiteColor];
        _detailView.layer.borderColor= [Color_Gray_lines CGColor];
        _detailView.layer.borderWidth=1;
        _detailView.layer.cornerRadius=1.0;
        _detailView.layer.masksToBounds=YES;
        _detailView.font=FontType(FontSize);
    }
        
    return _detailView;
}
-(UIButton *)sureBtn
{
    if(!_sureBtn)
    {
        _sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _sureBtn.frame=CGRectMake(0, SCREEN_HEIGHT - TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT);
        [_sureBtn setBackgroundColor:Color_Basic];
        _sureBtn.alpha = ALPHLA_BUTTON;
        [_sureBtn setTitle:@"完成" forState:UIControlStateNormal];
        _sureBtn.titleLabel.font=FontType(FontMaxSize);
        [_sureBtn setTitleColor:Color_White forState:UIControlStateNormal];
        [_sureBtn addTarget:self action:@selector(sureBtnPress:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _sureBtn;
}
-(UITextField *)urlTextView
{
    if(!_urlTextView)
    {
        _urlTextView = [[UITextField alloc]initWithFrame:CGRectMake(10.0f, 100.0f, self.backSCroll.width - 20.0f, 40.0f)];
        _urlTextView.layer.borderColor= [Color_Gray_lines CGColor];
        _urlTextView.returnKeyType=UIReturnKeyDone;
        _urlTextView.layer.borderWidth=1;
        _urlTextView.layer.cornerRadius=1.0;
        _urlTextView.layer.masksToBounds=YES;
        _urlTextView.delegate = self;
        [_urlTextView setFont:FontType(FontSize)];
        _urlTextView.placeholder = @"例：https://www.jujiax.com";

    }
    return _urlTextView;
}
-(UILabel *)remindL
{
    if(!_remindL)
    {
        _remindL = [[UILabel alloc]initWithFrame:CGRectMake(10.0f, self.urlTextView.bottom+10.0f, self.backSCroll.width - 20.0f, 30.0f)];
        _remindL.numberOfLines = 0;
        _remindL.textColor = Color_Gray;
        [_remindL setFont:FontType(FontSize)];
        [_remindL setText:@"*我们的工作人员将在2个工作日内联系你"];
        [_remindL sizeToFit];
    }
    return _remindL;
}
#pragma mark --Click

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)sureBtnPress:(UIButton *)sender
{
    if(IsStrEmpty(self.detailView.text)||IsStrEmpty(self.urlTextView.text))
    {
        [self showAlertView:@"请补充完整信息" withTag:0];
        return;
    }
    else
    {
        [self postProduct];
    }
}
-(void)postProduct
{
    PostProductReq *req = [[PostProductReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:self.urlTextView.text forKey:@"supplierUrl"];
    [req setField:self.detailView.text forKey:@"name"];
    
    PostProductRespon *respon = [[PostProductRespon alloc]init];
    
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        
        self.infoDTO.productName = respon.regName;
        self.infoDTO.productNo = respon.regNo;
        //因为上传的时候标签是不带图片的，所以用coverUrl存储购买地址或者链接
        //self.infoDTO.coverUrl = self.urlTextView.text;
        [CommonUtil postNotification:AddLabels Object:self.infoDTO];
        [self.navigationController popViewControllerAnimated:YES];
        
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
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
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
