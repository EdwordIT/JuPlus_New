//
//  FavRespon.m
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "FavRespon.h"
#import "FavDTO.h"
@implementation FavRespon

- (void)unPackJsonValue:(NSDictionary *)dict
{
    
    self.count = [NSString stringWithFormat:@"%@",[dict objectForKey:@"count"]];
    self.favArray = [[NSMutableArray alloc]init];
    NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    
    for (int i = 0; i < [arr count]; i++) {
        FavDTO *dto = [[FavDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.favArray addObject:dto];
    }
}

@end
