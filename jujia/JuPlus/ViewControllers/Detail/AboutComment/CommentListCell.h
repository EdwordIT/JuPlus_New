//
//  CommentListCell.h
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentItem.h"
@interface CommentListCell : UITableViewCell
//头像
@property (nonatomic,strong)UIButton *headerImg;
//昵称按钮点击事件
@property (nonatomic,strong)UIButton *nikenameButton;
//昵称
@property (nonatomic,strong)UILabel *nikenameLabel;
//上传时间
@property (nonatomic,strong)UILabel *createTime;
//评论内容
@property (nonatomic,strong)UILabel *contentLabel;

-(void)fileCell:(CommentItem *)item;
@end
