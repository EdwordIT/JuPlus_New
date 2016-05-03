//
//  FavViewController.h
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIViewController.h"
#import "FavDTO.h"
@interface FavViewController : JuPlusUIViewController

@property (nonatomic, strong)NSMutableArray *dataArray;
@property (nonatomic, strong)FavDTO *dto;

@property (nonatomic, strong) NSString *favId;

@end
