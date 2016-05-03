//
//  GetFavListRespon.h
//  JuPlus
//
//  Created by admin on 15/7/15.
//  Copyright (c) 2015年 居+. All rights reserved.
//我的收藏内容展示

#import "JuPlusResponse.h"

@interface GetFavListRespon : JuPlusResponse

@property (nonatomic,assign)int count;
@property (nonatomic,strong)NSMutableArray *dataArray;
@end
