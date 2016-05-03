//
//  ClassifyRespon.m
//  JuPlus
//
//  Created by admin on 15/6/30.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "ClassifyRespon.h"
#import "ClassifyTagsDTO.h"
@implementation ClassifyRespon

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
//        /*此排序是根据数字大小判断*/
//        NSNumber* num1 = [NSNumber numberWithInt:[string1.sortId integerValue]];
//        NSNumber* num2 = [NSNumber numberWithInt:[string2.sortId integerValue]];
//        NSComparisonResult result = [num1 compare:num2];//注意:基本数据类型要进行数据转换
//        return result;
    /*此排序是根据数字大小判断*/
        if ([string1.sortId integerValue]>[string2.sortId integerValue]) {
            return (NSComparisonResult)NSOrderedDescending;//如果前大于后，则调整位置
        }
        return (NSComparisonResult)NSOrderedSame;
        /*此排序是字符串排序，根据首位判断，不涉及大小*/
//        return [string1.sortId compare:string2.sortId];//->默认升序排列
//        return NSOrderedAscending;//设置格式为升序
    };
    self.tagsArray = [sortArray sortedArrayUsingComparator:sortBlock];
    
//    for (int i=0; i<[self.tagsArray count]; i++) {
//        ClassifyTagsDTO *dto = [self.tagsArray objectAtIndex:i];
//        //NSLog(@"sortId = %@",dto.sortId);
//    }
}
@end
