//
//  TKInteractiveMoveTransition.h
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

@import UIKit;
#import "TKMoveGestureRecognizer.h"

@class TKInteractiveMoveTransition;

@protocol TKInteractiveMoveTransitionDelegate <NSObject>

@required
- (UIViewController * _Nonnull) viewControllerToPresentForInteractiveMoveTransition:(TKInteractiveMoveTransition* _Nonnull)moveTransition;

@end

@interface TKInteractiveMoveTransition : NSObject <UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate,UIViewControllerInteractiveTransitioning>

- (instancetype _Nonnull) initWithRootViewController:(UIViewController* _Nonnull)rootViewController axis:(TKMoveGestureAxis)axis start:(id _Nonnull)startLocation end:(id _Nonnull)endLocation;

@property (nonatomic,weak,nullable) id<TKInteractiveMoveTransitionDelegate>delegate;
@property (nonatomic,copy,nullable) void (^gestureBlock)(TKMoveGestureRecognizer * _Nullable gesture, CGPoint position, CGPoint location );


@property (nonatomic,weak, nullable) UIViewController *rootViewController;
@property (nonatomic,strong,nullable) UIViewController *presentingViewController;
@property (nonatomic,readonly,nonnull) TKMoveGestureRecognizer *moveGesture;
@property (nonatomic,readonly,nonnull) id startLocation;
@property (nonatomic,readonly,nonnull) id endLocation;
@property (nonatomic,assign) BOOL isTransitioning;
@property (nonatomic,assign) BOOL isPresenting;
@property (nonatomic,strong,nullable) id<UIViewControllerContextTransitioning> transitionContext;

// Call this at the end of an animation transition
- (void) transitionEnded;



// For Subclassing
- (void) presentAnimationTransition:(id<UIViewControllerContextTransitioning> __nullable)transitionContext containerView:(UIView* _Nonnull)containerView fromViewController:(UIViewController* _Nonnull)fromViewController toViewController:(UIViewController* _Nonnull)toViewController;
- (void) dismissAnimationTransition:(id<UIViewControllerContextTransitioning> __nullable)transitionContext containerView:(UIView* _Nonnull)containerView fromViewController:(UIViewController* _Nonnull)fromViewController toViewController:(UIViewController* _Nonnull)toViewController;
- (NSTimeInterval) transitionDuration:(id<UIViewControllerContextTransitioning> __nullable)transitionContext;

// For Subclassing
- (void) startPresentInteractiveTransition:(id<UIViewControllerContextTransitioning> __nullable)transitionContext containerView:(UIView* _Nonnull)containerView fromViewController:(UIViewController* _Nonnull)fromViewController toViewController:(UIViewController* _Nonnull)toViewController;
- (void) startDismissInteractiveTransition:(id<UIViewControllerContextTransitioning> __nullable)transitionContext containerView:(UIView* _Nonnull)containerView fromViewController:(UIViewController* _Nonnull)fromViewController toViewController:(UIViewController* _Nonnull)viewController;


- (void) completePresentInteractiveTransition:(id<UIViewControllerContextTransitioning> __nullable)transitionContext containerView:(UIView* _Nonnull)containerView fromViewController:(UIViewController* _Nonnull)fromViewController toViewController:(UIViewController* _Nonnull)toViewController;
- (void) completeDismissInteractiveTransition:(id<UIViewControllerContextTransitioning> __nullable)transitionContext containerView:(UIView* _Nonnull)containerView fromViewController:(UIViewController* _Nonnull)fromViewController toViewController:(UIViewController* _Nonnull)viewController;


// Call these to present and dismiss
- (void) presentViewControllerAnimated:(BOOL)animated complete:(void (^ __nullable)(void))completion;
- (void) dismissViewControllerAnimated:(BOOL)flag completion:(void (^ __nullable)(void))completion;


@end
