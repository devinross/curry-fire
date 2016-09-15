//
//  ShimmerLabelViewController.m
//  Created by Devin Ross on 9/15/16.
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

#import "ShimmerLabelViewController.h"

@implementation ShimmerLabelViewController

- (void) loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	
	
	self.shimmerLabel = [[TKShimmerLabel alloc] initWithFrame:CGRectMake(0, 100, self.view.width, 60)];
	
	self.shimmerLabel.text = @"SLIDE TO UNLOCK";
	
	self.shimmerLabel.textColor = [UIColor blueColor];
	
	self.shimmerLabel.textHighlightLayer.locations = @[@0,@0.45,@0.5,@0.55,@1];
	self.shimmerLabel.shimmerDuration = 2.5;
	
	id dark;
	dark = (id)[UIColor colorWithWhite:1 alpha:0.3].CGColor;
	id light;
	light = (id)[UIColor colorWithWhite:1 alpha:1.0f].CGColor;
	

	self.shimmerLabel.textHighlightLayer.colors = @[dark,dark,light,dark,dark];
	
	
	[self.view addSubview:self.shimmerLabel];
}

@end
