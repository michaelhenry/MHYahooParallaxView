//
//  MHTsekotCell.h
//  CollectViewTest
//
//  Created by Michael Henry Pantaleon on 4/08/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHTsekotCell : UICollectionViewCell
@property (nonatomic, strong) UITableView * tsekotTableView;
@property (nonatomic) id<UITableViewDataSource> datasource;
@property (nonatomic) id<UITableViewDelegate> delegate;
+ (NSString*)reuseIdentifier;
@end
