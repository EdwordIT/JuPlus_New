//
//  CollectionRespon.h
//  JuPlus
//
//  Created by admin on 15/7/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface CollectionRespon : JuPlusResponse

@property(nonatomic,strong)NSString *count;
@property(nonatomic,strong)NSMutableArray *listArray;
@end
