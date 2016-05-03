//
//  RelatedTagsRespon.h
//  JuPlus
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface RelatedTagsRespon : JuPlusResponse
@property (nonatomic,strong)NSMutableArray *tagsArray;

@property (nonatomic,strong)NSString *count;
@end
