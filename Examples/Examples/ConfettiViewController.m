//
//  ConfettiViewController.m
//  Created by Devin Ross on 4/22/15.
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

#import "ConfettiViewController.h"

@implementation ConfettiViewController

- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	self.title = NSLocalizedString(@"Confetti", @"");

	
}
- (void) viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self setupConfettiBlockWithDelay:0];
}

- (void) setupConfettiBlockWithDelay:(NSTimeInterval)delay{
	
	
	UIView *block = [UIView viewWithFrame:CGRectCenteredInRect(self.view.bounds, 100, 100) backgroundColor:[UIColor randomColor] cornerRadius:0];
	block.transform = CGConcat(CGScale(0.001, 0.001), CGRotate(M_PI / 180.0f * 45));
	block.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	[self.view addSubview:block];
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
	__weak UIView *myView = self.view;
	__weak UIView *aBlock = block;
	
	[UIView animateWithDuration:1 delay:delay usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:0 animations:^{
		block.transform = CGAffineTransformIdentity;
		
	} completion:^(BOOL finished) {
		
		[block addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
			[myView bringSubviewToFront:aBlock];
			[aBlock confettiAnimationWithCompletion:^(BOOL complete) {
				[self setupConfettiBlockWithDelay:1.0];
			}];
		}];
		
	}];
	
	

}

@end
