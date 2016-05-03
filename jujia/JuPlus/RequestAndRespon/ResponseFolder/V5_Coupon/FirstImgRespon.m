//
//  FirstImgRespon.m
//  JuPlus
//
//  Created by admin on 15/10/27.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "FirstImgRespon.h"

@implementation FirstImgRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    NSDictionary *loadPage = [dict objectForKey:@"loadPage"];
    if (IsDicEmpty(loadPage)) {
        self.imgUrl = @"";
    }else
    self.imgUrl = EncodeStringFromDic(loadPage, @"imgUrl");
}
@end
