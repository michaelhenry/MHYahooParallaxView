//
//  ViewController.m
//  CollectViewTest
//
//  Created by Michael Henry Pantaleon on 2/08/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//

#define IMAGE_VIEW_TAG 100
#define IMAGE_SCROLL_VIEW_TAG 101
#define CONTENT_IMAGE_VIEW_TAG 102

#import "ViewController.h"
#import "MHYahooParallaxView.h"
#import "MHTsekotCell.h"

@interface ViewController ()<MHYahooParallaxViewDatasource,MHYahooParallaxViewDelegate,UITableViewDelegate,UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    _imageHeaderHeight = self.view.frame.size.height * 0.70f;

    MHYahooParallaxView * parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f,0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [parallaxView registerClass:[MHTsekotCell class] forCellWithReuseIdentifier:[MHTsekotCell reuseIdentifier]];
    parallaxView.delegate = self;
    parallaxView.datasource = self;
    [self.view addSubview:parallaxView];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UICollectionViewCell*) parallaxView:(MHYahooParallaxView *)parallaxView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHTsekotCell * tsekotCell = (MHTsekotCell*)[parallaxView dequeueReusableCellWithReuseIdentifier:[MHTsekotCell reuseIdentifier] forIndexPath:indexPath];
    tsekotCell.delegate = self;
    tsekotCell.datasource = self;
    tsekotCell.tsekotTableView.tag = indexPath.row;
    tsekotCell.tsekotTableView.contentOffset = CGPointMake(0.0f, 0.0f);
    [tsekotCell.tsekotTableView reloadData];

    return tsekotCell;
}


- (NSInteger) numberOfRowsInParallaxView:(MHYahooParallaxView *)parallaxView {
    return 10;
}

- (void)parallaxViewDidScrollHorizontally:(MHYahooParallaxView *)parallaxView leftIndex:(NSInteger)leftIndex leftImageLeftMargin:(CGFloat)leftImageLeftMargin leftImageWidth:(CGFloat)leftImageWidth rightIndex:(NSInteger)rightIndex rightImageLeftMargin:(CGFloat)rightImageLeftMargin rightImageWidth:(CGFloat)rightImageWidth {

    // leftIndex and Right Index should must be greater than or equal to zero

    if(leftIndex >= 0){
        MHTsekotCell * leftCell = (MHTsekotCell*)[parallaxView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:leftIndex inSection:0]];
        UITableViewCell * tvCell = [leftCell.tsekotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];

        UIImageView *iv = (UIImageView*)[tvCell viewWithTag:100];
        CGRect frame = iv.frame;
        frame.origin.x = leftImageLeftMargin;
        frame.size.width = leftImageWidth;
        iv.frame = frame;
    }
    if(rightIndex >= 0){
        MHTsekotCell * rigthCell = (MHTsekotCell*)[parallaxView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:rightIndex inSection:0]];
        UITableViewCell * tvCell = [rigthCell.tsekotTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];

        UIImageView *iv = (UIImageView*)[tvCell viewWithTag:100];
        CGRect frame = iv.frame;
        frame.origin.x = rightImageLeftMargin;
        frame.size.width = rightImageWidth;
        iv.frame = frame;

    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if(indexPath.row == 0) {
        return _imageHeaderHeight;
    }
    return 568.0f;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell;
    if(indexPath.row == 0){
        static NSString * headerId = @"headerCell";
        cell = [tableView dequeueReusableCellWithIdentifier:headerId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:headerId];
            cell.backgroundColor = [UIColor clearColor];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, cell.contentView.frame.size.width,_imageHeaderHeight)];
            imageView.contentMode = UIViewContentModeCenter;
            imageView.tag = IMAGE_VIEW_TAG;
            imageView.clipsToBounds = YES;
            imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
            UIScrollView * svImage = [[UIScrollView alloc]initWithFrame:imageView.frame];
            svImage.delegate = self;
            svImage.userInteractionEnabled = NO;

            [svImage addSubview:imageView];

            svImage.tag = IMAGE_SCROLL_VIEW_TAG;
            svImage.backgroundColor = [UIColor blackColor];
            svImage.zoomScale = 1.0f;
            svImage.minimumZoomScale = 1.0f;
            svImage.maximumZoomScale = 2.0f;
            [cell.contentView addSubview:svImage];
            UIImageView * headerInfo = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"header_bg"]];

            [cell.contentView addSubview:headerInfo];

            CGRect headerFrame = headerInfo.frame;
            headerFrame.size.height = 149.0f;
            headerFrame.origin.y = _imageHeaderHeight - 149.0f;
            headerInfo.frame = headerFrame;

        }

        UIImageView *imageView = (UIImageView*)[cell viewWithTag:IMAGE_VIEW_TAG];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"subaru-%i.jpg",tableView.tag]];
    } else {
        static NSString * detailId = @"detailCell";
        cell = [tableView dequeueReusableCellWithIdentifier:detailId];
        if(!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:detailId];
            UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, 568.0f)];
            imageView.tag = CONTENT_IMAGE_VIEW_TAG;
            [cell.contentView addSubview:imageView];
        }
        UIImageView *imageView = (UIImageView*)[cell viewWithTag:CONTENT_IMAGE_VIEW_TAG];
        imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"content-%i",(tableView.tag%3) + 1]];
    }

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.tag == IMAGE_SCROLL_VIEW_TAG) return;
    UITableView * tv = (UITableView*) scrollView;
    UITableViewCell * cell = [tv cellForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
    UIScrollView * svImage = (UIScrollView*)[cell viewWithTag:IMAGE_SCROLL_VIEW_TAG];
    CGRect frame = svImage.frame;
    frame.size.height =  MAX((_imageHeaderHeight-tv.contentOffset.y),0);
    frame.origin.y = tv.contentOffset.y;
    svImage.frame = frame;
    svImage.zoomScale = 1 + (abs(MIN(tv.contentOffset.y,0))/320.0f);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return [scrollView viewWithTag:IMAGE_VIEW_TAG];
}


@end
