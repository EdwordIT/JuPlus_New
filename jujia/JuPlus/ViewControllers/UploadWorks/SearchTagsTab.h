//
//  SearchTagsViewController.h
//  JuPlus
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"
#import "LabelDTO.h"
@interface SearchTagsTab : JuPlusUIView

@property (nonatomic,strong)NSString *tagTxt;

@property (nonatomic, strong) UISearchBar *searchBar;

@property (nonatomic,strong) LabelDTO *infoDTO;

@end
