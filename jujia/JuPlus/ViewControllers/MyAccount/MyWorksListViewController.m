//
//  MyWorksListViewController.m
//  JuPlus
//
//  Created by admin on 15/8/12.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "MyWorksListViewController.h"
#import "JuPlusRefreshView.h"
#import "MyworkslistReq.h"
#import "MyworkslistRespon.h"
#import "MyDeleteReq.h"
#import "GetFavListReq.h"
#import "PackageViewController.h"
#import "CameraViewController.h"
#import "HomeFurnishingViewController.h"
#import "FavViewController.h"
@interface MyWorksListViewController ()<UITableViewDelegate,UITableViewDataSource,ScrollRefreshViewDegegate>

{
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter *footer;
    ScrollRefreshView *selectView;
    
    int pageNum;
    int allCount;
    
}

@end

@implementation MyWorksListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //重写返回按钮
    [self resetBackView];
    
    pageNum = 1;
    [self.titleLabel setText:@"我的作品"];
    [self.view addSubview:self.listTab];
//    [self.view addSubview:self.earningsV];
    [self startRequestMy];
    //去掉分割线
    self.listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.dataArray = [[NSMutableArray alloc]init];
    
    //发布按钮
    [self.rightBtn setHidden:NO];
    [self.rightBtn setTitle:@"发布" forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:Color_Basic  forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(release:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //上拉刷新
    header = [ScrollRefreshViewHeader header];
    header.delegate = self;
    header.scrollView = self.listTab;
    //下拉加载
    footer = [ScrollRefreshViewFooter footer];
    footer.delegate = self;
    footer.scrollView = self.listTab;
    
    // Do any additional setup after loading the view.
}
//- (UIView *)earningsV
//{
//   int space = 5.0;
//    if (!_earningsV) {
//        _earningsV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT/4)];
//        _earningsV.backgroundColor = Color_Gray_lines;
//        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0.0f, (SCREEN_HEIGHT/4-2*space)*2/3, self.earningsV.width, 3.0f)];
//        line.backgroundColor = Color_Gray_lines;
//        UIView *back = [[UIView alloc]initWithFrame:CGRectMake(space, space, SCREEN_WIDTH-2*space, SCREEN_HEIGHT/4-2*space)];
//        back.backgroundColor = Color_White;
//        [_earningsV addSubview:back];
//        [back addSubview:line];
//        //总收益
//        _earnBut = [UIButton buttonWithType:UIButtonTypeCustom];
//        _earnBut.frame = CGRectMake((SCREEN_WIDTH-50)/2, (SCREEN_HEIGHT/4-2*space)*1/7, 50, 30);
//        [_earnBut setTitle:@"总收益" forState:UIControlStateNormal];
//        [_earnBut setTitleColor:RGBCOLOR(94, 94, 94) forState:UIControlStateNormal];
//        _earnBut.titleLabel.font = FontType(FontSize);
//        [back addSubview:_earnBut];
//        _earnLabel = [[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH-200)/2,(SCREEN_HEIGHT/4-2*space)/7+20 , 200, 40)];
//        _earnLabel.text = @"345,678,214.34";
//        _earnLabel.textColor = Color_Basic;
//        _earnLabel.font = FontType(25);
//        _earnLabel.textAlignment = NSTextAlignmentCenter;
//        [back addSubview:_earnLabel];
//        //提现
//        _withdrawalBut = [UIButton buttonWithType:UIButtonTypeSystem];
//        _withdrawalBut.frame = CGRectMake((SCREEN_WIDTH-30)/7, (SCREEN_HEIGHT/4-2*space)*2/3+((SCREEN_HEIGHT/4-2*space)/3-30)/2+3.0f, 60, 30);
//        [_withdrawalBut setTitle:@"提 现" forState:UIControlStateNormal];
//        [_withdrawalBut setTitleColor:RGBCOLOR(94, 94, 94) forState:UIControlStateNormal];
//        _withdrawalBut.titleLabel.textAlignment = NSTextAlignmentCenter;
//        _withdrawalBut.titleLabel.font = FontType(FontMaxSize);
//        [back addSubview:_withdrawalBut];
//        //卡设置
//        _cardBut = [UIButton buttonWithType:UIButtonTypeSystem];
//        _cardBut.frame = CGRectMake((SCREEN_WIDTH-30)*5/7, (SCREEN_HEIGHT/4-2*space)*2/3+((SCREEN_HEIGHT/4-2*space)/3-30)/2+3.0f, 60, 30);
//        [_cardBut setTitle:@"卡设置" forState:UIControlStateNormal];
//        [_cardBut setTitleColor:RGBCOLOR(94, 94, 94) forState:UIControlStateNormal];
//        _cardBut.titleLabel.font = FontType(FontMaxSize);
//        _cardBut.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [back addSubview:_cardBut];
//        
//    }
//    return _earningsV;
//}
- (void)release:(UIButton *)button
{
    CameraViewController *cameVC = [[CameraViewController alloc]init];
    [self.navigationController pushViewController:cameVC animated:YES];
}
-(void)resetBackView
{
    [self.leftBtn setHidden:YES];
    UIButton * leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    leftBtn.frame = CGRectMake(0.0f, self.navView.height -44.0f, 44.0f, 44.0f);
    [leftBtn setBackgroundImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backPress:) forControlEvents:UIControlEventTouchUpInside];
    [self.navView addSubview:leftBtn];
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
    [self.navigationController popToRootViewControllerAnimated:YES];

}
#pragma mark --uifig
-(UITableView *)listTab
{
    if(!_listTab)
    {
//        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height+SCREEN_HEIGHT/4, SCREEN_WIDTH, SCREEN_HEIGHT-nav_height-SCREEN_HEIGHT/4) style:UITableViewStylePlain];
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, SCREEN_HEIGHT-nav_height) style:UITableViewStylePlain];
        _listTab.delegate = self;
        _listTab.dataSource = self;
    
    }return _listTab;
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
    
    [self startRequestMy];
}
-(void)stopReresh
{
    [selectView endRefreshing];
}
//网络请求
- (void)startRequestMy
{
    MyworkslistReq *myReq = [[MyworkslistReq alloc]init
                                     ];
    [myReq setField:[CommonUtil getToken] forKey:TOKEN];
    [myReq setField:[NSString stringWithFormat:@"%d",pageNum] forKey:PageNum];
    [myReq setField:PAGESIZE forKey:PageSize];
    MyworkslistRespon * respon = [[MyworkslistRespon alloc]init];
    [HttpCommunication request:myReq getResponse:respon Success:^(JuPlusResponse *response) {
        allCount = [respon.count integerValue];
        if (pageNum == 1) {
            [self.dataArray removeAllObjects];
        }
        [self.dataArray addObjectsFromArray:respon.myworkArray];
        if (IsArrEmpty(self.dataArray)) {
            [self.listTab addSubview:self.noDataImage];
            [self setNoDataImageFrame:self.listTab];
        }else{
            [self.noDataImage removeFromSuperview];
            [self.listTab reloadData];
        }
        [self stopReresh];
        
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self.view];
}
- (void)reloadNetWorkError
{
    [self startRequestMy];
}
#pragma mark --
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return PICTURE_HEIGHT/2+41.0f;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   static NSString *work = @"work";
    MyWorksCell *cell = [tableView dequeueReusableCellWithIdentifier:work];
    if (!cell) {
        cell = [[MyWorksCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:work];
    }
    cell.deleteBtn.tag = indexPath.row + 1000;

    //复制方法fileData
    self.dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell fileData:_dto];
    
    //收藏按钮
    [cell.favBtn addTarget:self action:@selector(favBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //按钮方法
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    //购买按钮
//    [cell.payBtn addTarget:self action:@selector(payBut:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
//收藏按钮方法
- (void)favBtnClick:(UIButton *)button
{
    FavViewController *favVC = [[FavViewController alloc]init];
    favVC.favId = [NSString stringWithFormat:@"%ld",button.tag];
    [self.navigationController pushViewController:favVC animated:YES];
}
//购买按钮
//- (void)payBut:(UIButton *)but
//{
//    
//}

- (void)deleteBtnClick:(UIButton *)button
{
    
//     self.indexPath = [NSIndexPath indexPathForRow:button.tag inSection:0];
    
    self.index = [NSIndexPath indexPathForRow:button.tag - 1000 inSection:0];
    
    NSLog(@"Index = %d", (int)self.index.row);

    UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"确定删除此项内容么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alt show];
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if(buttonIndex == 1){
//       NSLog(@"%ld", (long)self.index);
        
        MyDeleteReq *req = [[MyDeleteReq alloc]init];
        MyWorksDTO *dto = [self.dataArray objectAtIndex:self.index.row];
        NSLog(@"self.dataArray.count = %d", (int)self.dataArray.count);
        
        [req setField:dto.regNo forKey:@"collocateNo"];
        [req setField:[CommonUtil getToken] forKey:TOKEN];
        
        NSLog(@"%@ ------", req);
        JuPlusResponse *respon = [[JuPlusResponse alloc]init];
        
        [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
           
            [CommonUtil postNotification:ReloadAddress Object:nil];
            //删除成功
            [self.dataArray removeObjectAtIndex:self.index.row];
            NSLog(@"删除的Index = %d", (int)self.index.row);

            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:self.index.row inSection:0];
            NSLog(@"刷新的Index = %d", (int)self.index.row);
            
            [self.listTab deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            //刷新tab
            NSIndexSet *indexset = [[NSIndexSet alloc] initWithIndex:0];
            [self.listTab reloadSections:indexset withRowAnimation:UITableViewRowAnimationNone];
            
        } failed:^(ErrorInfoDto *errorDTO) {
            [self errorExp:errorDTO];
        } showProgressView:YES with:self.view];
    }
}
//推到详情
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    MyWorksDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    PackageViewController *singVC = [[PackageViewController alloc]init];
    singVC.regNo = dto.regNo;
    [self.navigationController pushViewController:singVC animated:YES];

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
