//
//  CustomPresentationViewController.h
//  curryfire
//
//  Created by Devin Ross on 4/23/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import <UIKit/UIKit.h>
@import curry;

@interface CustomPresentationViewController : UIViewController <UIViewControllerAnimatedTransitioning>

@property (nonatomic,strong) id<UIViewControllerContextTransitioning> transitionContext;

- (void) presentTransistionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)viewController;

- (void) dismissTransistionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView toViewController:(UIViewController*)viewController;

- (void) transitionEnded;

@end
