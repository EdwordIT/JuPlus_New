//
//  ImageScrollView.h
//  JuPlus
//
//  Created by admin on 15/7/10.
//  Copyright (c) 2015年 居+. All rights reserved.
//单品或者套餐详情

#import "JuPlusUIView.h"

@interface ImageScrollView : JuPlusUIView<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *imageScroll;
@property(nonatomic,strong)UIPageControl *pageControl;
@property(nonatomic,strong)UIButton *favBtn;
@property(nonatomic,strong)UILabel *priceLabel;
@end
