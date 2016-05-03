//
//  RelatedTagsRespon.m
//  JuPlus
//
//  Created by admin on 15/8/4.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "RelatedTagsRespon.h"
#import "LabelDTO.h"
@implementation RelatedTagsRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.tagsArray = [[NSMutableArray alloc]init];
    self.count = [NSString stringWithFormat:@"%@",[dict objectForKey:@"count"]];
    NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    
    for (int i=0; i<[arr count]; i++) {
        LabelDTO *dto = [[LabelDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.tagsArray addObject:dto];
    }

    
}
@end
