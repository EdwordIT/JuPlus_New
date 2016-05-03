//
//  MyMessageViewController.m
//  JuPlus
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "MyMessageViewController.h"
#import "PackageViewController.h"
#import "OrderDetailViewController.h"
#import "BasicWebViewViewController.h"
@interface MyMessageViewController ()<UITableViewDataSource,UITableViewDelegate,ScrollRefreshViewDegegate>
{
    NSInteger pageNum;
    NSMutableArray *dataArray;
    ScrollRefreshViewHeader *header;
    ScrollRefreshView *selectedView;
    
    ScrollRefreshViewFooter *footer;
    MyMessageRespon *respon;
}
@end

@implementation MyMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"消息列表";
    dataArray = [[NSMutableArray alloc]init];
    [self.view addSubview:self.messageTab];
    [self loadRefresh];
    [self startMessageRequest];
    // Do any additional setup after loading the view.
}
//上拉加载更多和下拉刷新
-(void)loadRefresh
{
    pageNum = 1;
    
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.messageTab;
    
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.messageTab;
}
//数据页数重新加载
-(void)refreshViewBeginRefreshing:(ScrollRefreshView *)refreshView
{
    selectedView = refreshView;
    if (refreshView.viewType == RefreshViewTypeHeader) {
        pageNum = 1;
        [self startMessageRequest];
    }else if (refreshView.viewType ==RefreshViewTypeFooter)
    {
        if ([dataArray count]<respon.totalCount) {
            pageNum++;
            [self startMessageRequest];
        }else{
            [footer setState:RefreshStateALL withAnimate:YES];
        }
    }
}
#pragma mark --数据刷新
-(void)reloadNetWorkError
{
    pageNum = 1;
    [self startMessageRequest];
}

#pragma mark --uifig
-(UITableView *)messageTab
{
    if (!_messageTab) {
        _messageTab = [[UITableView alloc]initWithFrame:CGRectMake(0.f, nav_height, SCREEN_WIDTH, view_height) style:UITableViewStylePlain];
        [_messageTab setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        _messageTab.backgroundColor = RGBCOLOR(238, 238, 244);
        _messageTab.delegate = self;
        _messageTab.dataSource = self;
        _messageTab.sectionHeaderHeight = 10.f;
        _messageTab.sectionFooterHeight = 0.f;
    }
    return _messageTab;
}
-(void)startMessageRequest
{
    MyMessageReq *req = [[MyMessageReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:PageNum];
    [req setField:PAGESIZE forKey:PageSize];
    respon = [[MyMessageRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        [self stopRefresh];
        if (pageNum==1) {
            [dataArray removeAllObjects];
        }
        [dataArray addObjectsFromArray:respon.messageArray];
        if (IsArrEmpty(dataArray)) {
            [self.messageTab addSubview:self.noDataImage];
            [self setNoDataImageFrame:self.messageTab];
        }else{
            [self.messageTab reloadData];
        }
    } failed:^(ErrorInfoDto *errorDTO) {
        [self stopRefresh];
        [self errorExp:errorDTO];
    } showProgressView:YES with:self.view];
    
}
-(void)stopRefresh
{
    [footer endRefreshing];
    [header endRefreshing];
}
#pragma mark --tableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50.f;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [dataArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"myMessage";
    MyMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[MyMessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    MessageDTO *dto = [dataArray objectAtIndex:indexPath.section];
    [cell.leftImg setImage:[UIImage imageNamed:[NSString stringWithFormat:@"message_0%ld",(long)[dto.type integerValue]]]];
    [cell.textL setText:dto.title];
    if ([dto.status integerValue]==2) {
        [cell.remindImg setHidden:NO];
    }
    [cell.detailTextL setText:dto.content];
    return cell;

}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MessageDTO *dto = [dataArray objectAtIndex:indexPath.section];
    NSInteger type = [dto.type integerValue];
    switch (type) {
        case 1:
        {
            PackageViewController *package = [[PackageViewController alloc]init];
            package.regNo = dto.typeKey;
            [self.navigationController pushViewController:package animated:YES];

        }
            break;
        case 2:
        {
            OrderDetailViewController *order = [[OrderDetailViewController alloc]init];
            order.orderNo = dto.typeKey;
            [self.navigationController pushViewController:order animated:YES];
        }
            break;
        case 3:
        {
            OrderDetailViewController *order = [[OrderDetailViewController alloc]init];
            order.orderNo = dto.typeKey;
            [self.navigationController pushViewController:order animated:YES];
        }
            break;
        case 4:
        {
            BasicWebViewViewController *basic = [[BasicWebViewViewController alloc]init];
            basic.titleStr = @"系统消息";
            basic.htmlUrl = dto.typeKey;
            [self.navigationController pushViewController:basic animated:YES];
        }
            break;
            
        default:
            break;
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
