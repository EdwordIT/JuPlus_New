//
//  PackageViewController.h
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIViewController.h"
#import "PostFaverReq.h"
#import "DeleteFavReq.h"

@interface PackageViewController : JuPlusUIViewController<UIScrollViewDelegate>
//套餐id
@property(nonatomic,strong)NSString *regNo;

@property(nonatomic,strong)NSString *imgUrl;

@property(nonatomic,assign)CGRect popSize;

@property(nonatomic,assign)BOOL isAnimation;

@end
