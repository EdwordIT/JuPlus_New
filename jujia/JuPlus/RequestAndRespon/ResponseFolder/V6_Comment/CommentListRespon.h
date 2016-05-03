//
//  CommentListRespon.h
//  JuPlus
//
//  Created by admin on 15/11/17.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"
#import "CommentItem.h"
@interface CommentListRespon : JuPlusResponse

@property (nonatomic,assign)NSInteger count;

@property (nonatomic,strong)NSMutableArray *listArray;
@end
