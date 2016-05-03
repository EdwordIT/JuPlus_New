//
//  CommentListViewController.m
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "CommentListViewController.h"
#import "CommentListReq.h"
#import "CommentListRespon.h"
#import "CommentListCell.h"
#import "ScrollRefreshView.h"
#import "PostCommentReq.h"
#import "DeleteCommentReq.h"
#import "JuPlusUserInfoCenter.h"
@interface CommentListViewController ()<UITableViewDataSource,UITableViewDelegate,ScrollRefreshViewDegegate,UITextViewDelegate>
{
    NSInteger pageNum;
    NSMutableArray *dataArray;
    CommentListReq *req;
    CommentListRespon *respon;
    ScrollRefreshViewHeader *header;
    ScrollRefreshViewFooter *footer;
    CommentItem *answeredItem;
    NSIndexPath *delIndexPath;
}
@end

@implementation CommentListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = @"全部评论";
    pageNum = 1;
    [self.leftBtn setHidden:NO];
    dataArray = [[NSMutableArray alloc]init];
    [self.topView addSubview:self.comTextView];
    [self.topView addSubview:self.postBtn];
    [self.view addSubview:self.listTab];
    self.listTab.tableHeaderView  = self.topView;
    [self startRequestCommentList];
    // Do any additional setup after loading the view.
}
#pragma uifig
-(UIView *)topView
{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, 140.0f)];
    }
    return _topView;
}
-(UITextView *)comTextView
{
    if (!_comTextView) {
        _comTextView = [[UITextView alloc]initWithFrame:CGRectMake(10.0f, 10.0f, SCREEN_WIDTH - 80.0f, 120.0f)];
        [_comTextView setFont:FontType(FontSize)];
        [_comTextView setTextColor:Color_Gray];
        _comTextView.delegate = self;
        _comTextView.backgroundColor = Color_Bottom;
    }
    return _comTextView;
}
-(UIButton *)postBtn
{
    if (!_postBtn) {
        _postBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _postBtn.frame = CGRectMake(self.comTextView.right+2.f, self.comTextView.top, 60.0f, self.comTextView.height) ;
        [_postBtn setBackgroundColor:Color_Pink];
        [_postBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_postBtn.titleLabel setFont:FontType(20.f)];
        [_postBtn addTarget:self action:@selector(postComment:) forControlEvents:UIControlEventTouchUpInside];
        [_postBtn.titleLabel setTextColor:Color_White];
    }
    return _postBtn;
}
-(UITableView *)listTab
{
    if (!_listTab) {
        _listTab = [[UITableView alloc]initWithFrame:CGRectMake(0.0f, nav_height, SCREEN_WIDTH, view_height) style:UITableViewStylePlain];
        _listTab.delegate = self;
        _listTab.dataSource = self;
        
    }
    return _listTab;
}
#pragma mark --评论相关内容
//提交评论
-(void)postComment:(UIButton *)sender
{
    if (self.comTextView.text.length!=0) {
        if (self.comTextView.text.length<=answeredItem.memberNickname.length) {
            [self showAlertView:@"内容不能为空" withTag:0];
        }else{
            PostCommentReq *comReq = [[PostCommentReq alloc]init];
            [comReq setField:[CommonUtil getToken] forKey:TOKEN];
            [comReq setField:self.collocateNo forKey:@"collocateNo"];
            if (answeredItem!=nil) {
                [comReq setField:answeredItem.memberNo forKey:@"answeredNo"];
                [comReq setField:[self.comTextView.text stringByReplacingCharactersInRange:NSMakeRange(0, answeredItem.memberNickname.length+1) withString:@""] forKey:@"contentText"];
            }else
            {
                [comReq setField:@"0" forKey:@"answeredNo"];
                [comReq setField:self.comTextView.text  forKey:@"contentText"];
                
            }
            JuPlusResponse *comRespon = [[JuPlusResponse alloc]init];
            [HttpCommunication request:comReq getResponse:comRespon Success:^(JuPlusResponse *response) {
                //提交评论成功
                pageNum = 1;
                [self startRequestCommentList];
                answeredItem = nil;
                self.comTextView.text = @"";
            } failed:^(ErrorInfoDto *errorDTO) {
                [self errorExp:errorDTO];
            } showProgressView:YES with:self.view];
        }
    }else{
        [self showAlertView:@"内容不能为空" withTag:0];
    }
}
#pragma mark --keyboardWillShow

