//
//  LoginViewController.m
//  JuPlus
//
//  Created by admin on 15/6/23.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "LoginViewController.h"
#import "JuPlusTextField.h"
#import "RegisterViewController.h"
#import "LoginReq.h"
#import "LoginRespon.h"
#import "HomeFurnishingViewController.h"
#import "JuPlusUserInfoCenter.h"
#import "ForgetPwdViewController.h"
#import "APService.h"
@interface LoginViewController ()<UITextFieldDelegate>
{
    LoginReq *req;
    LoginRespon *respon;
    
    UIScrollView *backView;
}
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titleLabel.text=@"登录";
  }
#pragma mark ---加载UI
-(NSMutableArray *)fieldArray
{
    if(!_fieldArray)
    {
        _fieldArray = [[NSMutableArray alloc]init];
    }
    return _fieldArray;
}
-(UIImageView *)iconImg
{
    if(!_iconImg)
    {
        CGFloat iconW = 66.0f;
        CGFloat iconH = 54.0f;
        _iconImg = [[UIImageView alloc]initWithFrame:CGRectMake((self.view.width - iconW)/2, 80.0f, iconW, iconH)];
        [_iconImg setImage:[UIImage imageNamed:@"logo"]];
    }
    return _iconImg;
}
-(void)loadBaseUI
{
    [self.leftBtn setHidden:NO];
    backView=[[UIScrollView alloc]initWithFrame:CGRectMake(0, nav_height,SCREEN_WIDTH, view_height )];
    backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:backView];
    
    [backView addSubview:self.iconImg];
    
    NSArray *array1=[NSArray arrayWithObjects:@"手机",@"密码", nil];
    NSArray *array2=[NSArray arrayWithObjects:@"请输入手机",@"请输入密码",nil];
    self.fieldArray=[[NSMutableArray alloc]initWithCapacity:array1.count];
    for (int i=0; i<array1.count; i++) {
        JuPlusTextField *rlView=[[JuPlusTextField alloc]initWithFrame:CGRectMake(30.0f,160.0f+ i*50.0f, SCREEN_WIDTH-60.0f, 50.0f)];
        rlView.contentField.tag=i;
        rlView.headTitleLa.text=[array1 objectAtIndex:i];
        rlView.contentField.placeholder=[array2 objectAtIndex:i];
        rlView.contentField.delegate=self;
        [backView addSubview:rlView];
        [self.fieldArray addObject:rlView.contentField];
        
        if (i==1) {
            
            rlView.contentField.secureTextEntry=YES;
            
        }
        else{
            //账号
            if ([CommonUtil getUserDefaultsValueWithKey:@"loginName"]!=nil) {
                rlView.contentField.text=[CommonUtil getUserDefaultsValueWithKey:@"loginName"];
            }
            rlView.contentField.keyboardType=UIKeyboardTypePhonePad;
        }
        
    }
    
    
    [self.rightBtn setHidden:NO];
    [self.rightBtn setTitle:@"注册" forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(regPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.forgetBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.forgetBtn.frame=CGRectMake(SCREEN_WIDTH - 100.0f, 270, 80, 30);
    [self.forgetBtn setTitle:@"忘记密码？" forState:UIControlStateNormal];
    [self.forgetBtn.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:14.0]];
    [self.forgetBtn setTitleColor:Color_Gray forState:UIControlStateNormal];
    [backView addSubview:self.forgetBtn];
    [self.forgetBtn addTarget:self action:@selector(passWordPress:) forControlEvents:UIControlEventTouchUpInside];
    
    self.loginBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame=CGRectMake(30, 310, SCREEN_WIDTH-60, TABBAR_HEIGHT);
    [self.loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    self.loginBtn.tag=11;
    [self.loginBtn setBackgroundColor:Color_Pink];
    self.leftBtn.alpha = ALPHLA_BUTTON;
    [self.loginBtn.titleLabel setFont:FontType(FontMaxSize)];
    [self.loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backView addSubview:self.loginBtn];
    [self.loginBtn addTarget:self action:@selector(comPress:) forControlEvents:UIControlEventTouchUpInside];
    backView.contentSize = CGSizeMake(SCREEN_WIDTH, view_height+100.0f);
}

//忘记密码
-(void)passWordPress:(UIButton *)sender
{
    ForgetPwdViewController *forget = [[ForgetPwdViewController alloc]init];
    [self.navigationController pushViewController:forget animated:YES];
}
//登录
-(void)comPress:(UIButton *)sender
{
    int count=2;
    for(UITextField *obj in self.fieldArray)
    {
        if (IsStrEmpty(obj.text)) {
            count--;
        }
    }
    if (count==2){
        //提交登陆信息
        [self loginPost];
    }
    else{
        UIAlertView *alt=[[UIAlertView alloc]initWithTitle:@"温馨提示" message:@"请输入手机号和密码" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles: nil];
        [alt show];
    }
    
}
//注册
-(void)regPress:(UIButton *)sender
{
    RegisterViewController *reg = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:reg animated:YES];
}
-(void)loginPost
{
    req = [[LoginReq alloc]init];
    respon = [[LoginRespon alloc]init];
    
    for(UITextField *obj in self.fieldArray)
    {
        if (obj.tag==0) {
            [req setField:obj.text forKey:@"mobile"];
        }
        else{
            [req setField:obj.text forKey:@"loginPwd"];
        }
        [obj resignFirstResponder];
    }
    
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self fileLoginInfo];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
-(void)fileLoginInfo
{
    //登陆成功之后
    for(UITextField *obj in self.fieldArray)
    {
        if (obj.tag==0) {
            [JuPlusUserInfoCenter sharedInstance].userInfo.mobile = obj.text;
        }
    }
//    [JuPlusUserInfoCenter sharedInstance].userInfo.token = respon.token;
//    [JuPlusUserInfoCenter sharedInstance].userInfo.nickname = respon.nickname;[JuPlusUserInfoCenter sharedInstance].userInfo.portraitUrl = respon.portraitPath;
    [[JuPlusUserInfoCenter sharedInstance] loadUserInfo:respon];
    [APService setTags:nil alias:respon.token callbackSelector:nil target:nil];
    //登陆成功刷新个人中心内容
    [CommonUtil postNotification:ReloadPerson Object:nil];
    NSArray *vcArr = [self.navigationController viewControllers];
    //此段意为pop回进入登陆界面的上一层界面
    for(int i=0;i<[vcArr count];i++)
    {
        UIViewController *vc  = [vcArr objectAtIndex:i];
        if([vc isKindOfClass:[LoginViewController class]])
        {
            [self.navigationController popToViewController:[vcArr objectAtIndex:i-1] animated:YES];
            return;

        }
    }
//    for (UIViewController *vc in vcArr) {
//        if([vc isKindOfClass:[LoginViewController class]])
//        {
//            
//            [self.navigationController popToViewController:vc animated:YES];
//            return;
//        }
//    }
}
#pragma mark nextPress

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
//限制11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.tag==0) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    return YES;
}
//重载键盘弹出时的方法,界面上弹的方法
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    //解决键盘不能输入问题
    if (!textField.window.isKeyWindow) {
        [textField.window makeKeyAndVisible];
    }
    //界面向上弹出
    [self animateTextField:textField withTag:textField.tag up:YES];
    
    
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [keyboardTopBar ShowBar:textField];
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [self animateTextField:textField withTag:textField.tag up:NO];
}

-(void)animateTextField:(UITextField *)textField withTag:(int)tag up:(BOOL)up
{
    if (backView.top == nav_height &&up==NO) {
        //界面处于正常状态，界面不下弹
    }
    else
    {
        CGFloat upHeight = 30.0f;
        //界面向上弹出的高度
        movementDistance = tag*upHeight+50.0f;
        int movement = (up?-movementDistance:movementDistance);
        [UIView beginAnimations:@"anim" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:ANIMATION];
        backView.frame = CGRectOffset(backView.frame, 0, movement);
        [UIView commitAnimations];
    }
    
}

-(void)keyBoardTopBarConfirmClicked:(UITextField *)textField{
    
    [textField resignFirstResponder];
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
