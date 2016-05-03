//
//  DesignerRespon.m
//  JuPlus
//
//  Created by ios_admin on 15/8/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "DesignerRespon.h"
#import "DesignerDTO.h"
@implementation DesignerRespon

- (void)unPackJsonValue:(NSDictionary *)dict
{
    self.nickname = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickname"]];
    self.portraitPath = [NSString stringWithFormat:@"%@",[dict objectForKey:@"portraitPath"]];
    self.count = [NSString stringWithFormat:@"%@",[dict objectForKey:@"count"]];
    self.orderFlag = [NSString stringWithFormat:@"%@",[dict objectForKey:@"orderFlag"]];
    self.designerArray = [[NSMutableArray alloc]init];
    NSArray *arr = [NSArray arrayWithArray:[dict objectForKey:@"list"]];
    
    for (int i = 0; i < [arr count]; i++) {
        DesignerDTO *dto = [[DesignerDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.designerArray addObject:dto];
    }
}

@end
