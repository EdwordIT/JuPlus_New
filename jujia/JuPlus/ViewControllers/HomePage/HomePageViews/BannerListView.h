//
//  BannerListView.h
//  JuPlus
//
//  Created by admin on 15/10/16.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "JuPlusUIView.h"

@interface BannerListView : JuPlusUIView<UIScrollViewDelegate>
@property (nonatomic,strong)UIScrollView *bannerScroll;
@property (nonatomic,strong)UIPageControl *pageControl;
-(void)startRequestBannerList;
@end
