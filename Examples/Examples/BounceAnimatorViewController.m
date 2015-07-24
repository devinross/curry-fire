//
//  BounceAnimator.m
//  Created by Devin Ross on 7/23/15.
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

#import "BounceAnimatorViewController.h"

@implementation BounceAnimatorViewController


- (void) loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.block = [UIView viewWithFrame:CGRectCenteredInRect(self.view.bounds, 100, 100) backgroundColor:[UIColor randomColor] cornerRadius:10];
	self.block.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	self.block.layer.shouldRasterize = YES;
	self.block.layer.rasterizationScale = [UIScreen mainScreen].scale;
	[self.view addSubview:self.block];
	
	
	self.bounce = [[TKBounceBehavior alloc] initWithItems:@[self.block]];
	self.bounce.bounceDirection = CGVectorMake(3, 0);
	
	self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
	[self.animator addBehavior:self.bounce];
	
	UIView *myView = self.view;
	[myView addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
		[self.bounce bounce];
	}];
}

@end
