//
//  ViewController.m
//  YahooWeatherExample
//
//  Created by Michael Henry Pantaleon on 4/08/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//

#import "ViewController.h"
#import "MHYahooParallaxView.h"
#import "MHYahooWeatherParallaxCell.h"

@interface ViewController ()<MHYahooParallaxViewDatasource,MHYahooParallaxViewDelegate>

@end

@implementation ViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    MHYahooParallaxView * parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f,0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [parallaxView registerClass:[MHYahooWeatherParallaxCell class] forCellWithReuseIdentifier:[MHYahooWeatherParallaxCell reuseIdentifier]];
    parallaxView.delegate = self;
    parallaxView.datasource = self;
    [self.view addSubview:parallaxView];

	// Do any additional setup after loading the view, typically from a nib.
}

- (UICollectionViewCell*) parallaxView:(MHYahooParallaxView *)parallaxView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MHYahooWeatherParallaxCell * ywCell = (MHYahooWeatherParallaxCell*)[parallaxView dequeueReusableCellWithReuseIdentifier:[MHYahooWeatherParallaxCell reuseIdentifier] forIndexPath:indexPath];
    ywCell.parallaxImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",indexPath.row]];
    return ywCell;
}


- (NSInteger) numberOfRowsInParallaxView:(MHYahooParallaxView *)parallaxView {
    return 5;
}

- (void)parallaxViewDidScrollHorizontally:(MHYahooParallaxView *)parallaxView leftIndex:(NSInteger)leftIndex leftImageLeftMargin:(CGFloat)leftImageLeftMargin leftImageWidth:(CGFloat)leftImageWidth rightIndex:(NSInteger)rightIndex rightImageLeftMargin:(CGFloat)rightImageLeftMargin rightImageWidth:(CGFloat)rightImageWidth {

    // leftIndex and Right Index should must be greater than or equal to zero

    if(leftIndex >= 0){
        MHYahooWeatherParallaxCell * leftCell = (MHYahooWeatherParallaxCell*)[parallaxView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:leftIndex inSection:0]];

        CGRect frame = leftCell.parallaxImageView.frame;
        frame.origin.x = leftImageLeftMargin;
        frame.size.width = leftImageWidth;
        leftCell.parallaxImageView.frame = frame;
    }
    if(rightIndex >= 0){
        MHYahooWeatherParallaxCell * rightCell = (MHYahooWeatherParallaxCell*)[parallaxView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:rightIndex inSection:0]];
        CGRect frame = rightCell.parallaxImageView.frame;
        frame.origin.x = rightImageLeftMargin;
        frame.size.width = rightImageWidth;
        rightCell.parallaxImageView.frame = frame;
    }
    
}


@end
