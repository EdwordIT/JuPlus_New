//
//  CollectionView.m
//  JuPlus
//
//  Created by admin on 15/7/7.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CollectionView.h"
#import "HomePageInfoDTO.h"
#import "CollocationReq.h"
#import "CollectionRespon.h"
#import "PackageCell.h"
#import "PackageViewController.h"
#import "PackageCell.h"
#import "JuPlusTabBarView.h"
#import "CommentListViewController.h"
@implementation CollectionView
{
    NSMutableArray *dataArray;
    NSMutableArray *listArray;
    CollocationReq *collReq;
    CollectionRespon *collRespon;
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter * footer;
    ScrollRefreshView *selectView;
    int pageNum;
    //数据总数
    int totalCount;
    
    int listPageNum;
    int  listTotalCount;
    BOOL isDraging;
    //是否是点击切换
    
    NSArray *bannerArray;
    
    DiagramsReq *listReq;
    DiagramesRespon *listRespon;
}
@synthesize Animationed;
-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if(self)
    {
        self.layer.masksToBounds = YES;
        dataArray = [[NSMutableArray alloc]init];
        listArray = [[NSMutableArray alloc]init];

        [self addSubview:self.design];

        [self addSubview:self.listTab];
        pageNum = 1;
        header = [ScrollRefreshViewHeader header];
        header.delegate = self;
        header.scrollView =  self.listTab;
        
        footer = [ScrollRefreshViewFooter footer];
        footer.delegate = self;
        footer.scrollView = self.listTab;
        
        [self.navView setHidden:NO];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resetHeaderView) name:@"resetHeaderView" object:nil];
        self.titleLabel.text = @"居+";
//        self.statusBar.userInteractionEnabled = YES;
//        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGes)];
//        [self.statusBar addGestureRecognizer:tap];
        [self.rightBtn setImage:[UIImage imageNamed:@"icons_Classify"] forState:UIControlStateNormal];
        self.rightBtn.frame = CGRectMake(self.navView.width - 88.0f, self.rightBtn.top, self.rightBtn.width, self.rightBtn.height);
        [self.rightBtn setHidden:NO];
        [self.navView addSubview:self.switchBtn];
        //切换显示效果
        [self.switchBtn addTarget:self action:@selector(switchBtnPress:) forControlEvents:UIControlEventTouchUpInside];
        [self startHomePageRequest];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadFromClassify) name:ReloadList object:nil];
        
        listPageNum = 1;
        //[self createScrollView];
    
    }
    return self;
}
//#pragma mark --DIAGRAMES
//-(void)createScrollView
//{
//    self.diagramsScroll = [[JT3DScrollView alloc]initWithFrame:CGRectMake(0.f, nav_height, SCREEN_WIDTH, view_height)];
//    self.diagramsScroll.scrollsToTop = NO;
//    self.diagramsScroll.effect = JT3DScrollViewEffectCards;
//    [self.diagramsScroll setHidden:YES];
//    self.diagramsScroll.delegate = self;
//    self.diagramsScroll.backgroundColor = Color_White;
//    [self addSubview:self.diagramsScroll];
// 
//    [self requestDiagrames];
//}
//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    if (scrollView==self.diagramsScroll) {
//        if (self.diagramsScroll.contentOffset.x/self.diagramsScroll.width>=listArray.count-1) {
//            if ([listArray count]<listRespon.totalCount) {
//                listPageNum++;
//                [self requestDiagrames];
//            }
//        }
//    }
//}
//-(void)requestDiagrames
//{
//    listReq = [[DiagramsReq alloc]init];
//    listRespon = [[DiagramesRespon alloc]init];
//    NSString *reqUrl = [NSString stringWithFormat:@"list?pageNum=%d&pageSize=%@",listPageNum,PAGESIZE];
//    [listReq setField:reqUrl forKey:@"FunctionName"];
//    [HttpCommunication request:listReq getResponse:listRespon Success:^(JuPlusResponse *response) {
//        [listArray addObjectsFromArray:listRespon.listArray];
//        [self loadDiagrameSCrollData];
//    } failed:^(ErrorInfoDto *errorDTO) {
////        <#code#>
//    } showProgressView:NO with:self];
//
//}
////填充scrollview
//-(void)loadDiagrameSCrollData{
//    
//    for (int i=0; i<listRespon.listArray.count; i++) {
//        DiagramsDTO *dto = [listRespon.listArray objectAtIndex:i];
//        CGFloat width = CGRectGetWidth(self.diagramsScroll.frame);
//        CGFloat height = CGRectGetHeight(self.diagramsScroll.frame);
//        
//        CGFloat x = self.diagramsScroll.subviews.count * width;
//        
//        DiagramsView *view = [[DiagramsView alloc] initWithFrame:CGRectMake(x+20, 20.f, width - 40.f, height - 40.f - TABBAR_HEIGHT)];
//    
//        [view ReloadView:dto];
//        [self.diagramsScroll addSubview:view];
//        
//        self.diagramsScroll.contentSize = CGSizeMake(x + width, height);
//
//    }
//   }
-(void)tapGes
{
    [UIView animateWithDuration:ANIMATION animations:^{
        [self.listTab setContentOffset:CGPointMake(0.0f, 0.0f)];
    }];
}
-(DesignerMapView *)design
{
    if (!_design) {
        _design = [[DesignerMapView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height)];
    }
    return _design;
}
-(UIButton *)switchBtn
{
    if(!_switchBtn)
    {
        _switchBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _switchBtn.frame = CGRectMake(self.navView.width - 44.0f, 20.0f, 44.0f, 44.0f);
        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"icons_map"] forState:UIControlStateNormal];
        _switchBtn.showsTouchWhenHighlighted = YES;
        [_switchBtn setBackgroundImage:[UIImage imageNamed:@"icons_home"] forState:UIControlStateSelected];
    }
    return _switchBtn;
}

