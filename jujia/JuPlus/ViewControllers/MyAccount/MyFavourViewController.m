//
//  MyFavourViewController.m
//  JuPlus
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyFavourViewController.h"
#import "GetFavListReq.h"
#import "GetFavListRespon.h"
#import "MyFavourCell.h"
#import "SingleDetialViewController.h"
#import "PackageViewController.h"
@interface MyFavourViewController ()<UITableViewDataSource,UITableViewDelegate,ScrollRefreshViewDegegate>

@property (nonatomic,strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UITableView *myFavTab;
@end

@implementation MyFavourViewController
{
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter * footer;
    ScrollRefreshView *selectView;
    
    int pageNum;
    int totalCount;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.myFavTab];
    // Do any additional setup after loading the view.
}

-(void)loadBaseUI
{
    
    
    self.titleLabel.text = @"我的收藏";
    self.dataArray = [[NSMutableArray alloc]init];
    pageNum = 1;
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.myFavTab;
    
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.myFavTab;
    

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
    [self startRequestFav];
}
-(void)stopReresh
{
    [selectView endRefreshing];
}

-(UITableView *)myFavTab
{
    if(!_myFavTab)
    {
        _myFavTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
        _myFavTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myFavTab.dataSource = self;
        _myFavTab.delegate = self;
    }
    return _myFavTab;
}
#pragma mark --数据刷新
-(void)reloadNetWorkError
{
    [self startRequestFav];
}
-(void)startRequestFav
{
    GetFavListReq *req = [[GetFavListReq alloc]init];
    [req setField:[CommonUtil getToken] forKey:TOKEN];
    [req setField:[NSString stringWithFormat:@"%d",pageNum] forKey:PageNum];
    [req setField:PAGESIZE forKey:PageSize];
    GetFavListRespon *respon = [[GetFavListRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        totalCount = respon.count;
        if (pageNum==1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:respon.dataArray];
        if (IsArrEmpty(self.dataArray)) {
            [self.myFavTab addSubview:self.noDataImage];
            [self setNoDataImageFrame:self.myFavTab];
            
        }else
        {
            [self.noDataImage removeFromSuperview];
            [self.myFavTab reloadData];
        }
        [self stopReresh];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self.view];
}
#pragma mark ----tableViewDelegate--
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_HEIGHT/2+2.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"myFav";
    MyFavourCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[MyFavourCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    MyFavourDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell fileData:dto];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyFavourDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    if([dto.typeId intValue]==1)
    {
        SingleDetialViewController *sing = [[SingleDetialViewController alloc]init];
        sing.singleId = dto.regNo;
        [self.navigationController pushViewController:sing animated:YES];
        
    }
    else
    {
        PackageViewController *sing = [[PackageViewController alloc]init];
        sing.regNo = dto.regNo;
        [self.navigationController pushViewController:sing animated:YES];
  
    }
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self startRequestFav];
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
