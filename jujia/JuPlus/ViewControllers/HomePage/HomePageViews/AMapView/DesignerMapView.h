//
//  DesignerMapView.h
//  JuPlus
//
//  Created by admin on 15/8/25.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import <MAMapKit/MAMapKit.h>
#import "DesignerAnno.h"
@interface DesignerMapView : JuPlusUIView

-(id)initWithFrame:(CGRect)frame;

-(void)startRequest;
@end
