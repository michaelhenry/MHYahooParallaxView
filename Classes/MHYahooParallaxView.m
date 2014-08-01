//
// MHYahooParallaxView
// iamkel.net
//
//  Created by Michael Henry Pantaleon on 18/07/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//
// Version 1.0.1
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


#import "MHYahooParallaxView.h"

@interface MHYahooParallaxView()<UITableViewDataSource,UITableViewDelegate> {
    CGFloat _width;
    CGFloat _height;
    CGFloat _parallaxTableViewHeight;
    NSInteger _dataCount;
    CGFloat _pageDivisor;
    NSInteger _currentPhotoIndex;
}

@property (nonatomic, strong) UITableView * parallaxTableView;

@end


@implementation MHYahooParallaxViewCell
@synthesize parallaxBackgroundImageView = _parallaxBackgroundImageView;
@synthesize parallaxCellType = _parallaxCellType;

- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier withType:(MHYahooParallaxViewCellType)parallaxCellType {
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        _parallaxCellType = parallaxCellType;
        if(_parallaxCellType == MHYahooParallaxViewCellTypeHorizontalDefault | _parallaxCellType ==  MHYahooParallaxViewCellTypeVerticalDefault) {
            _parallaxBackgroundImageView = [[UIImageView alloc]init];
            [self.contentView addSubview:_parallaxBackgroundImageView];
        }
        if(_parallaxCellType == MHYahooParallaxViewCellTypeHorizontalDefault | _parallaxCellType ==  MHYahooParallaxViewCellTypeHorizontalCustom) {
            self.transform = CGAffineTransformMakeRotation(M_PI_2);
        }
      
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if(_parallaxCellType == MHYahooParallaxViewCellTypeHorizontalDefault | _parallaxCellType ==  MHYahooParallaxViewCellTypeVerticalDefault) {
        _parallaxBackgroundImageView.clipsToBounds = YES;
        _parallaxBackgroundImageView.contentMode = UIViewContentModeCenter;
        _parallaxBackgroundImageView.frame = CGRectMake(0.0f, 0.0f, self.contentView.frame.size.width, self.contentView.frame.size.height);
    }

    self.contentView.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
}


- (void) dealloc {
    _parallaxBackgroundImageView = nil;
}

@end

@implementation MHYahooParallaxView
@synthesize parallaxViewType = _parallaxViewType;
@synthesize parallaxTableView=_parallaxTableView;
@synthesize datasource = _datasource;

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame withViewType:MHYahooParallaxViewTypeHorizontal];
}

- (id)initWithFrame:(CGRect)frame withViewType:(MHYahooParallaxViewType) viewType;
{
    self = [super initWithFrame:frame];
    if (self) {
        _parallaxTableView = [[UITableView alloc]init];
        _parallaxTableView.dataSource = self;
        _parallaxTableView.delegate = self;
        _parallaxViewType = viewType;
        [self addSubview:_parallaxTableView];
    }
    return self;
}



- (void) layoutSubviews {

    [super layoutSubviews];

    _width = self.frame.size.width;
    _height = self.frame.size.height;
    _parallaxTableViewHeight = _height;
    _pageDivisor = _height;
    if(_parallaxViewType == MHYahooParallaxViewTypeHorizontal) {
        _parallaxTableView.transform = CGAffineTransformMakeRotation(-M_PI_2);
        _parallaxTableViewHeight = _width;
        _pageDivisor = _width;
    }

    _parallaxTableView.frame = CGRectMake(0.0f, 0.0f, _width, _height);
    _parallaxTableView.pagingEnabled = YES;
    _parallaxTableView.showsHorizontalScrollIndicator = NO;
    _parallaxTableView.showsVerticalScrollIndicator = NO;
    _parallaxTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _parallaxTableView.backgroundColor = self.backgroundColor;
    _parallaxTableView.canCancelContentTouches = YES;
    _parallaxTableView.delaysContentTouches = YES;

}

