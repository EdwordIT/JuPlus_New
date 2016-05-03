//
//  PersonCenterView.m
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "PersonCenterView.h"
#import "PersonCenterReq.h"
#import "PersonCenterRespon.h"
#import "OrderListViewController.h"
#import "DesignerDetailViewController.h"
#import "MyFavourViewController.h"
#import "JuPlusUserInfoCenter.h"
#import "MyInfoViewController.h"
#import "CameraViewController.h"
#import "MyWorksListViewController.h"
#import "PersonCell.h"
#import "MyAppointViewController.h"
#import "CouponListViewController.h"
#import "SettingViewController.h"
#import "MyMessageViewController.h"
@implementation PersonCenterView
{
    PersonCenterReq *centerReq;
    PersonCenterRespon *centerRespon;
    UIView *collocateRemind;
    UIView *orderRemind;
    
}

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.backgroundColor = RGBCOLOR(239, 239, 239);
        [self.navView setHidden:NO];
        self.listArr = [[NSMutableArray alloc]init];
        self.titleLabel.text = @"我的主页";
       // [self.rightBtn setHidden:YES];
        [self addleftSetting];
        self.rightBtn.frame = CGRectMake(self.navView.width - 44.0f, 20.0f, 44.0f, 44.0f);
        [self.rightBtn setBackgroundImage:[UIImage imageNamed:@"setting_left"] forState:UIControlStateNormal];
        [self.rightBtn addTarget:self action:@selector(goSetting) forControlEvents:UIControlEventTouchUpInside];
        [self uifig];
        [self addSubview:self.appointTable];
    }return self;
}
-(void)addleftSetting
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(10.0f, 32.0f, 43.0f, 20.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"icons_coupon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(couponPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];
}
//优惠券
-(void)couponPress:(UIButton *)sender
{
    CouponListViewController *coupon = [[CouponListViewController alloc]init];
    [[self getSuperViewController].navigationController pushViewController:coupon animated:YES];
}
-(void)uifig
{
    [self addSubview:self.topView];
    [self.topView addSubview:self.portrait];
    [self.topView addSubview:self.nickLabel];
    [self addSubview:self.uploadBtn];
    CGFloat labelW = 40.0f;
    CGFloat space = 60.0f;
    CGFloat labelH = 30.0f;
    NSArray *array=[NSArray arrayWithObjects:@"作品",@"买入",@"收藏", nil];
    for (int i =0; i<3; i++) {
        JuPlusUILabel *label = [[JuPlusUILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - (labelW*3+space*2))/2+(space+labelW)*i, 120.0f, labelW, labelH)];
        [label setFont:FontType(FontMaxSize)];
        [label setTextColor:Color_Basic];
        label.textAlignment = NSTextAlignmentCenter;
        label.tag = i;
        [self.topView addSubview:label];
        [self.listArr addObject:label];
        
        
        
        JuPlusUILabel *label1 = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(label.left, label.top+labelH, labelW, labelH)];
        [label1 setFont:FontType(FontMaxSize)];
        [label1 setTextColor:Color_Gray];
        label1.tag = i;
        label1.textAlignment = NSTextAlignmentCenter;
        [label1 setText:[array objectAtIndex:i]];
        [self.topView addSubview:label1];
        
        if (i==0) {
            collocateRemind = [[UIView alloc]initWithFrame:CGRectMake(label1.width/2 + 15.0f, 5.0f, 2.0f, 2.0f)];
            collocateRemind.layer.cornerRadius = 1.0f;
            collocateRemind.backgroundColor = [UIColor redColor];
            [label1 addSubview:collocateRemind];
            [collocateRemind setHidden:YES];
        }else if(i==1)
        {
            orderRemind = [[UIView alloc]initWithFrame:CGRectMake(label1.width/2 + 15.0f, 5.0f, 2.0f, 2.0f)];
            orderRemind.layer.cornerRadius = 1.0f;
            orderRemind.backgroundColor = [UIColor redColor];
            [label1 addSubview:orderRemind];
            [orderRemind setHidden:YES];
            
        }

        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(label.left, label.top, labelW, labelH*2);
        [self.topView addSubview:btn];
        btn.tag = i;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetNickname) name:ResetNickName object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetPortrait) name:ResetPortrait object:nil];
    //[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startHomePageRequest) name:ReloadPerson object:nil];
    

}
- (UITableView *)appointTable
{
    if (!_appointTable) {
        
        _appointTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, self.topView.height+nav_height, SCREEN_WIDTH, SCREEN_HEIGHT - self.topView.height - nav_height - TABBAR_HEIGHT) style:UITableViewStylePlain];
        _appointTable.separatorStyle = 0;
        _appointTable.backgroundColor = RGBACOLOR(235.0f, 235.0f, 235.0f, 0.8);
        _appointTable.dataSource = self;
        _appointTable.delegate = self;
        _appointTable.scrollsToTop = NO;
    }
    return _appointTable;
}
-(void)startHomePageRequest
{
    centerReq = [[PersonCenterReq alloc]init];
    [centerReq setField:[CommonUtil getToken] forKey:TOKEN];
    centerRespon = [[PersonCenterRespon alloc]init];
    [HttpCommunication request:centerReq getResponse:centerRespon Success:^(JuPlusResponse *response) {
        [self configData];
        [self.appointTable reloadData];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self];
}
- (void)reloadNetWorkError
{
    [self startHomePageRequest];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[PersonCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    if (indexPath.section ==0) {
        if (indexPath.row == 0) {
            cell.appointLabel.text = @"我的账户";
            cell.appImage.image = [UIImage imageNamed:@"me"];
            cell.arrowImage.image = [UIImage imageNamed:@"arrow_person_right"];
        }
       else if (indexPath.row == 1) {
            cell.appointLabel.text = @"我的订单";
            cell.appImage.image = [UIImage imageNamed:@"app"];
//            cell.arrowImage.image = [UIImage imageNamed:@"arrow_person_right"];
        }
       else if (indexPath.row == 2) {
            cell.appImage.image = [UIImage imageNamed:@"per"];
            if ([self.designerFlag integerValue]== 0) {
                cell.appointLabel.text = @"成为搭配师";
            }else {
                cell.appointLabel.text = @"我的发布";
            }
        }
       else if (indexPath.row == 3) {
           //我的消息的二级界面
            cell.appImage.image = [UIImage imageNamed:@"myMessage"];
            cell.arrowImage.image = [UIImage imageNamed:@"arrow_person_right"];
           if ([centerRespon.messageCount integerValue]!=0) {
               [cell.messageLabel setHidden:NO];
               [cell.messageLabel setText:centerRespon.messageCount];
           }else{
               [cell.messageLabel setHidden:YES];
           }
            cell.appointLabel.text = @"我的消息";
           
        }

    }
    cell.selectionStyle = 0;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_HEIGHT/4;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//我的账户
    if (indexPath.row == 0) {
        MyInfoViewController *myInfo = [[MyInfoViewController alloc]init];
        [[self getSuperViewController].navigationController pushViewController:myInfo animated:YES];
       
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
//我的订单
    if (indexPath.row == 1) {
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        //购买过的（订单列表）
        OrderListViewController *order = [[OrderListViewController alloc]init];
        [[self getSuperViewController].navigationController pushViewController:order animated:YES];       [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
//我的发布/成为搭配师
    if (indexPath.row == 2) {
        if ([self.designerFlag integerValue] == 0) {
            CameraViewController *view = [[CameraViewController alloc]init];
            [[self getSuperViewController].navigationController pushViewController:view animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }else {
          MyWorksListViewController *myWork = [[MyWorksListViewController alloc]init];
        [[self getSuperViewController].navigationController pushViewController:myWork animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }
    }
    //我的消息
    if (indexPath.row == 3) {
        MyMessageViewController *myMessage = [[MyMessageViewController alloc]init];
        [[self getSuperViewController].navigationController pushViewController:myMessage animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    
}
-(void)resetNickname
{
    [self.nickLabel setText:[JuPlusUserInfoCenter sharedInstance].userInfo.nickname];

}
-(void)resetPortrait
{
    [self.portrait setimageUrl:[JuPlusUserInfoCenter sharedInstance].userInfo.portraitUrl placeholderImage:nil];
}


-(void)configData
{
    [JuPlusUserInfoCenter sharedInstance].userInfo.nickname = centerRespon.nickname;
    [JuPlusUserInfoCenter sharedInstance].userInfo.portraitUrl = centerRespon.portrait;
    NSArray *arr = [NSArray arrayWithObjects:centerRespon.worksCount,centerRespon.payCount,centerRespon.favourCount, nil];
    [self.portrait setimageUrl:centerRespon.portrait placeholderImage:nil];
    [self.nickLabel setText:centerRespon.nickname];
    self.designerFlag = centerRespon.designerFlag;
    for (int i=0; i<[self.listArr count]; i++) {
        [((JuPlusUILabel *)[self.listArr objectAtIndex:i]) setText:[arr objectAtIndex:i]];
        if ([centerRespon.collocateRemind integerValue]!=0) {
            [collocateRemind setHidden:NO];
        }else
            [collocateRemind setHidden:YES];

        if ([centerRespon.orderRemind integerValue]!=0) {
            [orderRemind setHidden:NO];
        }else
            [orderRemind setHidden:YES];
    }
}
-(void)goSetting
{
    SettingViewController *setting = [[SettingViewController alloc]init];
    [[self getSuperViewController].navigationController pushViewController:setting animated:YES];
}
-(void)goMyInfo
{
    
    MyInfoViewController *info = [[MyInfoViewController alloc]init];
    [[self getSuperViewController].navigationController pushViewController:info animated:YES];
}
#pragma mark --UIfig
-(JuPlusUIView *)topView
{
    if (!_topView) {
        _topView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, 200.0f)];
        _topView.backgroundColor = Color_White;
        _topView.layer.borderColor = [Color_Bottom CGColor];
    }
    return _topView;
}
-(UIButton *)portrait
{
    if(!_portrait)
    {
        self.portrait = [UIButton buttonWithType:UIButtonTypeCustom];
        
        self.portrait.frame = CGRectMake((self.width - 60.0f)/2,10, 60, 60);
        self.portrait.layer.masksToBounds=YES;
        self.portrait.layer.cornerRadius=30;
        [self.portrait addTarget:self action:@selector(goMyInfo) forControlEvents:UIControlEventTouchUpInside];
    }
    return _portrait;
}
-(JuPlusUILabel *)nickLabel
{
    if(!_nickLabel)
    {
        _nickLabel =[[JuPlusUILabel alloc]initWithFrame:CGRectMake(0.0f, self.portrait.bottom+16, self.topView.width, 20)];
        _nickLabel.font=FontType(FontMaxSize);
        _nickLabel.textColor=Color_Black;
        _nickLabel.textAlignment=NSTextAlignmentCenter;

    }
    return _nickLabel;
}
//-(UIButton *)uploadBtn
//{
//    if(!_uploadBtn)
//    {
//        _uploadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        _uploadBtn.frame = CGRectMake((SCREEN_WIDTH - 100.0f)/2, self.topView.bottom+50.0f, 100.0f, 100.0f) ;
//        [_uploadBtn setBackgroundImage:[UIImage imageNamed:@"becomeDesigner"] forState:UIControlStateNormal];
//        [_uploadBtn setBackgroundImage:[UIImage imageNamed:@"becomeDesigner"] forState:UIControlStateHighlighted];
//        [_uploadBtn addTarget:self action:@selector(uploadClick) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _uploadBtn;
//}
//-(void)uploadClick
//{
////    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"完成基础操作后成为居+搭配设计师" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
////    alt.tag = 101;
////    [alt show];
//    CameraViewController *view = [[CameraViewController alloc]init];
//    [[self getSuperViewController].navigationController pushViewController:view animated:YES];
//    
//}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    //必须先走父类中的代理方法，以防止子类代理覆盖父类中的内容
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==101) {
        if (buttonIndex==0) {
          
        }
        else
        {
            //联系客服
            UIWebView*callWebview =[[UIWebView alloc] init];
            NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@",HELPTELEPHONE]];
            [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
            [self addSubview:callWebview];
        }
        [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
    }
}
#pragma mark --btnClick
-(void)btnClick:(UIButton *)sender
{
    switch (sender.tag) {
        case 0:
        {
            //[self uploadClick];
            MyWorksListViewController *myWorks = [[MyWorksListViewController alloc]init];
            [[self getSuperViewController].navigationController pushViewController:myWorks animated:YES];
            
        }
            break;
        case 1:
        {
            //购买过的（订单列表）
            OrderListViewController *order = [[OrderListViewController alloc]init];
            [[self getSuperViewController].navigationController pushViewController:order animated:YES];
        }
            break;
        case 2:
        {
            //我的收藏
            MyFavourViewController *fav = [[MyFavourViewController alloc]init];
            [[self getSuperViewController].navigationController pushViewController:fav animated:YES];

        }
            break;
            
        default:
            break;
    }
    
}
@end
