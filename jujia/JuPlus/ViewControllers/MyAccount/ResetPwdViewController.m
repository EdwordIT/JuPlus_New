//
//  ResetPwdViewController.m
//  JuPlus
//
//  Created by admin on 15/7/20.
//  Copyright (c) 2015年 居+. All rights reserved.
//重置密码

#import "ResetPwdViewController.h"
#import "KeyBoardTopBar.h"
#import "JuPlusTextField.h"
#import "ChangepwdReq.h"
@interface ResetPwdViewController ()<keyBoardTopBarDelegate,UITextFieldDelegate>
{
    KeyBoardTopBar *keyboardTopBar;
    CGFloat movementDistance;
}

@property (nonatomic,strong)UIScrollView *backView;

@property (nonatomic,strong)NSMutableArray *fieldArray;

@property (nonatomic,strong)UIButton *sureBtn;
@end

@implementation ResetPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.titleLabel.text = @"密码修改";
    self.fieldArray = [[NSMutableArray alloc]init];
    
   self.backView=[[UIScrollView alloc]initWithFrame:CGRectMake(0.0f,nav_height,SCREEN_WIDTH ,view_height)];
    self.backView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:self.backView];
    NSArray *array1=[NSArray arrayWithObjects:@"原密码",@"新密码",@"确认密码", nil];
    for (int i=0; i<array1.count; i++) {
        JuPlusTextField *rlView=[[JuPlusTextField alloc]initWithFrame:CGRectMake(20.0f,20.0f+ i*50.0f, SCREEN_WIDTH-40.0f, 50.0f)];
        rlView.contentField.tag=i;
        rlView.contentField.secureTextEntry = YES;
        rlView.headTitleLa.text=[array1 objectAtIndex:i];
        rlView.contentField.delegate=self;
        [self.backView addSubview:rlView];
        [self.fieldArray addObject:rlView.contentField];
    }
    
    self.sureBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    self.sureBtn.frame=CGRectMake(30.0f, 420.0f, SCREEN_WIDTH-60.0f, 44);
    [self.sureBtn setTitle:@"确认" forState:UIControlStateNormal];
    [self.sureBtn setBackgroundColor:Color_Gray];
    self.sureBtn.alpha = ALPHLA_BUTTON;
    self.sureBtn.userInteractionEnabled = NO;
    [self.sureBtn.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:16.0]];
    [self.sureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [self.backView addSubview:self.sureBtn];
    [self.sureBtn addTarget:self action:@selector(sureClick:) forControlEvents:UIControlEventTouchUpInside];

    //按钮上下跳转
    keyboardTopBar = [[KeyBoardTopBar alloc] initWithArray:self.fieldArray];
    [keyboardTopBar setAllowShowPreAndNext:YES];
    keyboardTopBar.delegate = self;

    self.backView.contentSize = CGSizeMake(SCREEN_WIDTH, view_height+100.0f);
    
    [self.view bringSubviewToFront:self.navView];
    // Do any additional setup after loading the view.
}

-(void)sureClick:(UIButton *)sender
{
    UITextField *tf1 = [self.fieldArray objectAtIndex:0];
    UITextField *tf2 = [self.fieldArray objectAtIndex:1];
    UITextField *tf3 = [self.fieldArray objectAtIndex:2];
    if([tf2.text isEqualToString:tf3.text])
    {
        ChangepwdReq *req = [[ChangepwdReq alloc]init];
        [req setField:[CommonUtil getToken] forKey:TOKEN];
        [req setField:tf1.text forKey:@"oldLoginPwd"];
        [req setField:tf2.text forKey:@"newLoginPwd"];
        JuPlusResponse *res = [[JuPlusResponse alloc]init];
        [HttpCommunication request:req getResponse:res Success:^(JuPlusResponse *response) {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"修改成功" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
            alt.tag =101;
            [alt show];
        } failed:^(ErrorInfoDto *errorDTO) {
            [self errorExp:errorDTO];
        } showProgressView:YES with:self.view];

    }
    else
    {
        [self showAlertView:@"两次输入内容不一致" withTag:0];
    }

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==101) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
#pragma mark --tabBarTextField
//限制11位
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    UITextField *tf1 = [self.fieldArray objectAtIndex:0];
    UITextField *tf2 = [self.fieldArray objectAtIndex:1];
    UITextField *tf3 = [self.fieldArray objectAtIndex:2];
    if(!IsStrEmpty(tf1.text)&&!IsStrEmpty(tf2.text)&&!IsStrEmpty(tf3.text))
    {
        self.sureBtn.userInteractionEnabled = YES;
        [self.sureBtn setBackgroundColor:Color_Pink];
    }
    else
    {
        self.sureBtn.userInteractionEnabled = NO;
        [self.sureBtn setBackgroundColor:Color_Gray];

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
    if (self.view.top==nav_height&&up==NO) {
        //界面处于正常状态，界面不下弹
    }
    else
    {
        CGFloat upHeight = 50.0f;
        //界面向上弹出的高度
        movementDistance = tag*upHeight;
        
        const float movementDuration = 0.3f;
        int movement = (up?-movementDistance:movementDistance);
        [UIView beginAnimations:@"anim" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:movementDuration];
        self.backView.frame = CGRectOffset(self.backView.frame, 0, movement);
        [UIView commitAnimations];
    }
    
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
