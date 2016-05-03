//
//  HomePageInfoDTO.m
//  JuPlus
//
//  Created by 詹文豹 on 15/6/26.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "HomePageInfoDTO.h"
#import "CommentItem.h"
@implementation HomePageInfoDTO

-(void)loadDTO:(NSDictionary *)dict
{
    self.memNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"memberNo"]];
    self.uploadTime = [NSString stringWithFormat:@"%@",[dict objectForKey:@"uploadTime"]];
    self.portrait = [NSString stringWithFormat:@"%@",[dict objectForKey:@"portraitPath"]];
    self.nikename = [NSString stringWithFormat:@"%@",[dict objectForKey:@"nickname"]];
    self.descripTxt = [NSString stringWithFormat:@"%@",[dict objectForKey:@"explain"]];
    self.regNo = [NSString stringWithFormat:@"%@",[dict objectForKey:@"regNo"]];

    self.collectionPic = [NSString stringWithFormat:@"%@",[dict objectForKey:@"coverUrl"]];
    self.sharePic = [NSString stringWithFormat:@"%@",[dict objectForKey:@"sharePicUrl"]];

    self.price = [NSString stringWithFormat:@"%@",[dict objectForKey:@"totalPrice"]];
    self.favCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"favouriteCount"]];
    self.comCount = [NSString stringWithFormat:@"%@",[dict objectForKey:@"commentCount"]];

    NSArray *arr = [dict objectForKey:@"productList"];
    self.labelArray = [[NSMutableArray alloc]init];
    for (int i=0; i<[arr count]; i++) {
        LabelDTO *dto = [[LabelDTO alloc]init];
        [dto loadDTO:[arr objectAtIndex:i]];
        [self.labelArray addObject:dto];
    }
    NSArray *arr1 = [dict objectForKey:@"commentList"];
    self.commentList = [[NSMutableArray alloc]init];
    for (NSDictionary *dic in arr1) {
        CommentItem *item = [[CommentItem alloc]init];
        [item loadDTO:dic];
        [self.commentList addObject:item];
    }

}
@end
