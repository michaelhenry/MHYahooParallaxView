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

#import "MHYahooParallaxCollectionViewLayout.h"

@implementation MHYahooParallaxCollectionViewLayout
@synthesize separatorWidth = _separatorWidth;

- (id) init{
    self = [super init];
    if(self) {
        _separatorWidth = 0;
    }
    return self;
}
- (void) prepareLayout {
    CGSize boundSize = self.collectionView.bounds.size;
    boundSize.width = boundSize.width - _separatorWidth;
    _itemSize = boundSize;

}

- (CGSize) collectionViewContentSize {
    NSInteger numberOfItems = [[self collectionView]numberOfItemsInSection:0];
    CGSize cvSize = CGSizeMake((self.collectionView.bounds.size.width * numberOfItems) ,self.collectionView.bounds.size.height);
    return cvSize;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    attributes.size = _itemSize;
    attributes.center =CGPointMake((_separatorWidth * indexPath.row) + (indexPath.row * (self.collectionView.bounds.size.width - _separatorWidth)) + (self.collectionView.bounds.size.width - _separatorWidth)/2, self.collectionView.bounds.size.height/2);
    return attributes;
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSMutableArray * attributes = [NSMutableArray array];
    for (NSInteger i = 0,j = [[self collectionView]numberOfItemsInSection:0]; i < j;i ++){
        NSIndexPath * indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        [attributes addObject:[self layoutAttributesForItemAtIndexPath:indexPath]];
    }
    return attributes;
}

@end