-(UITableView *)listTab
{
    if(!_listTab)
    {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, self.width, view_height) style:UITableViewStylePlain];
        _listTab.dataSource = self;
        _listTab.delegate = self;
        _listTab.indicatorStyle = UIScrollViewIndicatorStyleWhite;
        _listTab.separatorStyle = UITableViewCellSeparatorStyleNone;
//        默认为yes，如果要起作用则需要此controller上的所有其他scrollview的scrollsToTop属性设置为NO
//        _listTab.scrollsToTop = YES;
    }
    return _listTab;
}
-(MyCycleView *)headerView
{
    if(!_headerView)
    {
        _headerView = [[MyCycleView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 0.f)];
        _headerView.autoRoll = YES;//开启自动滚动
        _headerView.rollTime = 3.0;//自动滚动间隔时间
        _headerView.delegate = self;
//        _headerView.dataSource = self;

          }
    return _headerView;
}
-(void)resetHeaderView
{
    self.listTab.tableHeaderView = self.headerView;
}
#pragma mark --refresh
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
       if([dataArray count]>=totalCount)
       {
           //显示无更多内容
           [refreshView setState:RefreshStateALL withAnimate:YES];
           return;
       }else
        pageNum++;
    }
    [self startHomePageRequest];
}
#pragma mark --一键切换显示方式（左右区间偏移）
#define AnimationTime 1.2f
-(void)moveLeft
{
    self.switchBtn.userInteractionEnabled = NO;
    BOOL selected = self.switchBtn.selected;
//    //设定总体偏移时间
//    
    CGFloat delay1 = ((selected)?1:0)*(AnimationTime - 0.2f);
    CGFloat delay2 = AnimationTime/2 - 0.2f;

    [UIView animateWithDuration:AnimationTime animations:^{
        self.switchBtn.frame = CGRectMake(((selected)?1:0)*(self.navView.width - self.switchBtn.width), self.switchBtn.top, self.switchBtn.width, self.switchBtn.height);
        /*不用此方法原因：当主线程还存在活动时候，例如tableview滑动未结束，或者数据加载未完成等等，此方法都会在这些活动完全结束之后才会调用*/
//        //设定其余内容偏移起始时间
//        [self performSelector:@selector(remove:) withObject:self.rightBtn afterDelay: delay1];
//        [self performSelector:@selector(moveTop:) withObject:self.titleLabel afterDelay:delay2];
//
    } completion:^(BOOL finished) {
        self.switchBtn.selected = !self.switchBtn.selected;
        self.switchBtn.userInteractionEnabled = YES;
    }];
    
    [UIView  animateWithDuration:delay1 animations:^{
        if (self.leftBtn.alpha==0.5) {
            self.leftBtn.alpha = 0.0f;
        }else
        self.leftBtn.alpha = 0.5;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:ANIMATION animations:^{
            CGRect frame = self.rightBtn.frame;
            if (frame.origin.y == 20.0f) {
                frame.origin.y = -nav_height;
            }else
                frame.origin.y = 20.0f;
            self.rightBtn.frame = frame;

        }];
       
    }];
    
    //uiview animation方法，直接在主线程中进行，不会受到其他线程进行的影响，所以此处的duration就是延迟时间，主要功能代码在completetion中，animations里执行的只是一段可有可无的animation，用以保证在duration时间内animations线程不提前结束进入到completion中
    [UIView animateWithDuration:delay2 animations:^{
        if (self.rightBtn.alpha==0.5) {
            self.rightBtn.alpha = 1.0f;
        }else
            self.rightBtn.alpha = 0.5;

    } completion:^(BOOL finished) {
        self.rightBtn.alpha = 1.0;
        [UIView  animateWithDuration:ANIMATION animations:^{
            CGRect frame = self.titleLabel.frame;
            frame.origin.y -= 24.0f;
            self.titleLabel.frame = frame;
        } completion:^(BOOL finished) {
            [UIView animateWithDuration:ANIMATION animations:^{
                CGRect frame = self.titleLabel.frame;
                frame.origin.y += 24.0f;
                self.titleLabel.frame = frame;
            }];
        }];

    }];
}

