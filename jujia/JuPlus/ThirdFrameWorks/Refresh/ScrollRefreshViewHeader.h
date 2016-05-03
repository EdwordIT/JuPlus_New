//
//  ScrollRefreshViewHead.h
//  refreshScroll
//
//  Created by lianggq on 13-12-12.
//  Copyright (c) 2013年 lianggq. All rights reserved.
//

#import "ScrollRefreshView.h"

@interface ScrollRefreshViewHeader : ScrollRefreshView

+(id)header;

@property (retain,nonatomic) NSString *message;


@property (nonatomic, assign) BOOL isShowTime;

@end
