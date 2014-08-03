//
//  MHTsekotCell.m
//  CollectViewTest
//
//  Created by Michael Henry Pantaleon on 4/08/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//

#import "MHTsekotCell.h"

#define IMAGE_SCROLL_VIEW_TAG 100
#define IMAGE_VIEW_TAG 90
#define CONTENT_IMAGE_VIEW_TAG 80

@implementation MHTsekotCell
@synthesize tsekotTableView = _tsekotTableView;
@synthesize datasource = _datasource;
@synthesize delegate = _delegate;
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        _tsekotTableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        [self.contentView addSubview:_tsekotTableView];
    }
    return self;
}

- (void) setDatasource:(id<UITableViewDataSource>)datasource {
    if(_tsekotTableView.dataSource == nil){
        _tsekotTableView.dataSource = datasource;
    }
}

- (void) setDelegate:(id<UITableViewDelegate>)delegate  {
    if(_tsekotTableView.delegate == nil){
        _tsekotTableView.delegate = delegate;
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    _tsekotTableView.frame = CGRectMake(0.0f, 0.0f, self.contentView.frame.size.width, self.contentView.frame.size.height);
    
}

+ (NSString*)reuseIdentifier {
    return NSStringFromClass([MHTsekotCell class]);
}

@end
