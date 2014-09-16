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

#import <UIKit/UIKit.h>

@class MHYahooParallaxView;

@protocol MHYahooParallaxViewDatasource <NSObject>

@required

- (NSInteger) numberOfRowsInParallaxView: (MHYahooParallaxView *)parallaxView;
- (UICollectionViewCell*) parallaxView:(MHYahooParallaxView *)parallaxView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MHYahooParallaxViewDelegate <NSObject>

@optional
- (void) parallaxViewDidScrollHorizontally:(MHYahooParallaxView *)parallaxView leftIndex:(NSInteger) leftIndex leftImageLeftMargin:(CGFloat) leftImageLeftMargin leftImageWidth:(CGFloat)leftImageWidth rightIndex:(NSInteger)rightIndex rightImageLeftMargin:(CGFloat)rightImageLeftMargin rightImageWidth:(CGFloat) rightImageWidth;

- (void) parallaxViewDidScrollVertically:(MHYahooParallaxView *)parallaxView topIndex:(NSInteger) topIndex topImageTopMargin:(CGFloat) topImageTopMargin topImageHeight:(CGFloat)topImageHeight bottomIndex:(NSInteger)bottomIndex bottomImageTopMargin:(CGFloat)bottomImageTopMargin bottomImageHeight:(CGFloat) bottomImageHeight;

@end

typedef enum {
    MHYahooParallaxViewTypeHorizontal = 0,
    MHYahooParallaxViewTypeVertical = 1
} MHYahooParallaxViewType;


@interface MHYahooParallaxView : UIView<UICollectionViewDelegate,UICollectionViewDataSource> {
    CGFloat _width;
    CGFloat _height;
    CGFloat _pageDivisor;
    NSInteger _dataCount;
    CGFloat _separatorWidth;
}

@property (nonatomic, strong) UICollectionView * parallaxCollectionView;

@property (nonatomic) MHYahooParallaxViewType parallaxViewType;
@property (nonatomic,assign) id<MHYahooParallaxViewDatasource> datasource;
@property (nonatomic,assign) id<MHYahooParallaxViewDelegate> delegate;
@property (nonatomic) NSInteger currentIndex;

- (id)initWithFrame:(CGRect)frame withViewType:(MHYahooParallaxViewType) viewType;

- (void) registerClass:(__unsafe_unretained Class) cellClass forCellWithReuseIdentifier:(NSString *) reuseIdentifier;
- (UICollectionViewCell*) cellForItemAtIndexPath:(NSIndexPath*)indexPath;
- (UICollectionViewCell*) dequeueReusableCellWithReuseIdentifier:(NSString *) reuseIdentifier forIndexPath:(NSIndexPath*)indexPath ;

- (void) setCurrentIndex:(NSInteger)index animated:(BOOL) animated;
@end
