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

#import <UIKit/UIKit.h>

@class MHYahooParallaxView;
@class MHYahooParallaxViewCell;

@protocol MHYahooParallaxViewDatasource <NSObject>

@required

- (NSInteger) numberOfRows: (MHYahooParallaxView *)parallaxView;

@optional
- (UIImage*) parallaxView:(MHYahooParallaxView *)parallaxView imageForIndex:(NSInteger)index;
- (BOOL) shouldUseCustomCell;
- (MHYahooParallaxViewCell*) parallaxView:(MHYahooParallaxView *)parallaxView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol MHYahooParallaxViewDelegate <NSObject>

@optional
- (void) parallaxViewDidScrollHorizontally:(MHYahooParallaxView *)parallaxView leftIndex:(NSInteger) leftIndex leftImageLeftMargin:(CGFloat) leftImageLeftMargin leftImageWidth:(CGFloat)leftImageWidth rightIndex:(NSInteger)rightIndex rightImageLeftMargin:(CGFloat)rightImageLeftMargin rightImageWidth:(CGFloat) rightImageWidth;

@end


typedef enum {
    MHYahooParallaxViewCellTypeHorizontalDefault = 0,
    MHYahooParallaxViewCellTypeHorizontalCustom = 1,
    MHYahooParallaxViewCellTypeVerticalDefault = 2,
    MHYahooParallaxViewCellTypeVerticalCustom = 3

} MHYahooParallaxViewCellType;


typedef enum {
    MHYahooParallaxViewTypeHorizontal = 0,
    MHYahooParallaxViewTypeVertical = 1
} MHYahooParallaxViewType;


@interface MHYahooParallaxViewCell : UITableViewCell

@property (strong, nonatomic) UIImageView * parallaxBackgroundImageView;
@property (nonatomic) MHYahooParallaxViewCellType parallaxCellType;


- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier withType:(MHYahooParallaxViewCellType)parallaxCellType;
@end


@interface MHYahooParallaxView : UIView

@property (nonatomic) MHYahooParallaxViewType parallaxViewType;
@property (nonatomic) id<MHYahooParallaxViewDatasource> datasource;
@property (nonatomic) id<MHYahooParallaxViewDelegate> delegate;

- (MHYahooParallaxViewCell*) dequeueReusableCellWithIdentifier:(NSString*)cellIdentifier;
- (MHYahooParallaxViewCell*) cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
