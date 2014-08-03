//
//  MHYahooWeatherParallaxCell.h
//  CollectViewTest
//
//  Created by Michael Henry Pantaleon on 4/08/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MHYahooWeatherParallaxCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView * parallaxImageView;

+ (NSString*) reuseIdentifier;
@end
