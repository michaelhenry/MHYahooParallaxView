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

#import "ViewController.h"
#import "MHYahooParallaxView.h"
@interface ViewController ()<MHYahooParallaxViewDatasource>


@property (strong, nonatomic) MHYahooParallaxView *parallaxView;

@end

@implementation ViewController
@synthesize parallaxView = _parallaxView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) loadView {
    [super loadView];
    _parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    _parallaxView.parallaxViewType = MHYahooParallaxViewTypeHorizontal;
    _parallaxView.datasource = self;
    _parallaxView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_parallaxView];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSInteger) numberOfRows:(MHYahooParallaxView *)parallaxView {
    return 5;
}

- (UIImage*)parallaxView:(MHYahooParallaxView *)parallaxView imageForIndex:(NSInteger)index {
    return [UIImage imageNamed:[NSString stringWithFormat:@"%i.jpg",index ]];
}

@end
