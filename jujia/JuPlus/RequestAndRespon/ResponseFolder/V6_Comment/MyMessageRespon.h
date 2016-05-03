//
//  MyMessageRespon.h
//  JuPlus
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "MessageDTO.h"
@interface MyMessageRespon : JuPlusResponse
@property(nonatomic,assign)NSInteger totalCount;
@property(nonatomic,strong)NSMutableArray *messageArray;
@end