//-(void)remove:(UIView *)sender
//{
//    [UIView animateWithDuration:ANIMATION animations:^{
//        CGRect frame = sender.frame;
//        if (frame.origin.y == 20.0f) {
//            frame.origin.y = -44.0f;
//        }else
//        frame.origin.y = 20.0f;
//        sender.frame = frame;
//    }];
//}
//-(void)moveTop:(UIView *)sender
//{
//    [UIView animateWithDuration:ANIMATION animations:^{
//            CGRect frame = sender.frame;
//            frame.origin.y -= 24.0f;
//            sender.frame = frame;
//        } completion:^(BOOL finished) {
//        
//        [UIView animateWithDuration:ANIMATION animations:^{
//        CGRect frame = sender.frame;
//        frame.origin.y += 24.0f;
//        sender.frame = frame;
//        }];
//    }];
//}
//地图模式切换
-(void)switchBtnPress:(UIButton *)sender
{
    [self.design startRequest];
    
    [self moveLeft];
    
    [self startAnimation:self.isShowMap];
}
#define cutHeight 1.0f
#define HLANIMATION_TIME1 0.1
#define HLANIMATION_TIME2 1.5f
-(void)startAnimation:(BOOL)animationed
{
    UIView *view = [self superview];
    for (UIView *sub in view.subviews) {
            
        if ([sub isKindOfClass:[JuPlusTabBarView class]]) {
            [UIView animateWithDuration:ANIMATION animations:^{
            sub.frame = CGRectMake(0.0f, SCREEN_HEIGHT - sub.height *((animationed)?1:0), SCREEN_WIDTH, sub.height);
            }];
        }
    }
    
    //动画在此view上进行
    //UIView *containerView = self;
  //移除的view
    
    UIView *fromView = (animationed)?self.design:(self.listTab);
  //移入的view
    UIView *toView =(animationed)?self.listTab:self.design ;
    toView.hidden = NO;
    fromView.alpha = 1;
    [UIView animateWithDuration:1.0f animations:^{
        fromView.alpha = 0;
        toView.alpha = 1;
    } completion:^(BOOL finished) {
//            fromView.hidden = YES;
            toView.hidden = NO;
            self.isShowMap = !self.isShowMap;

        
    }];
//    /* 这个方法能够高效的将当前显示的view截取成一个新的view.你可以用这个截取的view用来显示.例如,也许你只想用一张截图来做动画,毕竟用原始的view做动画代价太高.因为是截取了已经存在的内容,这个方法只能反应出这个被截取的view当前的状态信息,而不能反应这个被截取的view以后要显示的信息.然而,不管怎么样,调用这个方法都会比将view做成截图来加载效率更高.
//     */
//    UIView *moveOut = [fromView snapshotViewAfterScreenUpdates:NO];
//    //cut it into vertical slices
//    NSArray *outgoingLineViews = [self cutView:moveOut intoSlicesOfHeight:cutHeight yOffset:self.design.top];
//    
//    //add the slices to the content view.
//    for (UIView *v in outgoingLineViews) {
//        [containerView addSubview:v];
//    }
//    //[containerView addSubview:toView];
//    
//    CGFloat toViewStartX = toView.frame.origin.x;
//   
//  
//    UIView *moveIn = [toView snapshotViewAfterScreenUpdates:YES];
//    //cut it into vertical slices
//    NSArray *incomingLineViews = [self cutView:moveIn intoSlicesOfHeight:cutHeight yOffset:toView.top];
//    fromView.hidden = YES;
//    toView.hidden = NO;
//    //move the slices in to start position (incoming comes from the right)
//    
//    //移入
//    [self repositionViewSlices:incomingLineViews moveLeft:animationed];
//        //add the slices to the content view.
//        for (UIView *v in incomingLineViews) {
//            [containerView addSubview:v];
//        }
//    //usingSpringWithDamping弹簧效果 数值越大弹簧效果越明显
//        [UIView animateWithDuration:HLANIMATION_TIME2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseIn animations:^{
//            [fromView setHidden:YES];
//            [toView setHidden:YES];
//            //移除
//             [self repositionViewSlices:outgoingLineViews moveLeft:!animationed];
//            
//            [self resetViewSlices:incomingLineViews toXOrigin:toViewStartX];
//
//    //重置frame
//         } completion:^(BOOL finished) {
//            fromView.hidden = YES;
//            toView.hidden = NO;
//            [toView setNeedsUpdateConstraints];
//            for (UIView *v in incomingLineViews) {
//                [v removeFromSuperview];
//            }
//            for (UIView *v in outgoingLineViews) {
//                [v removeFromSuperview];
//            }
//            [moveIn removeFromSuperview];
//            [moveOut removeFromSuperview];
//             self.isShowMap = !self.isShowMap;
//        }];
//    ;
   }
