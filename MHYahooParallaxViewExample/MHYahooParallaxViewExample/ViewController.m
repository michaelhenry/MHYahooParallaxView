//
// MHYahooParallaxView
// iamkel.net
//
//  Created by Michael Henry Pantaleon on 18/07/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//
// Version 1.0
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "ViewController.h"
#import "MHYahooParallaxView.h"

#define IMAGE_VIEW_TAG 100
#define IMAGE_SCROLL_VIEW_TAG 101

@interface ViewController ()<MHYahooParallaxViewDatasource,MHYahooParallaxViewDelegate,UITableViewDataSource,UITableViewDelegate>


@property (strong, nonatomic) MHYahooParallaxView *parallaxView;

@end


@interface SampleCell : MHYahooParallaxViewCell<UITableViewDelegate> {
    BOOL _mustDisableParent;
}
@property (nonatomic,strong) UITableView * tableView;

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString*)reuseIdentifier withDataSource:(id<UITableViewDataSource>) datasource withDelegate:(id<UITableViewDelegate> ) delegate ;
@end


@implementation SampleCell
@synthesize tableView = _tableView;

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString*)reuseIdentifier withDataSource:(id<UITableViewDataSource>) datasource withDelegate:(id<UITableViewDelegate> ) delegate {
    self = [super initWithReuseIdentifier:reuseIdentifier withType:MHYahooParallaxViewCellTypeHorizontalCustom];
    if(self) {
        _tableView = [[UITableView alloc]initWithFrame:frame style:UITableViewStylePlain];
        [self.contentView addSubview:_tableView];
        _tableView.dataSource = datasource;
        _tableView.delegate = delegate;
    }
    return self;
}


- (void) layoutSubviews {
    [super layoutSubviews];

}



@end


@implementation ViewController
@synthesize parallaxView = _parallaxView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) loadView {
    [super loadView];
    _parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    _parallaxView.parallaxViewType = MHYahooParallaxViewTypeHorizontal;
    _parallaxView.datasource = self;
    _parallaxView.delegate = self;
    _parallaxView.backgroundColor = [UIColor blackColor];

    [self.view addSubview:_parallaxView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (BOOL)shouldUseCustomCell {
    return YES;
}

- (NSInteger) numberOfRows:(MHYahooParallaxView *)parallaxView {
    return 5;
}

- (void)parallaxViewDidScrollHorizontally:(MHYahooParallaxView *)parallaxView leftIndex:(NSInteger)leftIndex leftImageLeftMargin:(CGFloat)leftImageLeftMargin leftImageWidth:(CGFloat)leftImageWidth rightIndex:(NSInteger)rightIndex rightImageLeftMargin:(CGFloat)rightImageLeftMargin rightImageWidth:(CGFloat)rightImageWidth  {

    if(leftIndex >= 0){
        MHYahooParallaxViewCell * leftCell = [parallaxView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:leftIndex inSection:0]];
        UIImageView *iv = (UIImageView*)[leftCell viewWithTag:IMAGE_VIEW_TAG];
        CGRect frame = iv.frame;
        frame.origin.x = leftImageLeftMargin;
        frame.size.width = leftImageWidth;
        iv.frame = frame;
    }
    if(rightIndex >= 0){
        MHYahooParallaxViewCell * rigthCell = [parallaxView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:rightIndex inSection:0]];
        UIImageView *iv = (UIImageView*)[rigthCell viewWithTag:IMAGE_VIEW_TAG];
        CGRect frame = iv.frame;
        frame.origin.x = rightImageLeftMargin;
        frame.size.width = rightImageWidth;
        iv.frame = frame;

    }
}
- (MHYahooParallaxViewCell *)parallaxView:(MHYahooParallaxView *)parallaxView cellForRowAtIndexPath:(NSIndexPath *)indexPath  {
    static NSString * cellID = @"custom";
    SampleCell * cell = (SampleCell*)[parallaxView dequeueReusableCellWithIdentifier:cellID];
    if(!cell)  {
        cell = [[SampleCell alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)  reuseIdentifier:cellID withDataSource:self withDelegate:self];
    }

    cell.tableView.tag = indexPath.row;
    [cell.tableView reloadData];
    [cell.tableView setContentOffset:CGPointMake(0.0f, 0.0f)];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (CGFloat ) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if(indexPath.row == 0) {
        return 320.0f;
    }
    return 44.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    if(indexPath.row == 0){
        static NSString * headerId = @"headerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:headerId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:headerId];
            cell.backgroundColor = [UIColor clearColor];

            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, cell.contentView.frame.size.width, 320.0f)];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.tag = IMAGE_VIEW_TAG;
            imageView.clipsToBounds = YES;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
            UIScrollView * svImage = [[UIScrollView alloc]initWithFrame:imageView.frame];
            svImage.delegate = self;
            svImage.userInteractionEnabled = NO;
            [svImage addSubview:imageView];

            svImage.tag = IMAGE_SCROLL_VIEW_TAG;
            svImage.minimumZoomScale = 1.0f;
            svImage.maximumZoomScale = 2.0f;
            
            [cell.contentView addSubview:svImage];
        }

        UIImageView *imageView = (UIImageView*)[cell viewWithTag:IMAGE_VIEW_TAG];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",tableView.tag]];
    } else {
        static NSString * detailId = @"detailCell";
        cell = [tableView dequeueReusableCellWithIdentifier:detailId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailId];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"UITableViewCell -> Row %i",indexPath.row];
        cell.detailTextLabel.text = @"iamkel.net";
    }

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.tag == IMAGE_SCROLL_VIEW_TAG) return;
    UITableView * tv = (UITableView*) scrollView;
    UITableViewCell * cell = [tv cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    UIScrollView * svImage = (UIScrollView*)[cell viewWithTag:IMAGE_SCROLL_VIEW_TAG];
    CGRect frame = svImage.frame;
    frame.size.height =  abs(320-tv.contentOffset.y);
    frame.origin.y = tv.contentOffset.y;
    svImage.frame = frame;
    svImage.zoomScale = 1 + (abs(MIN(tv.contentOffset.y,0))/320.0f);

}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:IMAGE_VIEW_TAG];
}

@end
