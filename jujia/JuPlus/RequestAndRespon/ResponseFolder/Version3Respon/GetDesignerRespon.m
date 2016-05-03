//
//  GetDesignerRespon.m
//  JuPlus
//
//  Created by admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "GetDesignerRespon.h"
#import "MapDesignerDTO.h"
#import "MapCollocationDTO.h"
@implementation GetDesignerRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.count = EncodeStringFromDic(dict, @"count");
    NSArray *arr1 = [dict objectForKey:@"colList"];
    NSArray *arr2 = [dict objectForKey:@"memList"];

    self.designerArray = [[NSMutableArray alloc]init];
    self.collocationArray = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in arr1) {
        MapCollocationDTO *dto = [[MapCollocationDTO alloc]init];
        [dto loadDTO:dic];
        [self.collocationArray addObject:dto];
    }
    for (NSDictionary *dic in arr2) {
        MapDesignerDTO *dto = [[MapDesignerDTO alloc]init];
        [dto loadDTO:dic];
        [self.designerArray addObject:dto];
    }

}
@end