#pragma mark - Tableview delegate and datasource
- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if([_datasource respondsToSelector:@selector(numberOfRows:)]) {
        _dataCount =  [_datasource numberOfRows:self];

    }
    return _dataCount;
}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return _parallaxTableViewHeight;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHYahooParallaxViewCell * cell;

    BOOL shouldUseCustomCell = NO;

    if([_datasource respondsToSelector:@selector(shouldUseCustomCell)]) {
        shouldUseCustomCell = [_datasource shouldUseCustomCell];
    }

    if(shouldUseCustomCell){
        if([_datasource respondsToSelector:@selector(parallaxView:cellForRowAtIndexPath:)]) {
            cell = [_datasource parallaxView:self cellForRowAtIndexPath:indexPath];
        }
    } else {
        static NSString * cellId = @"mhYahooImageParallaxCell";
        cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if(!cell) {
            cell = [[MHYahooParallaxViewCell alloc]initWithReuseIdentifier:cellId withType:_parallaxViewType==MHYahooParallaxViewTypeHorizontal?MHYahooParallaxViewCellTypeHorizontalDefault:MHYahooParallaxViewCellTypeVerticalDefault];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;

        }
        if([_datasource respondsToSelector:@selector(parallaxView:imageForIndex:)]) {
            UIImage * image = [_datasource parallaxView:self imageForIndex:indexPath.row];
            [cell.parallaxBackgroundImageView setImage:image];
        }
    }
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

    _currentPhotoIndex = scrollView.contentOffset.y/_pageDivisor;
    NSInteger leftIndex = -1;
    NSInteger rightIndex = -1;
    MHYahooParallaxViewCell * leftCell;
    MHYahooParallaxViewCell * rightCell;


    BOOL shouldUseCustomCell = NO;

    if([_datasource respondsToSelector:@selector(shouldUseCustomCell)]) {
        shouldUseCustomCell = [_datasource shouldUseCustomCell];
    }


        leftIndex = _currentPhotoIndex;

        if(!shouldUseCustomCell)
        leftCell = (MHYahooParallaxViewCell*)[_parallaxTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:leftIndex inSection:0]];


        if(_currentPhotoIndex < (_dataCount - 1)) {
            rightIndex = _currentPhotoIndex + 1;

            if(!shouldUseCustomCell)
            rightCell = (MHYahooParallaxViewCell*)[_parallaxTableView cellForRowAtIndexPath:[NSIndexPath indexPathForItem:rightIndex inSection:0]];
        }


    if(_parallaxViewType == MHYahooParallaxViewTypeHorizontal){
        CGFloat top = 0.0f;
        CGFloat leftImageMargingLeft = scrollView.contentOffset.y>0?((fmod(scrollView.contentOffset.y + _width,_width))):0.0f;
        CGFloat leftImageWidth = _width - (fmod(abs(scrollView.contentOffset.y),_width));
        CGFloat rightImageMarginLeft = 0.0f;
        CGFloat rightImageWidth = leftImageMargingLeft;

        if([_delegate respondsToSelector:(@selector(parallaxViewDidScrollHorizontally:leftIndex:leftImageLeftMargin:leftImageWidth:rightIndex:rightImageLeftMargin:rightImageWidth:))]) {
            [_delegate parallaxViewDidScrollHorizontally:self leftIndex:leftIndex leftImageLeftMargin:leftImageMargingLeft leftImageWidth:leftImageWidth rightIndex:rightIndex rightImageLeftMargin:rightImageMarginLeft rightImageWidth:rightImageWidth];
        }

        if(leftCell)
            leftCell.parallaxBackgroundImageView.frame = CGRectMake(leftImageMargingLeft, top, leftImageWidth, _height);

        if(rightCell)
            rightCell.parallaxBackgroundImageView.frame = CGRectMake(rightImageMarginLeft, top, rightImageWidth , _height);

    }else {
        CGFloat left = 0.0f;
        CGFloat firstTop = scrollView.contentOffset.y>0?((fmod(scrollView.contentOffset.y + _height,_height))):0.0f;
        CGFloat firstHeight = _height - (fmod(abs(scrollView.contentOffset.y) ,_height));
        CGFloat secondTop = 0.0f;
        CGFloat secondHeight = firstTop;

        if(leftCell)
            leftCell.parallaxBackgroundImageView.frame = CGRectMake(left, firstTop, _width, firstHeight);

        if(rightCell)
            rightCell.parallaxBackgroundImageView.frame = CGRectMake(left, secondTop, _width , secondHeight);

    }
}

- (MHYahooParallaxViewCell*) cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (MHYahooParallaxViewCell*)[_parallaxTableView cellForRowAtIndexPath:indexPath];
}

- (MHYahooParallaxViewCell*) dequeueReusableCellWithIdentifier:(NSString *)cellIdentifier {
    return [_parallaxTableView dequeueReusableCellWithIdentifier:cellIdentifier];
}

- (void) dealloc {
    _parallaxTableView = nil;
    _datasource = nil;
    _delegate = nil;
}


@end
