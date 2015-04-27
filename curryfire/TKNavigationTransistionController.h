//
//  TKNavigationTransistionController.h
//  curryfire
//
//  Created by Devin Ross on 4/23/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import UIKit;
@class TKNavigationControllerTransitionAnimator;

@interface TKNavigationTransistionController : NSObject <UINavigationControllerDelegate>

+ (TKNavigationTransistionController*) sharedInstance;

- (void) addAnimator:(TKNavigationControllerTransitionAnimator*)animator;
- (id) animatorOfClass:(Class)classType;


@end


@interface TKNavigationControllerTransitionAnimator : NSObject <UIViewControllerInteractiveTransitioning,UIViewControllerAnimatedTransitioning>


@property (nonatomic,readonly) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic,assign) UINavigationControllerOperation navigationOperation;
@property (nonatomic,strong) UIPercentDrivenInteractiveTransition *percentDrivenInteractiveTransition;

@property (nonatomic,assign) BOOL isInteractive;


- (void) completeTransition;


#pragma mark For Subclassing
- (void) pushAnimationFromRootViewController:(UIViewController*)rootViewController toDetailViewController:(UIViewController*)detailViewController containerView:(UIView*)containerView context:(id<UIViewControllerContextTransitioning>)context;
- (void) popAnimationToRootViewController:(UIViewController*)rootViewController fromDetailViewController:(UIViewController*)detailViewController containerView:(UIView*)containerView context:(id<UIViewControllerContextTransitioning>)context;

- (Class) rootViewControllerClass;
- (Class) detailViewControllerClass;
- (NSTimeInterval) transitionDuration;


@end