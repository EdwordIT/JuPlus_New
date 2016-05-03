//
//  DiagramesRespon.h
//  JuPlus
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "DiagramsDTO.h"
@interface DiagramesRespon : JuPlusResponse
@property (nonatomic,strong)NSMutableArray *listArray;
//总个数
@property (nonatomic,assign)NSInteger totalCount;
//
@property (nonatomic,assign)NSDictionary *infoMap;
@end
