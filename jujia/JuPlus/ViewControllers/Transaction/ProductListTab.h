//
//  ProductListTab.h
//  JuPlus
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 居+. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductTableViewCell.h"
@interface ProductListTab : UITableView<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong)NSArray *dataArray;

@property (nonatomic,strong)NSMutableArray *countArray;
@end
