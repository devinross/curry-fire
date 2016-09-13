//
//  PageControlViewController.m
//  Created by Devin Ross on 3/27/16.
//
/*
 
 curryfire || https://github.com/devinross/curry-fire
 
 Permission is hereby granted, free of charge, to any person
 obtaining a copy of this software and associated documentation
 files (the "Software"), to deal in the Software without
 restriction, including without limitation the rights to use,
 copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the
 Software is furnished to do so, subject to the following
 conditions:
 
 The above copyright notice and this permission notice shall be
 included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 OTHER DEALINGS IN THE SOFTWARE.
 
 */

#import "PageControlViewController.h"

@interface PageControlViewController ()

@end

@implementation PageControlViewController

- (void) loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.pageControl = [[TKPageControl alloc] initWithFrame:CGRectMake(0, 180, self.view.width, 40)];
	self.pageControl.numberOfPages = 5;
	self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
	self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.3];
	[self.view addSubview:self.pageControl];
	
}

@end
