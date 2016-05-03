//
//  AddAddressViewController.m
//  JuPlus
//
//  Created by admin on 15/7/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//添加地址

#import "AddAddressViewController.h"
#import "KeyBoardTopBar.h"
#import "AddAddressReq.h"
@interface AddAddressViewController ()<UITextFieldDelegate,keyBoardTopBarDelegate>
@property (nonatomic,strong)JuPlusUIView *backView;

@property (nonatomic,strong)NSMutableArray *textFieldArr;

@property (nonatomic,strong)UIButton *postBtn;
@end

@implementation AddAddressViewController
{
    KeyBoardTopBar *keyboardTopBar;
    //界面向上弹出的高度
    int movementDistance;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:@"添加收货地址"];
    self.textFieldArr = [[NSMutableArray alloc]init];
    [self.view addSubview:self.backView];
    [self uifig];
    [self.view addSubview:self.postBtn];
    [self.view bringSubviewToFront:self.navView];
    // Do any additional setup after loading the view.
}
#define topH 60.0f
-(JuPlusUIView *)backView
{
    if(!_backView)
    {
        _backView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, nav_height+topH, SCREEN_WIDTH, view_height - topH - TABBAR_HEIGHT)];
    }
    return _backView;
}
-(void)uifig
{
    CGFloat sectionH = 50.0f;
    CGFloat spaceX = 20.0f;
    CGFloat titleH = 0.0f;
    CGFloat textFieldH = 40.0f;
    CGFloat viewW = SCREEN_WIDTH - spaceX*2;
    NSArray *title = [NSArray arrayWithObjects:@"请输入地址",@"联系人",@"电话", nil];
    for (int i=0; i<3; i++) {
//        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(spaceX, sectionH*i, viewW, titleH)];
//        [label setFont:FontType(14.0f)];
//        [label setText:[title objectAtIndex:i]];
//        [self.backView addSubview:label];
        
        UITextField *textV = [[UITextField alloc]initWithFrame:CGRectMake(spaceX,spaceX/2+ sectionH*i+titleH, viewW, textFieldH)];
        [textV setFont:FontType(18.0f)];
        textV.placeholder = [title objectAtIndex:i];
        textV.clearButtonMode = UITextFieldViewModeWhileEditing;
        [self.backView addSubview:textV];
        textV.tag = i;
        textV.delegate = self;
        [self.textFieldArr addObject:textV];
        if (i==2) {
            textV.keyboardType = UIKeyboardTypeNumberPad;
        }
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(textV.left, sectionH*(i+1)-1.0f, viewW, 1.0f)];
        [line setBackgroundColor:Color_Gray_lines];
        [self.backView addSubview:line];

    }
    //按钮上下跳转
    keyboardTopBar = [[KeyBoardTopBar alloc] initWithArray:self.textFieldArr];
    [keyboardTopBar setAllowShowPreAndNext:YES];
    keyboardTopBar.delegate = self;

   }

-(UIButton *)postBtn
{
    if(!_postBtn)
    {
        _postBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        _postBtn.frame=CGRectMake(30, SCREEN_HEIGHT - 64.0f, SCREEN_WIDTH-60, TABBAR_HEIGHT);
        [_postBtn setTitle:@"提交" forState:UIControlStateNormal];
        _postBtn.tag=11;
        [_postBtn setBackgroundColor:Color_Pink];
        _postBtn.alpha = ALPHLA_BUTTON;
        [_postBtn.titleLabel setFont:[UIFont fontWithName:FONTSTYLE size:17.0]];
        [_postBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.view addSubview:_postBtn];
        [_postBtn addTarget:self action:@selector(comPress:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _postBtn;
}
-(void)comPress:(UIButton *)sender
{
    int count=3;
    for (UITextField *textfield in self.textFieldArr) {
        if (IsStrEmpty(textfield.text)) {
            count--;
            return;
        }
    }
    
    if (count==3) {
        [self postAddress];
    }
    else
    {
        [self showAlertView:@"请补充完整信息" withTag:0];
    }
}
//提交新地址
-(void)postAddress
{
    AddAddressReq *addReq = [[AddAddressReq alloc]init];

    [addReq setField:((UITextField *)[self.textFieldArr objectAtIndex:0]).text forKey:@"address"];
    [addReq setField:((UITextField *)[self.textFieldArr objectAtIndex:1]).text forKey:@"name"];
    [addReq setField:((UITextField *)[self.textFieldArr objectAtIndex:2]).text forKey:@"mobile"];
    [addReq setField:[CommonUtil getToken] forKey:TOKEN];
    
    JuPlusResponse *addRespon = [[JuPlusResponse alloc]init];
    [HttpCommunication request:addReq getResponse:addRespon Success:^(JuPlusResponse *response) {
        //地址提交成功,其他界面刷新地址信息
        
        [CommonUtil postNotification:ReloadAddress Object:nil];
        [self.navigationController popViewControllerAnimated:YES];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];

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
    if (self.backView.top == nav_height+topH &&up==NO) {
        //界面处于正常状态，界面不下弹
    }
    else
    {
        CGFloat upHeight = 50.0f;
        //界面向上弹出的高度
        movementDistance = tag*upHeight-50.0f;
        const float movementDuration = 0.3f;
        int movement = (up?-movementDistance:movementDistance);
        [UIView beginAnimations:@"anim" context:nil];
        [UIView setAnimationBeginsFromCurrentState:YES];
        [UIView setAnimationDuration:movementDuration];
        self.backView.frame = CGRectOffset(self.backView.frame, 0, movement);
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
