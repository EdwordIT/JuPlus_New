//
//  AlipayDTO.m
//  JuPlus
//
//  Created by admin on 15/9/18.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "AlipayDTO.h"

@implementation AlipayDTO
-(void)loadDTO:(NSDictionary *)dict
{
    self.ali_public_key = EncodeStringFromDic(dict, @"ali_public_key");
    self.app_id = EncodeStringFromDic(dict, @"app_id");
    self.notify_url = EncodeStringFromDic(dict, @"notify_url");
    self.partner = EncodeStringFromDic(dict, @"partner");
    self.private_key = EncodeStringFromDic(dict, @"private_key");


}
@end
