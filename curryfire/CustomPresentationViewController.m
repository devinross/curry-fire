//
//  CustomPresentationViewController.m
//  curryfire
//
//  Created by Devin Ross on 4/23/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "CustomPresentationViewController.h"

@interface CustomPresentationViewController () <UIViewControllerTransitioningDelegate>
@end

@implementation CustomPresentationViewController

- (instancetype) init{
    if(!(self=[super init])) return nil;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    return self;
}



- (void) loadView{
    [super loadView];
    
}


- (void) presentTransistionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)viewController{
    
    
    
}
- (void) dismissTransistionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView toViewController:(UIViewController*)viewController{
    
    
}


- (void) transitionEnded{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
    
    self.transitionContext = nil;

}

#pragma mark UIViewControllerTransitioningDelegate
- (void) animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    self.transitionContext = transitionContext;
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if(toViewController == self)
        [self presentTransistionAnimation:self.transitionContext containerView:[transitionContext containerView] fromViewController:fromViewController];
    else
        [self dismissTransistionAnimation:transitionContext containerView:[transitionContext containerView] toViewController:toViewController];
}


- (void) animationEnded:(BOOL)transitionCompleted {
    TKLog(@"%@",transitionCompleted ? @"GOOD":@"BAD");
}
- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.8;
}

- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
    return self;
}
- (id <UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed{
    return self;
}


@end