-(NSMutableArray *)cutView:(UIView *)view intoSlicesOfHeight:(float)height yOffset:(float)yOffset{
    
    CGFloat lineWidth = CGRectGetWidth(view.frame);
    
    NSMutableArray *lineViews = [NSMutableArray array];
    
    for (int y=0; y<CGRectGetHeight(view.frame); y+=height) {
        CGRect subrect = CGRectMake(0, y, lineWidth, height);
        
        
        UIView *subsnapshot;
        subsnapshot = [view resizableSnapshotViewFromRect:subrect afterScreenUpdates:NO withCapInsets:UIEdgeInsetsZero];
        subrect.origin.y += yOffset;
        subsnapshot.frame = subrect;
        
        [lineViews addObject:subsnapshot];
    }
    return lineViews;
    
}
/**
 repositions an array of \a views to the left or right by their frames width
 @param views The array of views to reposition
 @param left should the frames be moved to the left
 */
#define RANDOM_FLOAT(MIN,MAX) (((CGFloat)arc4random() / 0x100000000) * (MAX - MIN) + MIN);
-(void)repositionViewSlices:(NSArray *)views moveLeft:(BOOL)left{
    
    
    CGRect frame;
    float width;
    for (UIView *line in views) {
        frame = line.frame;
        width = CGRectGetWidth(frame) * RANDOM_FLOAT(1.0, 8.0);
        
        frame.origin.x += (left)?-width:width;
        
        //save the new position
        line.frame = frame;
    }
}

/**
 resets the views back to a specified x origin.
 @param views The array of uiview objects to reposition
 @param x The x origin to set all the views frames to.
 */
-(void)resetViewSlices:(NSArray *)views toXOrigin:(CGFloat)x{
    
    CGRect frame;
    for (UIView *line in views) {
        frame = line.frame;
        
        frame.origin.x = x;
        
        //save the new position
        line.frame = frame;
        
    }
}


