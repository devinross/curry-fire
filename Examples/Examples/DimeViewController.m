//
//  DimeViewController.m
//  Created by Devin Ross on 7/17/15.
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

#import "DimeViewController.h"

@implementation DimeViewController

- (void) loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	UIView *cardView = [UIView viewWithFrame:CGRectCenteredInRect(self.view.bounds, 100, 100) backgroundColor:[UIColor randomColor] cornerRadius:10];
	cardView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin;
	cardView.centerX = self.view.width + 100;
	[self.view addSubview:cardView];
	
	UIView *move = cardView;
	CGFloat start = self.view.width + 100, end = -100;
	[self.view addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
		
		cardView.centerX = start;
		[move turnOnADimeAtXPoint:self.view.width/2 duration:1 delay:0 completion:^(BOOL finished){
			[move turnOnADimeAtXPoint:end duration:1 delay:0 completion:nil];
		}];
		
	}];
	
}


@end
