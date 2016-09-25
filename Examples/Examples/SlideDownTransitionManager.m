//
//  MySettingsTransitionManager.m
//  Created by Devin Ross on 9/23/16.
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

#import "SlideDownTransitionManager.h"

@implementation SlideDownTransitionViewController

- (void) viewDidLoad{
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.slidedownTransitionManager = [[SlideDownTransitionManager alloc] initWithRootViewController:self.navigationController
																								axis:TKMoveGestureAxisY
																							   start:@(self.view.height/2)
																								 end:@(self.view.height*1.5-120)];
	self.slidedownTransitionManager.delegate = self;
	[self.view addGestureRecognizer:self.slidedownTransitionManager.moveGesture];
	
	UILabel *label = [UILabel labelWithFrame:self.view.bounds text:NSLocalizedString(@"Slide down", @"")
										font:[UIFont systemFontOfSize:14]
								   textColor:[UIColor blackColor]
							   textAlignment:NSTextAlignmentCenter];
	
	[self.view addSubview:label];
	
}

- (UIViewController*) viewControllerToPresentForInteractiveMoveTransition:(TKInteractiveMoveTransition *)moveTransition{
	UncoveredViewController *vc = [[UncoveredViewController alloc] init];
	vc.modalPresentationStyle = UIModalPresentationCustom;
	return vc;
}


@end

@implementation UncoveredViewController


- (void) viewDidLoad{
	[super viewDidLoad];
	self.view.backgroundColor = [UIColor lightGrayColor];
	
	
	UILabel *label = [UILabel labelWithFrame:self.view.bounds text:NSLocalizedString(@"Oh hi!", @"")
										font:[UIFont systemFontOfSize:14]
								   textColor:[UIColor blackColor]
							   textAlignment:NSTextAlignmentCenter];
	
	[self.view addSubview:label];
	
}

@end

@implementation SlideDownTransitionManager

- (void) presentAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController{
	toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
	[containerView.superview sendSubviewToBack:containerView];
	[containerView addSubviewToBack:toViewController.view];
	
	[UIView animateWithDuration:1.2 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.1 options:0 animations:^{
		fromViewController.view.minY = containerView.height - 60;
		toViewController.view.minX = 0;
	} completion:^(BOOL finished) {
		[self transitionEnded];
	}];
	
}
- (void) dismissAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController{
	
	[UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:0 animations:^{
		
		toViewController.view.minX = 0;
		fromViewController.view.centerX = 0;
		
	} completion:^(BOOL finished) {
		
		[fromViewController.view removeFromSuperview];
		[self transitionEnded];
		
	}];
	
}

- (void) startPresentInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController{
	toViewController.view.frame = [transitionContext finalFrameForViewController:toViewController];
	[containerView.superview sendSubviewToBack:containerView];
	[containerView addSubviewToBack:toViewController.view];
}
- (void) startDismissInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView toViewController:(UIViewController*)viewController fromViewController:(UIViewController*)fromViewController{
	
}

- (void) completePresentInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController{
	
}
- (void) completeDismissInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)viewController{
	[self.presentingViewController.view removeFromSuperview];
}


@end
