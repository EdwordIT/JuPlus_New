//
//  GetDesignerRespon.h
//  JuPlus
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface GetDesignerRespon : JuPlusResponse

@property (nonatomic,strong)NSString *count;
//搭配师
@property (nonatomic,strong)NSMutableArray *designerArray;

@property (nonatomic,strong)NSMutableArray *collocationArray;
@end
