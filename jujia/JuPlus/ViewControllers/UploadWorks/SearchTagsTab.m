//
//  SearchTagsViewController.m
//  JuPlus
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "SearchTagsTab.h"
#import "RelatedTagsReq.h"
#import "RelatedTagsRespon.h"
#import "UploadNotesViewController.h"
@interface SearchTagsTab ()<UITableViewDataSource,UITableViewDelegate,UITextViewDelegate,UISearchBarDelegate,ScrollRefreshViewDegegate>
{
    RelatedTagsReq *tagReq;
    
    RelatedTagsRespon *tagRespon;
    
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter *footer;
    ScrollRefreshView * selectedView;
    int totalCount;
    
    int pageNum;
}

@property (nonatomic,strong)     UITableView *searchResaultTab;

@property (nonatomic,strong) UIButton *cancelBtn;

@property (nonatomic,strong) UIView *headView;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) JuPlusUIView *coverView;


@end

@implementation SearchTagsTab
@synthesize headView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        pageNum = 1;
        self.dataArray = [[NSMutableArray alloc]init];
        headView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, nav_height)];
        headView.backgroundColor = RGBCOLOR(238, 238, 244);
        [self addSubview:headView];
        
        [headView addSubview:self.searchBar];
        
       //
//        UIView *top = [[UIView alloc]initWithFrame:CGRectMake(0.0f,headView.height - 1.0f, self.width, 1.0f)];
//        [top setBackgroundColor:Color_Gray_lines];
//        
//        [headView addSubview:top];
        
        footer = [ScrollRefreshViewFooter footer];
        footer.delegate = self;
        footer.scrollView = self.searchResaultTab;
        header = [ScrollRefreshViewHeader header];
        header.delegate = self;
        header.scrollView = self.searchResaultTab;
        
        
        [self addSubview:self.searchResaultTab];
        
        [self addSubview:self.coverView];
        
        [self.searchResaultTab reloadData];
    }
    return self;
}
#pragma request

//获得标签列表
-(void)startRequest
{
    tagReq = [[RelatedTagsReq alloc]init];
    tagRespon = [[RelatedTagsRespon alloc]init];
    NSString *urlStr = [NSString stringWithFormat:@"list?pageNum=%d&pageSize=%@&name=%@",pageNum,PAGESIZE,self.searchBar.text];
    [tagReq setField:urlStr forKey:@"FunctionName"];

    [HttpCommunication request:tagReq getResponse:tagRespon Success:^(JuPlusResponse *response) {
        [self stopRefresh];
        if (pageNum==1) {
            [self.dataArray removeAllObjects];
           
            LabelDTO *dto = [[LabelDTO alloc]init];
            dto.productName = [NSString stringWithFormat:@"添加标签：%@",self.searchBar.text];
            [self.dataArray addObject:dto];
        }
        [self.dataArray addObjectsFromArray:tagRespon.tagsArray];
        [self.searchResaultTab reloadData];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopRefresh];
    } showProgressView:YES with:self];
}
-(void)stopRefresh
{
    [selectedView endRefreshing];
}
-(void)refreshViewBeginRefreshing:(ScrollRefreshView *)refreshView
{
    selectedView = refreshView;
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
    [self startRequest];
}
#pragma mark - Initialization

- (UISearchBar *)searchBar
{
    if(!_searchBar)
    {
        
        _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0.0f, 20.0f, SCREEN_WIDTH, 44.0f)];
        _searchBar.delegate  = self;
        _searchBar.showsCancelButton = YES;
        _searchBar.placeholder = @"请搜索或添加新标签";
        [self resetSearchBar];
        _searchBar.returnKeyType = UIReturnKeySearch;
    }
    return _searchBar;
    
}

