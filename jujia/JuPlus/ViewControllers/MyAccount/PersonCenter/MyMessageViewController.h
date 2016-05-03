//
//  MyMessageViewController.h
//  JuPlus
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "BasicUIViewController.h"
#import "MyMessageCell.h"
#import "MyMessageReq.h"
#import "MyMessageRespon.h"
//消息列表
@interface MyMessageViewController : JuPlusUIViewController
@property(nonatomic,strong)UITableView *messageTab;
@end
