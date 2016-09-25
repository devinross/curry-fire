//
//  TKInteractiveMoveTransition.m
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

#import "TKInteractiveMoveTransition.h"
#import "TKMoveGestureRecognizer.h"

@interface TKInteractiveMoveTransition ()

@property (nonatomic,strong) TKMoveGestureRecognizer *moveGesture;

@property (nonatomic,strong) id startLocation;
@property (nonatomic,strong) id endLocation;
@property (nonatomic,assign) TKMoveGestureAxis axis;


@end

@implementation TKInteractiveMoveTransition

- (instancetype) initWithRootViewController:(UIViewController*)rootViewController axis:(TKMoveGestureAxis)axis start:(id)startLocation end:(id)endLocation{
	if(!(self=[super init])) return nil;
	
	self.rootViewController = rootViewController;
	self.startLocation = startLocation;
	self.endLocation = endLocation;
	self.axis = axis;
	

	

	return self;
}


// Called by Root View Controller
- (void) presentViewControllerAnimated:(BOOL)animated complete:(void (^ __nullable)(void))completion{
	self.presentingViewController = [self.delegate viewControllerToPresentForInteractiveMoveTransition:self];
	self.presentingViewController.transitioningDelegate = self;
	self.presentingViewController.modalPresentationStyle = UIModalPresentationCustom;
	[self.rootViewController presentViewController:self.presentingViewController animated:YES completion:completion];
	self.isPresenting = YES;
}
- (void) dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion{
	[self.presentingViewController dismissViewControllerAnimated:YES completion:completion];
	self.isPresenting = NO;
}

#pragma mark UIViewControllerTransitioningDelegate
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
	
	self.transitionContext = transitionContext;
	UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	
	if(toViewController == self.presentingViewController)
		[self presentAnimationTransition:self.transitionContext containerView:[transitionContext containerView] fromViewController:fromViewController toViewController:toViewController];
	else
		[self dismissAnimationTransition:transitionContext containerView:[transitionContext containerView] fromViewController:fromViewController toViewController:toViewController];
}
- (void) presentAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController{
	[self transitionEnded];
}
- (void) dismissAnimationTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController{
	[self transitionEnded];
}


- (void) animationEnded:(BOOL)transitionCompleted {
	
}
- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
	return 0.8;
}
- (void) transitionEnded{
	[self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
	self.transitionContext = nil;
}

- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
	if(presented == self.presentingViewController)
		return self;
	return nil;
}
- (id <UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed{
	if(dismissed == self.presentingViewController)
		return self;
	return nil;
}




#pragma mark UIViewControllerInteractiveTransitioning
- (id <UIViewControllerInteractiveTransitioning>) interactionControllerForDismissal:(id<UIViewControllerAnimatedTransitioning>)animator{
	return self.isInteractive ? self : nil;
}
- (id <UIViewControllerInteractiveTransitioning>) interactionControllerForPresentation:(id<UIViewControllerAnimatedTransitioning>)animator{
	return self.isInteractive ? self : nil;
}

- (void) startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
	
	self.transitionContext = transitionContext;
	UIView *containerView = [transitionContext containerView];
	UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
	UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
	
	if(toViewController == self.presentingViewController){
		[self startPresentInteractiveTransition:self.transitionContext containerView:containerView fromViewController:fromViewController toViewController:toViewController];
	}else{
		[self startDismissInteractiveTransition:self.transitionContext containerView:containerView fromViewController:fromViewController toViewController:toViewController];
	}
	
	
}
- (void) startPresentInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController{

	
}
- (void) startDismissInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)viewController{
	
	
}

- (void) completePresentInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)toViewController{
	
}
- (void) completeDismissInteractiveTransition:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)fromViewController toViewController:(UIViewController*)viewController{
	
}

#pragma mark Properties
- (TKMoveGestureRecognizer*) moveGesture{
	if(_moveGesture) return _moveGesture;
	
	id handler = ^(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location) {
		
		if(gesture.began || gesture.changed){
			
			
			if(!self.presentingViewController){
				self.presentingViewController = [self.delegate viewControllerToPresentForInteractiveMoveTransition:self];
				self.presentingViewController.transitioningDelegate = self;
			}
			
			if(!self.isTransitioning){
				
				if(self.rootViewController.presentedViewController == nil){
					
					[self.rootViewController presentViewController:self.presentingViewController animated:YES completion:nil];
					self.isPresenting = YES;
				}else{
					[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
					self.isPresenting = NO;
				}
				
			}
			
			self.isTransitioning = YES;
			
		}else if(gesture.ended || gesture.cancelled){
			
			BOOL openingUp = NO;
			if(gesture.axis == TKMoveGestureAxisY){
				CGFloat end = [(NSNumber*)self.endLocation floatValue];
				openingUp = end == location.y;
			}else if(gesture.axis == TKMoveGestureAxisX){
				CGFloat end = [(NSNumber*)self.endLocation floatValue];
				openingUp = end == location.x;
			}
			
			
			gesture.snapBackAnimation.completionBlock = ^(POPAnimation *spring, BOOL complete) {
				
				if(complete){
					
					if(self.isPresenting){
						if(!openingUp){
							[self.transitionContext cancelInteractiveTransition];
						}else{
							UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
							UIViewController *fromViewController = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
							[self completePresentInteractiveTransition:self.transitionContext
														 containerView:[self.transitionContext containerView]
													fromViewController:toViewController
													  toViewController:fromViewController];
						}
						[self transitionEnded];
					}else{
						if(openingUp){
							[self.transitionContext cancelInteractiveTransition];
						}else{
			
							UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
							UIViewController *fromViewController = [self.transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
							[self completeDismissInteractiveTransition:self.transitionContext
														 containerView:[self.transitionContext containerView]
													fromViewController:toViewController
													  toViewController:fromViewController];
						}
						[self transitionEnded];
					}

					self.isTransitioning = NO;
				}
				
				
			};
			
		}
		
		
		if(self.gestureBlock)
			self.gestureBlock(gesture,position,location);
		
	};
	
	
	_moveGesture = [TKMoveGestureRecognizer gestureWithAxis:self.axis
												movableView:self.rootViewController.view
												  locations:@[self.startLocation,self.endLocation]
												moveHandler:handler];
	
	
	
	return _moveGesture;
}
- (BOOL) isInteractive{
	return self.moveGesture.began || self.moveGesture.changed;
}


@end
