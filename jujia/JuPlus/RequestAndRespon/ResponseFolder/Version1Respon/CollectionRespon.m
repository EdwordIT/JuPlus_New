//
//  CollectionRespon.m
//  JuPlus
//
//  Created by admin on 15/7/2.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "CollectionRespon.h"
#import "HomePageInfoDTO.h"
@implementation CollectionRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.listArray = [[NSMutableArray alloc]init];
    self.count = [NSString stringWithFormat:@"%@",[dict objectForKey:@"count"]];
    NSArray *listArr = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    
    for(int i=0;i<[listArr count];i++)
    {
    HomePageInfoDTO *dto = [[HomePageInfoDTO alloc]init];
        [dto loadDTO:[listArr objectAtIndex:i]];
        [self.listArray addObject:dto];
    }
}

@end
