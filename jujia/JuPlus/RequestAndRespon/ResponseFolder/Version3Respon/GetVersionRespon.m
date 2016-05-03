//
//  GetVersionRespon.m
//  JuPlus
//
//  Created by admin on 15/10/14.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "GetVersionRespon.h"

@implementation GetVersionRespon
-(void)unPackJsonValue:(NSDictionary *)dict
{
    NSDictionary *lastVer = [dict objectForKey:@"lastVer"];
    self.idString = EncodeStringFromDic(lastVer, @"id");
    self.plateform = EncodeStringFromDic(lastVer, @"plateform");
    self.internalNo = EncodeStringFromDic(lastVer, @"internalNo");
    self.externalNo = EncodeStringFromDic(lastVer, @"externalNo");
    self.downLink = EncodeStringFromDic(lastVer, @"downLink");
    self.forceUpdate = EncodeStringFromDic(lastVer, @"forceUpdate");
    self.versionInfo = EncodeStringFromDic(lastVer, @"versionInfo");
    self.updateTime = EncodeStringFromDic(lastVer, @"updateTime");
    
}
@end