#pragma mark --request
-(void)reloadFromClassify
{
    pageNum = 1;
    [self startHomePageRequest];
}
#pragma mark --reload
-(void)reloadNetWorkError
{
    pageNum = 1;
    [self startHomePageRequest];
}
-(void)startHomePageRequest
{
    Animationed = NO;
    collReq = [[CollocationReq alloc]init];
    collRespon = [[CollectionRespon alloc]init];
    NSString *tagId = [CommonUtil getUserDefaultsValueWithKey:LabelTag];
    NSString *reqUrl = [NSString stringWithFormat:@"list?pageNum=%d&pageSize=%@&tagId=%@",pageNum,PAGESIZE,tagId?tagId:@"0"];
    [collReq setField:reqUrl forKey:@"FunctionName"];
    [HttpCommunication request:collReq getResponse:collRespon Success:^(JuPlusResponse *response) {
        [self.headerView startRequestBannerList];
      
        totalCount = [collRespon.count intValue];
        if (pageNum==1) {
            [self.listTab setContentOffset:CGPointMake(0.0f, 0.0f)];
            [dataArray removeAllObjects];
        }
        [dataArray addObjectsFromArray:collRespon.listArray];
        if (IsArrEmpty(dataArray)) {
            [self.listTab addSubview:self.noDataImage];
            [self setNoDataImageFrame:self.listTab];
            [self.listTab reloadData];
        }else{
            [self.noDataImage removeFromSuperview];
            [self.listTab reloadData];
        }
        [self stopReresh];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopReresh];
    } showProgressView:YES with:self];
}
#pragma mark --BannerList
-(void)stopReresh
{
    [selectView endRefreshing];
}
#pragma mark MyCycleViewDataSource,MyCycleViewDelegate
//-(UIView *)viewAtPage:(NSInteger)page
//{
//  
//    return [self.headerView.scrollView.subviews objectAtIndex:page-1];
//}

#pragma mark --tableViewDelegate
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isShared) {
        return PICTURE_HEIGHT+2.0f;
    }
    else
    {
        HomePageInfoDTO *dto = [dataArray objectAtIndex:indexPath.row];
        return PICTURE_HEIGHT+140.f+30.f*dto.commentList.count;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    isDraging = YES;
}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    isDraging = NO;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *str = @"indexPath";
    PackageCell *cell = [tableView dequeueReusableCellWithIdentifier:str];
    if(cell==nil)
    {
        cell = [[PackageCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:str];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    HomePageInfoDTO *homePage = [dataArray objectAtIndex:indexPath.row];
    [cell loadCellInfo:homePage withShared:self.isShared animationed:Animationed];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(goAllComment:)];
    [cell.commentView addGestureRecognizer:tap];
    if (isDraging) {
        cell.showImgV.alpha = 0;
        [UIView animateWithDuration:1.0f animations:^{
            cell.showImgV.alpha = 1.0f;
        }];
    }
    return cell;
}
-(void)goAllComment:(UITapGestureRecognizer *)ges
{
    CommentListViewController *list = [[CommentListViewController alloc]init];
    list.collocateNo = [NSString stringWithFormat:@"%ld",ges.view.tag];
    [[self getSuperViewController].navigationController pushViewController:list animated:YES];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSLog(@"%ld",(long)indexPath.row);
    //先给本界面加白色底层
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.width, self.height)];
    backV.backgroundColor = Color_White;
    [self addSubview:backV];
    //在白色底层上添加转场动画
    PackageCell *cell = (PackageCell *)[tableView cellForRowAtIndexPath:indexPath];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:cell.showImgV.image];
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = NO;
    CGRect frameInSuperview = [cell.showImgV convertRect:cell.showImgV.frame toView:self.superview];
    if (self.isShared) {

    }else
    frameInSuperview.origin.y -= nav_height+25;
    imageView.frame = frameInSuperview;
    [backV addSubview:imageView];

    CGRect rect = imageView.frame;
    [UIView animateWithDuration:0.5 animations:^{
        imageView.frame = CGRectMake(0.0f, nav_height, SCREEN_WIDTH, PICTURE_HEIGHT);
    } completion:^(BOOL finished) {
        PackageViewController *pack = [[PackageViewController alloc]init];
        HomePageInfoDTO *homePage = [dataArray objectAtIndex:indexPath.row];
        pack.regNo = homePage.regNo;
        pack.imgUrl = homePage.collectionPic;
        pack.popSize = rect;
        pack.isAnimation = YES;
        [[self getSuperViewController].navigationController pushViewController:pack animated:NO];
        [backV setHidden:YES];
        self.isPackage = YES;

    }];

}


@end
