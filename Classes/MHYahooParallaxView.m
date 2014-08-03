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
#import "MHYahooParallaxCollectionViewLayout.h"
@implementation MHYahooParallaxView
@synthesize parallaxCollectionView = _parallaxCollectionView;
@synthesize delegate = _delegate;
@synthesize datasource = _datasource;
@synthesize parallaxViewType = _parallaxViewType;

- (id)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame withViewType:MHYahooParallaxViewTypeHorizontal];
}

- (id)initWithFrame:(CGRect)frame withViewType:(MHYahooParallaxViewType) viewType{
    self = [super initWithFrame:frame];
    if (self) {
        MHYahooParallaxCollectionViewLayout *layout = [[MHYahooParallaxCollectionViewLayout alloc]init];
        _parallaxCollectionView = [[UICollectionView alloc]initWithFrame:frame collectionViewLayout:layout];
        _parallaxCollectionView.delegate = self;
        _parallaxCollectionView.dataSource = self;
        _parallaxCollectionView.pagingEnabled = YES;

        _parallaxViewType = viewType;

        [self addSubview:_parallaxCollectionView];
    }
    return self;
}

- (void) layoutSubviews {

    [super layoutSubviews];
    _width = self.frame.size.width;
    _height = self.frame.size.height;

        
}

- (void) registerClass:(__unsafe_unretained Class) cellClass forCellWithReuseIdentifier:(NSString *) reuseIdentifier {
    [_parallaxCollectionView registerClass:cellClass forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSInteger) numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if([_datasource respondsToSelector:@selector(numberOfRowsInParallaxView:)]) {
        _dataCount = [_datasource numberOfRowsInParallaxView:self];
    }
    return _dataCount;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell * cell;
    if([_datasource respondsToSelector:@selector(parallaxView:cellForRowAtIndexPath:)]) {
        cell = [_datasource parallaxView:self cellForRowAtIndexPath:indexPath];
    }
    return cell;
}

- (UICollectionViewCell*) cellForItemAtIndexPath:(NSIndexPath*)indexPath {
    return [_parallaxCollectionView cellForItemAtIndexPath:indexPath];
}

- (UICollectionViewCell*) dequeueReusableCellWithReuseIdentifier:(NSString *) reuseIdentifier forIndexPath:(NSIndexPath*)indexPath {
    return [_parallaxCollectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    _currentPageIndex = scrollView.contentOffset.x/_width;


    if(_parallaxViewType == MHYahooParallaxViewTypeHorizontal){

        NSInteger leftIndex = -1;
        NSInteger rightIndex = -1;

        leftIndex = _currentPageIndex;

        if(_currentPageIndex < (_dataCount - 1)) {
            rightIndex = leftIndex + 1;
        }

        
        CGFloat leftImageMargingLeft = scrollView.contentOffset.x>0?((fmod(scrollView.contentOffset.x + _width,_width))):0.0f;
        CGFloat leftImageWidth = _width - (fmod(abs(scrollView.contentOffset.x),_width));
        CGFloat rightImageMarginLeft = 0.0f;
        CGFloat rightImageWidth = leftImageMargingLeft;

        if([_delegate respondsToSelector:(@selector(parallaxViewDidScrollHorizontally:leftIndex:leftImageLeftMargin:leftImageWidth:rightIndex:rightImageLeftMargin:rightImageWidth:))]) {
            [_delegate parallaxViewDidScrollHorizontally:self leftIndex:leftIndex leftImageLeftMargin:leftImageMargingLeft leftImageWidth:leftImageWidth rightIndex:rightIndex rightImageLeftMargin:rightImageMarginLeft rightImageWidth:rightImageWidth];
        }

    }else {

        NSInteger topIndex = -1;
        NSInteger bottomIndex = -1;

        topIndex = _currentPageIndex;

        if(_currentPageIndex < (_dataCount - 1)) {
            bottomIndex = topIndex + 1;
        }

        CGFloat topImageTopMargin = scrollView.contentOffset.y>0?((fmod(scrollView.contentOffset.y + _height,_height))):0.0f;
        CGFloat topImageHeight = _height - (fmod(abs(scrollView.contentOffset.y) ,_height));
        CGFloat bottomImageTopMargin = 0.0f;
        CGFloat bottomImageHeight = topImageTopMargin;

        if([_delegate respondsToSelector:@selector(parallaxViewDidScrollVertically:topIndex:topImageTopMargin:topImageHeight:bottomIndex:bottomImageTopMargin:bottomImageHeight:)]) {

            [_delegate parallaxViewDidScrollVertically:self topIndex:topIndex topImageTopMargin:topImageTopMargin topImageHeight:topImageHeight bottomIndex:bottomIndex bottomImageTopMargin:bottomImageTopMargin bottomImageHeight:bottomImageHeight];
        }
    }
}

- (void) dealloc {
    _parallaxCollectionView = nil;
}
@end
