MHYahooParallaxView
===================

Parallax implementation control library inspired by Yahoo Weather and News Digest :)

## Screenshots
![Preview](http://iamkel.s3.amazonaws.com/github/MHParallaxIntro.gif)
![Preview](http://iamkel.s3.amazonaws.com/github/MHParallax.gif)

#### Custom ImageView Screenshot (Tsekot.net app - prototype)

![Preview](http://iamkel.s3.amazonaws.com/github/Tsekot.gif)

Designed by [Kel](http://ph.linkedin.com/in/ken119)

## How to use
### Setup
	
	MHYahooParallaxView _parallaxView = [[MHYahooParallaxView alloc]init];
	_parallaxView = [[MHYahooParallaxView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height)];
    _parallaxView.parallaxViewType = MHYahooParallaxViewTypeHorizontal;
    _parallaxView.datasource = self;
    _parallaxView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:_parallaxView];

### Datasource
	
	- (NSInteger) numberOfRows:(MHYahooParallaxView *)parallaxView;
	- (UIImage*)parallaxView:(MHYahooParallaxView *)parallaxView imageForIndex:(NSInteger)index;

### Parallax Type
	
	typedef enum {
	    MHYahooParallaxViewTypeHorizontal = 0,
	    MHYahooParallaxViewTypeVertical = 1
	} MHYahooParallaxViewType;



Please let me know if you have any questions. 

Cheers,  
[Michael Henry Pantaleon](http://www.iamkel.net)

Twitter: [@michaelhenry119](https://twitter.com/michaelhenry119)

Linked in: [ken119](http://ph.linkedin.com/in/ken119)

http://www.iamkel.net



## Licensing

Copyright (c) 2013 Michael Henry Pantaleon (http://www.iamkel.net). All rights reserved.

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
