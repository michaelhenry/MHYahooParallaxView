//
//  MHYahooWeatherParallaxCell.m
//  CollectViewTest
//
//  Created by Michael Henry Pantaleon on 4/08/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//

#import "MHYahooWeatherParallaxCell.h"

@implementation MHYahooWeatherParallaxCell
@synthesize parallaxImageView = _parallaxImageView;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _parallaxImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height)];
        _parallaxImageView.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:_parallaxImageView];
    }
    return self;
}

- (void) layoutSubviews {
    _parallaxImageView.clipsToBounds = YES;
    _parallaxImageView.frame = CGRectMake(0.0f, 0.0f, self.contentView.frame.size.width, self.contentView.frame.size.height);

}

+ (NSString*)reuseIdentifier {
    return NSStringFromClass([MHYahooWeatherParallaxCell class]);
}
@end
