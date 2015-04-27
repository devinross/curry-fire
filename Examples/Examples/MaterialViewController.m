//
//  MaterialViewController.m
//  Created by Devin Ross on 12/22/14.
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

#import "MaterialViewController.h"

@interface MaterialViewController ()

@property (nonatomic,assign) BOOL flipper;

@end

@implementation MaterialViewController


- (void) loadView{
	[super loadView];

    self.view.backgroundColor = [UIColor whiteColor];
    
    self.containerView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.containerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.containerView];
    
    self.dotView = [[UIView alloc] initWithFrame:CGRectCenteredXInRect(self.view.bounds, self.view.height - 90, 60, 60) backgroundColor:[UIColor blackColor] cornerRadius:30];
    self.dotView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self.view addSubview:self.dotView];
    [self.dotView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDot:)]];
    
    [self.dotView addSubview:[UIView viewWithFrame:CGRectCenteredInRect(self.dotView.bounds, 2, 16) backgroundColor:[UIColor whiteColor]]];
    [self.dotView addSubview:[UIView viewWithFrame:CGRectCenteredInRect(self.dotView.bounds, 16, 2) backgroundColor:[UIColor whiteColor]]];

    self.gridView = [[UIView alloc] initWithFrame:self.view.bounds];
    self.gridView.backgroundColor = [UIColor blackColor];
    self.gridView.alpha = 0;
    [self.containerView addSubview:self.gridView];
    
    
    
    self.flipper = YES;
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
	[super touchesBegan:touches withEvent:event];
	
	UITouch *touch = [touches anyObject];
	CGPoint p = [touch locationInView:self.view];
	
	
	self.flipper = !self.flipper;
	[self.view fireMaterialTouchDiskAtPoint:p];

	
}

- (void) tapDot:(UITapGestureRecognizer*)gesture{

	if(self.gridView.alpha == 1){
        
        [self.view materialTransitionWithSubview:self.containerView expandCircle:NO atPoint:self.dotView.center duration:0.5 changes:^{
            self.gridView.alpha = 0;
        } completion:nil];

        
        [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.3 options:0 animations:^{
            self.dotView.transform = CGAffineTransformIdentity;
        } completion:nil];

	}else{

		[self.view materialTransitionWithSubview:self.containerView expandCircle:YES atPoint:self.dotView.center duration:0.5 changes:^{
            
            self.gridView.alpha = 1;

			CGRect frame = self.gridView.frame;
			frame.origin.y = 400;
			self.gridView.frame = frame;
			frame.origin.y = 0;

			[UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:0.3 options:0 animations:^{
				self.gridView.frame = frame;
			} completion:nil];
            
            
            [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.4 initialSpringVelocity:0.3 options:0 animations:^{
                self.dotView.transform = CGRotate(45 * M_PI / 180.0f);
            } completion:nil];

		} completion:nil];


	}


}

@end
