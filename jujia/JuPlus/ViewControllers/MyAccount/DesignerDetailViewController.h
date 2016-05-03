//
//  DesignerDetailViewController.h
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIViewController.h"

#import "DesignerCell.h"
#import "ErrorInfoDto.h"
@interface DesignerDetailViewController : JuPlusUIViewController
@property (nonatomic, strong)NSMutableArray *dataArray;

@property (nonatomic,strong)UITableView *tableV;

@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *orderFlag;

@end
