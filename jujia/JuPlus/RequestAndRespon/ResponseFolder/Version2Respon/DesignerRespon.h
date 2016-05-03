//
//  DesignerRespon.h
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusResponse.h"

@interface DesignerRespon : JuPlusResponse

@property (nonatomic, strong) NSMutableArray *designerArray;
@property (nonatomic, strong) NSString *nickname;
@property (nonatomic, strong) NSString *portraitPath;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *orderFlag;
@end
