//
//  ProductListTab.m
//  JuPlus
//
//  Created by admin on 15/10/23.
//  Copyright © 2015年 居+. All rights reserved.
//

#import "ProductListTab.h"
@implementation ProductListTab

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
 
*/
-(id)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.countArray = [[NSMutableArray alloc]init];
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;

    }
    return self;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellId = @"cellId";
    productOrderDTO *dto = [self.dataArray objectAtIndex:indexPath.row];
    ProductTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell==nil) {
        cell = [[ProductTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        [self.countArray addObject:cell.countV];
    }

    [cell fileCell:dto];
    return cell;
}
-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
        if([indexPath row] == ((NSIndexPath*)[[tableView indexPathsForVisibleRows] lastObject]).row){
            [CommonUtil postNotification:loadTabSuccess Object:nil];
        }
  }

@end