#pragma mark --UITableViewDelegate and DataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dataArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CommentItem *item = [dataArray objectAtIndex:indexPath.row];
    NSString *contentTxt;
    if (IsStrEmpty(item.answeredNickname)) {
        contentTxt = item.contentText;
    }else{
        contentTxt = [NSString stringWithFormat:@"@%@ %@",item.answeredNickname,item.contentText];
    }
    CGSize size = [CommonUtil getLabelSizeWithString:contentTxt andLabelWidth:SCREEN_WIDTH - 40.0f andFont:FontType(FontSize)];
    return size.height+70.0f;

}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    CommentListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell==nil) {
        cell = [[CommentListCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
    }
    CommentItem *item = [dataArray objectAtIndex:indexPath.row];
    [cell fileCell:item];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //如果未登录，或者已经登陆过但是没有拿到regNo，先登录
    if (IsStrEmpty([JuPlusUserInfoCenter sharedInstance].userInfo.regNo)) {
        [[JuPlusUserInfoCenter sharedInstance] resetUserInfo];
        [self gologin];
    }else{
        CommentItem *item = [dataArray objectAtIndex:indexPath.row];
        if (item.memberNo==[JuPlusUserInfoCenter sharedInstance].userInfo.regNo) {
            UIAlertView *alt = [[UIAlertView alloc]initWithTitle:Remind_Title message:@"确定要删除这条评论么？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            delIndexPath = indexPath;
            [alt show];
            
        }else
        {
            [tableView setContentOffset:CGPointMake(0.0f, 0.0f)];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            NSString *text = self.comTextView.text;
            //如果还没有@任何人，则直接添加@内容
            if (answeredItem==nil) {
                answeredItem = [dataArray objectAtIndex:indexPath.row];
                if(IsStrEmpty(text)){
                    self.comTextView.text = [NSString stringWithFormat:@"@%@",answeredItem.memberNickname];
                }else
                {
                    self.comTextView.text = [[NSString stringWithFormat:@"@%@",answeredItem.memberNickname] stringByAppendingString:text];
                }
            }else
                //如果已经@过人之后点击，点击即为切换@人，即更换answeredItem
            {
                NSString *text = self.comTextView.text;
                self.comTextView.text = [text stringByReplacingCharactersInRange:NSMakeRange(0, answeredItem.memberNickname.length+1) withString:[NSString stringWithFormat:@"@%@",((CommentItem *)[dataArray objectAtIndex:indexPath.row]).memberNickname]];
                answeredItem = [dataArray objectAtIndex:indexPath.row];
            }
            [self.comTextView becomeFirstResponder];
        }

    }
   }
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [super alertView:alertView clickedButtonAtIndex:buttonIndex];
    if (buttonIndex==1) {
        CommentItem *item = [dataArray objectAtIndex:delIndexPath.row];
        DeleteCommentReq *delReq = [[DeleteCommentReq alloc]init];
        [delReq setField:[CommonUtil getToken] forKey:TOKEN];
        [delReq setField:item.comId forKey:@"commentId"];
        JuPlusResponse *delRespon = [[JuPlusResponse alloc]init];
        [HttpCommunication request:delReq getResponse:delRespon Success:^(JuPlusResponse *response) {
            [dataArray removeObjectAtIndex:delIndexPath.row];
            [self.listTab reloadData];            
        } failed:^(ErrorInfoDto *errorDTO) {
            [self errorExp:errorDTO];
        } showProgressView:YES with:self.view];
           }
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark --textViewDelegate
-(void)textViewDidBeginEditing:(UITextView *)textView
{
   
}
-(void)textViewDidChange:(UITextView *)textView
{
    //输入框有变化的时候
    if (answeredItem) {
        if (self.comTextView.text.length<=answeredItem.memberNickname.length) {
            self.comTextView.text = @"";
            answeredItem = nil;
        }
    }
    
}
#pragma mark --refreshView
-(void)refreshViewBeginRefreshing:(ScrollRefreshView *)refreshView
{
    if (refreshView.viewType==RefreshViewTypeHeader) {
        pageNum = 1;
    }else if(refreshView.viewType==RefreshViewTypeFooter){
        if ([dataArray count]>=respon.count) {
            [refreshView setState:RefreshStateALL withAnimate:YES];
        }else
        pageNum++;
        
    }
    [self startRequestCommentList];
}
-(void)startRequestCommentList
{
    req = [[CommentListReq alloc]init];
    [req setField:[NSString stringWithFormat:@"%ld",(long)pageNum] forKey:PageNum];
    [req setField:PAGESIZE forKey:PageSize];
    [req setField:self.collocateNo forKey:@"collocateNo"];
    respon = [[CommentListRespon alloc]init];
    [HttpCommunication request:req getResponse:respon Success:^(JuPlusResponse *response) {
        if (respon.count==0) {
            [self setNoDataImageFrame:self.listTab];
        }else
            [self.noDataImage setHidden:YES];
        if (pageNum==1) {
            [dataArray removeAllObjects];
        }
            [dataArray addObjectsFromArray:respon.listArray];
        [self.listTab reloadData];
        [self stopRefresh];
    } failed:^(ErrorInfoDto *errorDTO) {
        [self errorExp:errorDTO];
        [self stopRefresh];
    } showProgressView:YES with:self.view];
}
-(void)stopRefresh
{
    [footer endRefreshing];
    [header endRefreshing];
}
-(void)reloadNetWorkError
{
    pageNum = 1;
    [self startRequestCommentList];
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
