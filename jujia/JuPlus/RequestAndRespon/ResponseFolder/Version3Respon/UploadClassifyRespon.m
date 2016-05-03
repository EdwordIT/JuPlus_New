//
//  UploadClassifyRespon.m
//  JuPlus
//
//  Created by admin on 15/9/11.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "UploadClassifyRespon.h"
#import "ClassifyTagsDTO.h"
@implementation UploadClassifyRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    NSMutableArray *sortArray = [[NSMutableArray alloc]init];
    
    NSArray *arr = [dict objectForKey:@"data"];
    for(int i=0;i<[arr count];i++)
    {
        ClassifyTagsDTO *dto = [[ClassifyTagsDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [sortArray addObject:dto];
    }
    NSComparator sortBlock = ^(ClassifyTagsDTO *string1, ClassifyTagsDTO *string2)
    {
        if ([string1.sortId integerValue]>[string2.sortId integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;//如果前大于后，则调整位置
        }
        return (NSComparisonResult)NSOrderedSame;
        /**/
    };
    self.tagsArray = [sortArray sortedArrayUsingComparator:sortBlock];
}

@end
