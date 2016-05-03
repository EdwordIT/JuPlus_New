//
//  FavViewController.m
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "FavViewController.h"
#import "FavCell.h"
#import "FavRequest.h"
#import "FavRespon.h"
#import "FavDTO.h"
#import "DesignerDetailViewController.h"
@interface FavViewController ()<UITableViewDataSource,UITableViewDelegate,ScrollRefreshViewDegegate>
{
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter *footer;
    ScrollRefreshView *selectView;
    
    int pageNum;
    int allCount;
}
@property (nonatomic, strong)UITableView *favTable;
@end

@implementation FavViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    pageNum = 1;
    
    [self favTable];
    self.favTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self startRequestFav];
    [self.view addSubview:self.favTable];
    self.dataArray = [[NSMutableArray alloc]init];
    //上拉刷新
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.favTable;
    //下拉加载
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.favTable;
    
    
    // Do any additional setup after loading the view.
}
-(void)backPress
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableView *)favTable
{
    if (!_favTable) {
        _favTable = [[UITableView alloc]initWithFrame:CGRectMake(0.0f,nav_height, SCREEN_WIDTH, SCREEN_HEIGHT - nav_height) style:UITableViewStylePlain];
        _favTable.dataSource = self;
        _favTable.delegate = self;
        
    }
    return _favTable;
}
//网络请求
- (void)startRequestFav
{
    FavRequest *favReq = [[FavRequest alloc]init];
    [favReq setField:[NSString stringWithFormat:@"%d",pageNum] forKey:PageNum];
    [favReq setField:PAGESIZE forKey:PageSize];
    [favReq setField:self.favId forKey:@"objNo"];
    NSLog(@"=====+++++=====%@",self.favId);
    [favReq setField:@"2" forKey:@"objType"];
    FavRespon *respon = [[FavRespon alloc]init];
    [HttpCommunication request:favReq getResponse:respon Success:^(JuPlusResponse *response) {
        allCount = [respon.count integerValue];
        if (pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        NSString *strArr = [respon.count stringByAppendingString:@"个收藏"];
        if ([respon.count integerValue]==0) {
            strArr = @"暂无人收藏";
        }
        [self.titleLabel setText:strArr];
        [self.dataArray addObjectsFromArray:respon.favArray];
        if (IsArrEmpty(self.dataArray)) {
            [self.favTable addSubview:self.noDataImage];
            [self setNoDataImageFrame:self.favTable];
        }else {
            [self.noDataImage removeFromSuperview];
            [self.favTable reloadData];
        }        [self stopReresh];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self.view];
}
- (void)reloadNetWorkError
{
    [self startRequestFav];
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
        if([self.dataArray count]>=allCount)
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"str";
    FavCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if (!cell) {
        cell = [[FavCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    FavDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell fileData:dto];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_HEIGHT/5;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FavDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    DesignerDetailViewController *detail = [[DesignerDetailViewController alloc]init];
    detail.userId = dto.memberNo;
    [self.navigationController pushViewController:detail animated:YES];
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
