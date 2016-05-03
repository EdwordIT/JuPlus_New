//
//  MyMessageRespon.m
//  JuPlus
//
//  Created by admin on 16/4/19.
//  Copyright © 2016年 居+. All rights reserved.
//

#import "MyMessageRespon.h"

@implementation MyMessageRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    self.messageArray = [[NSMutableArray alloc]init];
//    NSDictionary *infoMap = [[NSDictionary alloc]initWithDictionary:[dict objectForKey:@"infoMap"]];
//    self.totalCount = [infoMap objectForKey:@"count"] integerValue];
    NSArray *arr =[dict objectForKey:@"data"];
    for (NSDictionary *exapmle in arr) {
        MessageDTO *dto = [[MessageDTO alloc]init];
        [dto loadDTO:exapmle];
        [self.messageArray addObject:dto];
    }
}
@end
