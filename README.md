MHYahooParallaxView
===================

Parallax implementation control library inspired by Yahoo Weather and News Digest :)

## Screenshots

#### Default

	- (UIImage*) parallaxView:(MHYahooParallaxView *)parallaxView imageForIndex:(NSInteger)index;


![Preview](http://iamkel.s3.amazonaws.com/github/MHParallaxIntro.gif)
![Preview](http://iamkel.s3.amazonaws.com/github/MHParallax.gif)



#### Custom ImageView Screenshot (Tsekot.net app - prototype)

	- (MHYahooParallaxViewCell*) parallaxView:(MHYahooParallaxView *)parallaxView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
	- (BOOL) shouldUseCustomCell; // Must return YES if using custom (the default value is NO)

![Preview](http://iamkel.s3.amazonaws.com/github/Tsekot.gif)

Designed and developed by [michaelhenry](https://github.com/michaelhenry)

## How to use
### Setup
	
	MHYahooParallaxView * parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f,0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    [parallaxView registerClass:[MHTsekotCell class] forCellWithReuseIdentifier:[MHTsekotCell reuseIdentifier]];
    parallaxView.delegate = self;
    parallaxView.datasource = self;
    [self.view addSubview:parallaxView];

### Datasource
	
	@required

	- (NSInteger) numberOfRowsInParallaxView: (MHYahooParallaxView *)parallaxView;
	- (UICollectionViewCell*) parallaxView:(MHYahooParallaxView *)parallaxView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

	
### Delegate

	@optional
	- (void) parallaxViewDidScrollHorizontally:(MHYahooParallaxView *)parallaxView leftIndex:(NSInteger) leftIndex leftImageLeftMargin:(CGFloat) leftImageLeftMargin leftImageWidth:(CGFloat)leftImageWidth rightIndex:(NSInteger)rightIndex rightImageLeftMargin:(CGFloat)rightImageLeftMargin rightImageWidth:(CGFloat) rightImageWidth;

	- (void) parallaxViewDidScrollVertically:(MHYahooParallaxView *)parallaxView topIndex:(NSInteger) topIndex topImageTopMargin:(CGFloat) topImageTopMargin topImageHeight:(CGFloat)topImageHeight bottomIndex:(NSInteger)bottomIndex bottomImageTopMargin:(CGFloat)bottomImageTopMargin bottomImageHeight:(CGFloat) bottomImageHeight;


## Example 
	
The project has 2 targets that use as demo.

-  Demo for News Digest (Tsekot.net Prototype app)
-  Demo for Yahoo Weather




Please let me know if you have any questions. 

Cheers,  
[Michael Henry Pantaleon](http://www.iamkel.net)

Twitter: [@michaelhenry119](https://twitter.com/michaelhenry119)

Linked in: [ken119](http://ph.linkedin.com/in/ken119)

http://www.iamkel.net



## Licensing

Copyright (c) 2014 Michael Henry Pantaleon (http://www.iamkel.net). All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
