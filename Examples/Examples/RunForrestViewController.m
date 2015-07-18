//
//  RunForrestViewController.m
//  Created by Devin Ross on 4/23/15.
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

#import "RunForrestViewController.h"

@implementation RunForrestViewController

- (instancetype) init{
    if(!(self=[super init])) return nil;
    self.title = NSLocalizedString(@"Run Forrest Run", @"");
    return self;
}


- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
	
	UIView *cardView = [UIView viewWithFrame:CGRectCenteredInRect(self.view.bounds, 100, 100) backgroundColor:[UIColor randomColor] cornerRadius:10];
	cardView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
	[self.view addSubview:cardView];
	self.edgesForExtendedLayout = UIRectEdgeNone;
    
    UIView *move = cardView;
    [cardView addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
        
        [move runForrestRunToPoint:CGPointMake(CGFrameGetWidth(self.view) * 1.5, move.centerY) withCompletion:^(BOOL finished) {
            move.transform = CGAffineTransformIdentity;
            move.center = CGPointMake(CGFrameGetWidth(self.view) * -2, move.centerY);

            [move runForrestRunToPoint:CGPointMake(self.view.centerX, move.centerY) withCompletion:nil];
        }];

    }];
    
}


@end
