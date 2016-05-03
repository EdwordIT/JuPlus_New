//
//  CommentLabel.h
//  JuPlus
//
//  Created by admin on 15/11/12.
//  Copyright © 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommentItem.h"
@interface CommentLabel : UIView
//头像
@property (nonatomic,strong)UIButton *headerImg;
//昵称按钮点击事件
@property (nonatomic,strong)UIButton *nikenameButton;
//昵称
@property (nonatomic,strong)UILabel *nikenameLabel;
//回复对应人
@property (nonatomic,strong)UILabel *answerLabel;
//评论内容
@property (nonatomic,strong)UILabel *textLabel;
//内容点击事件
@property (nonatomic,strong)UIButton *textButton;

-(void)resetFrame:(CommentItem *)item isHomepage:(BOOL)isHomePage;
@end
