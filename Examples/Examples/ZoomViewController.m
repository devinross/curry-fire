//
//  ZoomViewController.m
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

#import "ZoomViewController.h"

@implementation ZoomViewController

- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.cardView = [UIView viewWithFrame:CGRectCenteredInRect(self.view.bounds, 100, 100) backgroundColor:[UIColor randomColor] cornerRadius:10];
	self.cardView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	[self.view addSubview:self.cardView];
	self.edgesForExtendedLayout = UIRectEdgeNone;
	
    UIView *move = self.cardView;
    [self.cardView addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
        [move zoomToYPoint:-1000 completion:^(BOOL finished) {
            
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC);
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
				move.centerY = self.view.height + 100;
				[UIView animateWithDuration:0.5 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
					move.centerY = self.view.height/2;
				} completion:nil];
            });
        }];
    }];
    
}

@end