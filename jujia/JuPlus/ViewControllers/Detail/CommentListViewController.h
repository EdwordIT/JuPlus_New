//
//  CommentListViewController.h
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "JuPlusUIViewController.h"

@interface CommentListViewController : JuPlusUIViewController
//评论效果图注册号
@property (nonatomic,strong)NSString *collocateNo;

@property (nonatomic,strong)UIView *topView;

@property (nonatomic,strong)UITableView *listTab;
//添加评论
@property (nonatomic,strong)UITextView *comTextView;
//提交按钮
@property (nonatomic,strong)UIButton *postBtn;
@end
