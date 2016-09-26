//
//  TKNavigationTransistionController.m
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

#import "TKNavigationTransistionController.h"


@interface TKNavigationTransistionController ()

@property (nonatomic,strong) NSMutableArray *animators;
@property (nonatomic,strong) TKNavigationControllerTransitionAnimator *currentAnimator;

@end

@implementation TKNavigationTransistionController


+ (TKNavigationTransistionController*) sharedInstance{
    static dispatch_once_t p = 0;
    __strong static TKNavigationTransistionController *_sharedObject = nil;
    dispatch_once(&p, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}
- (instancetype) init{
    if(!(self=[super init])) return nil;
    self.animators = [NSMutableArray array];
    return self;
}

- (void) addAnimator:(TKNavigationControllerTransitionAnimator*)animator{
    [self.animators addObject:animator];
}
- (TKNavigationControllerTransitionAnimator*) animatorOfClass:(Class)class{
    
    TKNavigationControllerTransitionAnimator *ret = nil;
    for(TKNavigationControllerTransitionAnimator *animator in self.animators){
        
        if([animator isMemberOfClass:class]){
            ret = animator;
            break;
        }
        
    }
    return ret;
    
}


#pragma mark UINavigationControllerDelegate
- (id <UIViewControllerInteractiveTransitioning>) navigationController:(UINavigationController *)navigationController
						   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>)animationController{
	
	
	
    if([animationController isKindOfClass:[TKNavigationControllerTransitionAnimator class]]){
		
		
		
		
        TKNavigationControllerTransitionAnimator *animator = (TKNavigationControllerTransitionAnimator*)animationController;
		
		NSLog(@"%@ %@ %@",animator,animator.isInteractive?@"INTER":@"NOTINTER",@(animator.navigationOperation));

		
		if(animator.navigationOperation == UINavigationControllerOperationPop && animator.isInteractive){
			
			NSLog(@"==>");
			return [(TKNavigationControllerTransitionAnimator*)animationController percentDrivenInteractiveTransition];

		}
    }
	

    return nil;

}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
	return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldBeRequiredToFailByGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
	return [gestureRecognizer isKindOfClass:UIScreenEdgePanGestureRecognizer.class];
}


- (id <UIViewControllerAnimatedTransitioning>) navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC{
    
    UIViewController *rootVC = operation == UINavigationControllerOperationPush ? fromVC : toVC;
    UIViewController *detailVC = operation == UINavigationControllerOperationPop ? fromVC : toVC;

    self.currentAnimator = nil;
    
    for(TKNavigationControllerTransitionAnimator *animator in self.animators){
        if([rootVC isKindOfClass:animator.rootViewControllerClass] && [detailVC isKindOfClass:animator.detailViewControllerClass]){
            self.currentAnimator = animator;
            break;
        }
    }
    
    self.currentAnimator.navigationOperation = operation ;
    return self.currentAnimator;
}

@end


@implementation TKNavigationControllerTransitionAnimator

- (Class) rootViewControllerClass{
    return nil;
}
- (Class) detailViewControllerClass{
    return nil;
}


- (void) completeTransition{
    [self.transitionContext completeTransition:!self.transitionContext.transitionWasCancelled];
}

- (void) pushAnimationFromRootViewController:(UIViewController*)fromViewController toDetailViewController:(UIViewController*)toViewController containerView:(UIView*)containerView context:(id<UIViewControllerContextTransitioning>)context{
    
}
- (void) popAnimationToRootViewController:(UIViewController*)fromViewController fromDetailViewController:(UIViewController*)detailViewController containerView:(UIView*)containerView context:(id<UIViewControllerContextTransitioning>)context{
    
}

- (NSTimeInterval) transitionDuration{
    return 1;
}

#pragma mark UIViewControllerInteractiveTransitioning
- (void) startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    
}
- (CGFloat) completionSpeed{
    return 1;
}
- (UIViewAnimationCurve) completionCurve{
    return UIViewAnimationCurveLinear;
}


#pragma UIViewControllerAnimatedTransitioning
- (void) animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
    
    _transitionContext = transitionContext;
    
    UIView *container = [transitionContext containerView];
    UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    
    if(self.navigationOperation == UINavigationControllerOperationPush){
        [self pushAnimationFromRootViewController:fromViewController toDetailViewController:toViewController containerView:container context:transitionContext];
    }else{
        [self popAnimationToRootViewController:toViewController fromDetailViewController:fromViewController containerView:container context:transitionContext];
    }
    

}
- (NSTimeInterval) transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
    return [self transitionDuration];
}
- (void) animationEnded:(BOOL)transitionCompleted{
    
    
}



- (UIPercentDrivenInteractiveTransition*) percentDrivenInteractiveTransition{
    if(_percentDrivenInteractiveTransition) return _percentDrivenInteractiveTransition;
    _percentDrivenInteractiveTransition = [[UIPercentDrivenInteractiveTransition alloc] init];
    return _percentDrivenInteractiveTransition;
}


@end
