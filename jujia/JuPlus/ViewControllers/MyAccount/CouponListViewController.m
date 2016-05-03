//
//  CouponListViewController.m
//  JuPlus
//
//  Created by admin on 15/10/19.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CouponListViewController.h"
#import "CouponListReq.h"
#import "CouponListRespon.h"
@interface CouponListViewController ()<ScrollRefreshViewDegegate>
{
    
    ScrollRefreshViewHeader *header;
    ScrollRefreshView *selectedView;

    ScrollRefreshViewFooter *footer;
    NSInteger pageNum;
    CouponListReq *listReq;
    CouponListRespon *listRespon;
    NSMutableArray *selBtnArray;
}
@end

@implementation CouponListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.titleLabel setText:@"我的优惠券"];
    self.view.backgroundColor = Color_Bottom;
    [self.view addSubview:self.listTab];
    selBtnArray = [[NSMutableArray alloc]init];
    self.dataArray = [[NSMutableArray alloc]init];
    if (self.isFromOrder) {
           }else
        [self loadRefresh];

    [self startRequestList];
    // Do any additional setup after loading the view.
}
-(UITableView *)listTab
{
    if (!_listTab) {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height) style:UITableViewStylePlain];
        _listTab.delegate = self;
        _listTab.dataSource = self;
        [_listTab setBackgroundColor:[UIColor clearColor]];
        _listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _listTab;
}
//上拉加载更多和下拉刷新
-(void)loadRefresh
{
    pageNum = 1;
    
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.listTab;
    
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.listTab;


}
-(void)refreshViewBeginRefreshing:(ScrollRefreshView *)refreshView
{
    selectedView = refreshView;
    if (refreshView.viewType == RefreshViewTypeHeader) {
        pageNum = 1;
        [self startRequestList];
    }else if (refreshView.viewType ==RefreshViewTypeFooter)
    {
        if ([self.dataArray count]<listRespon.count) {
            pageNum++;
            [self startRequestList];
        }else{
            [footer setState:RefreshStateALL withAnimate:YES];
        }
    }
}
#pragma mark --数据刷新
-(void)reloadNetWorkError
{
    pageNum = 1;
    [self startRequestList];
}
-(void)startRequestList
{
    if (!self.isFromOrder) {
        listReq = [[CouponListReq alloc]init];
        [listReq setField:[CommonUtil getToken] forKey:TOKEN];
        [listReq setField:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:PageNum];
        [listReq setField:PAGESIZE forKey:PageSize];
        /*此字段多余，撤销操作*/
        //    if (IsStrEmpty(self.minAmt)) {
        //        [listReq setField:@"0" forKey:@"usedMinAmt"];
        //    }else
        //        [listReq setField:self.minAmt forKey:@"usedMinAmt"];
        listRespon = [[CouponListRespon alloc]init];
        [HttpCommunication request:listReq getResponse:listRespon Success:^(JuPlusResponse *response) {
            if (pageNum==1) {
                [self.dataArray removeAllObjects];
            }
            [self.dataArray addObjectsFromArray:listRespon.listArray];
            
            if (listRespon.count==0) {
                [self setNoDataImageFrame:self.listTab];
            }else
                [self.noDataImage removeFromSuperview];
            [self.listTab reloadData];
            [selectedView endRefreshing];
        } failed:^(ErrorInfoDto *errorDTO) {
            [self errorExp:errorDTO];
            [selectedView endRefreshing];
        } showProgressView:YES with:self.view];
        
    }else
        [self.dataArray addObjectsFromArray:self.listArray];
}

#pragma mark --tableViewDelegate and Datasource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCREEN_WIDTH * 210.0f/584.0f +20.0f;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *certifi = @"certifi";
    CouponItem *item = [self.dataArray objectAtIndex:indexPath.row];
//    CouponCell *cell = [tableView dequeueReusableCellWithIdentifier:certifi];
//    if (cell==nil) {
//        cell = [[CouponCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:certifi];
//    }
    CouponCell *cell = [[CouponCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:certifi];
    if (self.isFromOrder) {
        [cell.selectBtn setHidden:NO];
        if (item.idString==self.selectedId) {
            cell.selectBtn.selected = YES;
        }
        cell.selectBtn.tag = indexPath.row;
        [cell.selectBtn addTarget:self action:@selector(selectBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [selBtnArray addObject:cell.selectBtn];
    }
    [cell fileCell:item];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
     CouponCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    UIButton *sender = cell.selectBtn;
    for (UIButton *btn in selBtnArray) {
        if(sender.tag==btn.tag)
        {
            sender.selected = !sender.selected;
        }else
            btn.selected = NO;
    }
    //优惠券传值
    CouponItem *item;
    if (sender.selected==YES) {
        item = [self.dataArray objectAtIndex:sender.tag];
    }
    if (self.couponBlock!=nil) {
        self.couponBlock(item);
    }

}
#pragma mark --buttonPress
//点击确认按钮，使用改优惠券

-(void)selectBtnPress:(UIButton *)sender
{
    for (UIButton *btn in selBtnArray) {
        if(sender.tag==btn.tag)
        {
            sender.selected = !sender.selected;
        }else
            btn.selected = NO;
    }
    //优惠券传值
    CouponItem *item;
    if (sender.selected==YES) {
        item = [self.dataArray objectAtIndex:sender.tag];
    }
    if (self.couponBlock!=nil) {
        self.couponBlock(item);
    }

}
-(void)returnCoupon:(ReturnCouponBlock)block
{
    self.couponBlock = block;
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