-(void)resetSearchBar
{
    NSArray *subs = ((UIView *)[self.searchBar.subviews lastObject]).subviews;
    for (int i = 0; i < [subs count]; i++) {
        UIView* subv = (UIView*)[subs objectAtIndex:i];
        if ([subv isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subv removeFromSuperview];
        }
        if ([subv isKindOfClass:NSClassFromString(@"UINavigationButton")])
        {
            [((UIButton *)subv) setTitleColor:Color_Basic forState:UIControlStateNormal];
        }
        if ([subv isKindOfClass:NSClassFromString(@"UISearchBarTextField")])
        {
        
            ((UITextField *)subv).borderStyle = UITextBorderStyleRoundedRect;
        }
        
    }
}
#pragma mark --uifig
-(UITableView *)searchResaultTab
{
    if(!_searchResaultTab)
    {
        _searchResaultTab=[[UITableView alloc]initWithFrame:CGRectMake(0,headView.bottom, SCREEN_WIDTH, self.height - headView.bottom)];
        _searchResaultTab.delegate=self;
        _searchResaultTab.dataSource=self;
        _searchResaultTab.separatorColor = Color_Gray_lines;
        _searchResaultTab.backgroundColor = [UIColor whiteColor];
    }
    return _searchResaultTab;
}
//-(UIButton *)cancelBtn
//{
//    if(!_cancelBtn)
//    {
//        
//        UIView *middle = [[UIView alloc]initWithFrame:CGRectMake(self.searchBar.right+15.0f,5.0f, 1.0f, 30.0f)];
//        [middle setBackgroundColor:Color_Gray_lines];
//        [headView addSubview:middle];
//        
//        //完成 按钮
//        _cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//        _cancelBtn.frame=CGRectMake(middle.right , 5.0f , headView.width - middle.right, 30.0f);
//        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
//        [_cancelBtn.titleLabel setFont:FontType(FontSize)];
//        [_cancelBtn setTitleColor:Color_Gray forState:UIControlStateNormal];
//        [_cancelBtn addTarget:self action:@selector(backPress) forControlEvents:UIControlEventTouchUpInside];
//    }
//    return _cancelBtn;
//}
-(JuPlusUIView *)coverView
{
    if(!_coverView)
    {
        _coverView = [[JuPlusUIView alloc]initWithFrame:CGRectMake(0.0f, headView.bottom, SCREEN_WIDTH, view_height)];
        _coverView.backgroundColor = RGBACOLOR(0, 0, 0, 0.3);
        _coverView.userInteractionEnabled = YES;
        [_coverView setHidden:YES];
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapgesPress:)];
//        [_coverView addGestureRecognizer:tap];
    }
    return _coverView;
}
#pragma mark - Life Cycle

-(void)tapgesPress:(UITapGestureRecognizer *)ges
{
    [self.searchBar resignFirstResponder];
}
#pragma mark - UISearchDisplayDelegate
//开始输入
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [self.superview bringSubviewToFront:self];
    
    if (IsArrEmpty(self.dataArray)) {
        [self.coverView setHidden:NO];
    }
    else
    {
        [self.coverView setHidden:YES];
    }

    [self.searchBar setShowsCancelButton:YES animated:YES];
    
}
//搜索框改变，则提交搜索内容，如果搜索出来的联想结果是空，添加此标签

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (IsStrEmpty(searchText)) {

    }
    else
    {
        [self.coverView setHidden:YES];
        [self startRequest];
    }
    

}
//
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self.searchBar resignFirstResponder];
    [self.searchBar setShowsCancelButton:NO animated:YES];
    [self.coverView setHidden:YES];
    [self backPress];
}
-(BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]||[text isEqualToString:@" "])
    {
        //点击搜索，则按照搜索框内的内容重新加载数据源
        //界面向下收缩
        [searchBar resignFirstResponder];
        [self startRequest];
        return NO;
    }
    
    return YES;

}
-(void)backPress{
    [self.searchBar resignFirstResponder];
    [UIView animateWithDuration:ANIMATION animations:^{
        self.frame = CGRectMake(0.0f, SCREEN_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT);
    }];
}

#pragma tableView fig
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
   return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tipCellIdentifier = @"tags";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:tipCellIdentifier];
    }
    LabelDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    [cell.textLabel setFont:FontType(FontSize)];
    cell.textLabel.text = dto.productName;
       return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LabelDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    
    //如果添加标签，则跳转到单品配置界面
    if ([dto.productName rangeOfString:@"添加标签："].location != NSNotFound) {
        self.infoDTO.productName = [dto.productName substringFromIndex:5];
        UploadNotesViewController *upload = [[UploadNotesViewController alloc]init];
        upload.infoDTO = self.infoDTO;
        [[self getSuperViewController].navigationController pushViewController:upload animated:YES];
    }
    else
    {
        self.infoDTO.productNo = dto.productNo;
        self.infoDTO.productName = dto.productName;
        [CommonUtil postNotification:AddLabels Object:self.infoDTO];

    }
    
    [self backPress];
    
}
@end
