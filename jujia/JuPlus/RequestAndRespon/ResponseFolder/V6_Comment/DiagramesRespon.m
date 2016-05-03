//
//  DiagramesRespon.m
//  JuPlus
//
//  Created by admin on 16/3/17.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "DiagramesRespon.h"

@implementation DiagramesRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.listArray=  [[NSMutableArray alloc]init];
    self.infoMap = [dict objectForKey:@"infoMap"];
    self.totalCount = [[self.infoMap objectForKey:@"count"] integerValue];
    NSArray *arr = [dict objectForKey:@"data"];
    
    if (self.totalCount>0) {
        for(int i=0;i<[arr count];i++)
        {
            DiagramsDTO *dto = [[DiagramsDTO alloc]init];
            [dto loadDTO:[arr objectAtIndex:i]];
            [self.listArray addObject:dto];
        }
    }
   }
@end
