//
//  DiagramsView.h
//  JuPlus
//
//  Created by admin on 16/3/16.
//  Copyright © 2016年 居+. All rights reserved.
//
#import "DiagramsDTO.h"
#import <UIKit/UIKit.h>
#import "DiagramsReq.h"
#import "DiagramesRespon.h"
@interface DiagramsView : JuPlusUIView
//图片展示
@property(nonatomic,strong)UIImageView *diagramsImg;
//图片说明
@property(nonatomic,strong)UILabel *textLabel;
//收藏图标
@property(nonatomic,strong)UIButton *favBtn;

@property(nonatomic,strong)NSString *diagramesId;
-(void)ReloadView:(DiagramsDTO *)dto;
@end
