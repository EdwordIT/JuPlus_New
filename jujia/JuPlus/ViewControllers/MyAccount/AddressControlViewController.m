//
//  AddressControlViewController.m
//  JuPlus
//
//  Created by admin on 15/7/13.
//  Copyright (c) 2015年 居+. All rights reserved.
//地址管理

#import "AddressControlViewController.h"
#import "AddressCell.h"
#import "AddressDTO.h"
#import "GetAddressListReq.h"
#import "GetAddressRespon.h"
#import "AddAddressViewController.h"
#import "DeleteAddressReq.h"
#import "SetDefAddressReq.h"
@interface AddressControlViewController ()<UITableViewDataSource,UITableViewDelegate>
//添加地址
@property(nonatomic,strong)JuPlusUIView *addView;
//地址列表
@property(nonatomic,strong)UITableView *addressListTab;
//数据源
@property(nonatomic,strong)NSMutableArray *dataArray;
@end

@implementation AddressControlViewController
{
    NSIndexPath *delIndexPath;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
-(void)loadBaseUI
{
    self.titleLabel.text = @"收货地址管理";
    self.view.backgroundColor = Color_Bottom;
    [self.view addSubview:self.addView];
    [self.view addSubview:self.addressListTab];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(startRequest) name:ReloadAddress object:nil];
    
}
#pragma mark --ReloadNetWork
-(void)reloadNetWorkError
{
    [self startRequest];
}
#pragma Request
-(void)startRequest
{
    GetAddressListReq *req = [[GetAddressListReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    GetAddressRespon *respon = [[GetAddressRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
    self.dataArray = respon.addressArray;
        
        
        if (IsArrEmpty(self.dataArray)) {
            [self.addressListTab addSubview:self.noDataImage];
            [self setNoDataImageFrame:self.addressListTab];
        }else{
            [self.noDataImage removeFromSuperview];
            if (110.0f*[self.dataArray count]<SCREEN_HEIGHT - self.addView.bottom) {
                self.addressListTab.frame = CGRectMake(0.0f, self.addView.bottom, SCREEN_WIDTH, 110.0f*[self.dataArray count]);
            }
            else
            {
                self.addressListTab.frame = CGRectMake(0.0f, self.addView.bottom, SCREEN_WIDTH, SCREEN_HEIGHT - self.addView.bottom);
            }
            [self.addressListTab reloadData];
        }
} failed:^(ErrorInfoDto *errorDTO) {
    [self errorExp:errorDTO];
} showProgressView:YES with:self.view];
}
#pragma UI
-(JuPlusUIView *)addView
{
    if(!_addView)
    {
        _addView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, 50.0f)];
        _addView.backgroundColor = Color_White;
        
        JuPlusUILabel *label = [[JuPlusUILabel alloc]initWithFrame:CGRectMake(10.0f, 10.0f, 100.0f, 30.0f)];
        [label setFont:FontType(16.0f)];
        [label setText:@"新增收货地址"];
        [_addView addSubview:label];
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(SCREEN_WIDTH - 40.0f, 10.0f, 30.0f, 30.0f);
        [btn setImage:[UIImage imageNamed:@"icons_add"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"icons_add"] forState:UIControlStateHighlighted];
        [btn addTarget:self action:@selector(addClick:) forControlEvents:UIControlEventTouchUpInside];
        [_addView addSubview:btn];
    }
    return _addView;
}
-(UITableView *)addressListTab
{
    if(!_addressListTab)
    {
        _addressListTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, self.addView.bottom, SCREEN_WIDTH, 0.0f) style:UITableViewStylePlain];
        _addressListTab.delegate = self;
        _addressListTab.dataSource = self;
        _addressListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _addressListTab;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *add = @"addAddress";
    AddressCell *cell = [tableView dequeueReusableCellWithIdentifier:add];
    if(cell==nil)
    {
        cell = [[AddressCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:add];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    AddressDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell loadCellWithDTO:dto];
    
    [cell.setDetaultBtn addTarget:self action:@selector(setDetaultBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//允许滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//启动删除时候，同时向后台发送删除请求
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        if([self.dataArray count]==1)
        {
            [self showAlertView:@"请至少保留一个收货地址" withTag:0];
        }
        else
        {
        UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"确定删除此项内容么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alt.tag = 101;
        delIndexPath = indexPath;
        [alt show];
        }
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (alertView.tag==101) {
        if (buttonIndex==1) {
            [self deleteAddress];
        }
        else
        {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
}
-(void)deleteAddress
{
    DeleteAddressReq *del = [[DeleteAddressReq alloc]init];
    AddressDTO *dto = [self.dataArray objectAtIndex:delIndexPath.row];
    [del setField:dto.addId forKey:@"addressId"];
    [del setField:[CommonUtil getToken] forKey:TOKEN];
    JuPlusResponse *respon = [[JuPlusResponse alloc]init];
    [HttpCommunication request:del getResponse:respon Success:^(JuPlusResponse *response) {
        [CommonUtil postNotification:ReloadAddress Object:nil];
        //删除成功
        [self.dataArray removeObjectAtIndex:delIndexPath.row];
        [self.addressListTab deleteRowsAtIndexPaths:[NSArray arrayWithObject:delIndexPath]                                    withRowAnimation:UITableViewRowAnimationAutomatic];
//        if ([dataArray count]==0) {
//            statusImage=[[UIImageView alloc]initWithFrame:CGRectMake(84, (SCREEN_HEIGHT-64-44-85)/2, 152, 85)];
//            statusImage.image=[UIImage imageNamed:@"upload_none.png"];
//            statusImage.userInteractionEnabled=YES;
//            [AuTableView addSubview:statusImage];
         

    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
}
#pragma mark --btnClick
-(void)addClick:(UIButton *)sender
{
    AddAddressViewController *add = [[AddAddressViewController alloc]init];
    [self.navigationController pushViewController:add animated:YES];
}
//设置为默认
-(void)setDetaultBtnClick:(UIButton *)sender
{
    SetDefAddressReq *req = [[SetDefAddressReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:[NSString stringWithFormat:@"%ld",(long)sender.tag] forKey:@"addressId"];
    JuPlusResponse *respon = [[JuPlusResponse alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [CommonUtil postNotification:ReloadAddress Object:nil];       [self startRequest];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:NO with:self.view];
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
