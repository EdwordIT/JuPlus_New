//
//  OrderListViewController.m
//  JuPlus
//
//  Created by admin on 15/7/8.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "OrderListViewController.h"
#import "OrderListReq.h"
#import "OrderListRespon.h"
#import "OrderListCell.h"
#import "OrderDetailViewController.h"
#import "HomeFurnishingViewController.h"
#import "DeleteOrderReq.h"
#define defaultH 80.0f
@interface OrderListViewController ()<ScrollRefreshViewDegegate>
{
    OrderListReq *listReq;
    OrderListRespon *listRespon;
    
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter * footer;
    ScrollRefreshView *selectView;
    NSIndexPath *delIndexPath;
    int pageNum;
    int totalCount;
}
@end

@implementation OrderListViewController

#pragma mark --tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderListDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    return defaultH + dto.totalCount*80.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"orderList";
    OrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil)
    {
        cell = [[OrderListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    OrderListDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell fileCell:dto];
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:@"我的订单"];
    self.dataArray = [[NSMutableArray alloc]init];
    [self.view addSubview:self.orderListTab];
    pageNum = 1;
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.orderListTab;
    
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.orderListTab;

    [self.leftBtn removeFromSuperview];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0.0f, self.navView.height -44.0f, 44.0f, 44.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];
    // Do any additional setup after loading the view.
}
-(void)backPress:(UIButton *)sender
{
    
    NSArray *vcArr = [self.navigationController viewControllers];
    for (UIViewController *vc in vcArr) {
        if([vc isKindOfClass:[HomeFurnishingViewController class]])
        {
            [self.navigationController popToViewController:vc animated:YES];
            return;
        }
    }
    [self.navigationController popViewControllerAnimated:YES];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startRequest1];
}
-(void)startRequest1
{
    listReq = [[OrderListReq alloc]init];
    [listReq setField:[CommonUtil getToken] forKey:TOKEN];
    [listReq setField:[NSString stringWithFormat:@"%d",pageNum] forKey:PageNum];
    [listReq setField:PAGESIZE forKey:PageSize];
    listRespon = [[OrderListRespon alloc]init];
    [HttpCommunication request:listReq getResponse:listRespon Success:^(JuPlusResponse *response) {
        totalCount = [listRespon.totalCount intValue];
        if (pageNum==1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:listRespon.orderListArray];
        if (IsArrEmpty(self.dataArray)) {
            [self.orderListTab addSubview:self.noDataImage];
            [self setNoDataImageFrame:self.orderListTab];
        }else{
            [self.noDataImage removeFromSuperview];
            [self.orderListTab reloadData];
        }

        [self stopReresh];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self.view];
}

#pragma mark --refreshDelegate
-(void)refreshViewBeginRefreshing:(ScrollRefreshView *)refreshView
{
    selectView = refreshView;
    //下拉刷新
    if(refreshView.viewType == RefreshViewTypeHeader)
    {
        pageNum = 1;
        //下拉刷新则重载上拉加载更多选项
        [footer setState:RefreshStateNormal withAnimate:NO];
    }
    //上拉加载更多
    else
    {
        if([self.dataArray count]>=totalCount)
        {
            //显示无更多内容
            [refreshView setState:RefreshStateALL withAnimate:YES];
            return;
        }
        pageNum++;
    }
    [self startRequest1];
}
-(void)stopReresh
{
    [selectView endRefreshing];
}

-(UITableView *)orderListTab
{
    if(!_orderListTab)
    {
        _orderListTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height) style:UITableViewStylePlain];
        _orderListTab.delegate = self;
        _orderListTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _orderListTab.dataSource = self;
    }
    return _orderListTab;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
     OrderListDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    OrderDetailViewController *detail = [[OrderDetailViewController alloc]init];
    detail.orderNo = dto.orderNo;
    [self.navigationController pushViewController:detail animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --订单号删除
//允许滑动删除
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
//启动删除时候，同时向后台发送删除请求
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"订单删除后不可恢复，确定删除此项订单内容么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            alt.tag = 101;
            delIndexPath = indexPath;
            [alt show];
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
            [self deleteOrder];
        }
        else
        {
            [alertView dismissWithClickedButtonIndex:0 animated:YES];
        }
    }
}
-(void)deleteOrder
{
    DeleteOrderReq *del = [[DeleteOrderReq alloc]init];
    OrderListDTO *dto = [self.dataArray objectAtIndex:delIndexPath.row];
    [del setField:dto.orderNo forKey:@"orderNo"];
    [del setField:[CommonUtil getToken] forKey:TOKEN];
    JuPlusResponse *respon = [[JuPlusResponse alloc]init];
    [HttpCommunication request:del getResponse:respon Success:^(JuPlusResponse *response) {
        [CommonUtil postNotification:ReloadAddress Object:nil];
        //删除成功
        [self.dataArray removeObjectAtIndex:delIndexPath.row];
        [self.orderListTab deleteRowsAtIndexPaths:[NSArray arrayWithObject:delIndexPath]                                    withRowAnimation:UITableViewRowAnimationAutomatic];
        //显示无数据状态
        if (IsArrEmpty(self.dataArray)) {
            [self.orderListTab addSubview:self.noDataImage];
            [self setNoDataImageFrame:self.orderListTab];
        }
        
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
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
