//
//  ViewController.m
//  SimpleHorizontal
//
//  Created by Michael Henry Pantaleon on 2/08/2014.
//  Copyright (c) 2014 Michael Henry Pantaleon. All rights reserved.
//

#import "ViewController.h"
#import "MHYahooParallaxView.h"
@interface ViewController ()<MHYahooParallaxViewDatasource,MHYahooParallaxViewDelegate>
{
    MHYahooParallaxView * _parallaxView;
}
@end

@implementation ViewController

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
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MHYahooParallaxView Datasource & Delegate
- (NSInteger) numberOfRows:(MHYahooParallaxView *)parallaxView {
    return 5;
}

- (UIImage*)parallaxView:(MHYahooParallaxView *)parallaxView imageForIndex:(NSInteger)index {
    return [UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",index ]];
}

@end
