//
//  CustomTransitionViewController.m
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

#import "CustomTransitionViewController.h"

#define START self.view.bounds.size.height / 2
#define END self.view.bounds.size.height * 1.5 - 130

@interface CardViewController : TKCustomTransitionViewController

- (CATransform3D) transformAtPosition:(CGFloat)progress;

@end

@implementation CardViewController

- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.cornerRadius = 10;
    
    
    
    self.view.layer.transform = [self transformAtPosition:1];
    self.view.center = CGPointMake(self.view.bounds.size.width/2, END);
    
    
    
    self.block = ^(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location) {
        
        if(gesture.changed){
            

            self.view.layer.transform = [self transformAtPosition:position.y];
            
            
        }
        
    };
    
}
- (CATransform3D) transformAtPosition:(CGFloat)progress{
    CATransform3D trans = CATransform3DIdentity;
    trans.m34 = 1.0 / -1000.0;
    CGFloat scale = MIN(1.0, 1.0 - (0.2 * progress));
    trans = CATransform3DScale(trans, scale, scale, 1);
    trans = CATransform3DRotate(trans, (progress * -20) * M_PI / 180.0f, 1, 0, 0);
    return trans;
}

@end

@interface CustomTransitionViewController ()
@end

@implementation CustomTransitionViewController

- (void) loadView{
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    
    
    UILabel *btn = [UILabel labelWithFrame:CGRectMake(20, 0, 100, 60) text:@"BACK" font:[UIFont boldSystemFontOfSize:14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    btn.userInteractionEnabled = YES;
    [btn addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.view addSubview:btn];
    
    CardViewController *card = [[CardViewController alloc] init];
    self.cardViewController = card;
    [self.view addSubview:self.cardViewController.view];
    


    
    
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

@end





@implementation TKCustomTransitionViewController

- (instancetype) init{
    if(!(self=[super init])) return nil;
    self.modalPresentationStyle = UIModalPresentationCustom;
    self.transitioningDelegate = self;
    return self;
}

//- (void) loadView{
//    [super loadView];
//    
//    
//    self.moveGesture = [[TKMoveGestureRecognizer alloc] initWithDirection:TKMoveGestureDirectionY movableView:self.view locations:@[@(START),@(END)] moveHandler:^(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location) {
//        
//        if(gesture.changed){
//            
//            if(!self.transitionContext){
//                self.shouldBeInteractive = YES;
//                
//                if(self.presentingViewController)
//                    [self dismissViewControllerAnimated:YES completion:nil];
//                else
//                    [self presentViewController:self animated:YES completion:nil];
//            }
//            
//            
//            
//        }else if(gesture.cancelled || gesture.ended){
//            
//            
//            if(!gesture.moving){
//                
//                if(location.y == END){
//                    self.shouldBeInteractive = NO;
//                    
//                    
//                    if(self.presentingViewController)
//                        [self dismissViewControllerAnimated:YES completion:nil];
//                    else
//                        [self presentViewController:self animated:YES completion:nil];
//                    
//                }
//                return;
//            }else{
//                
//                
//                BOOL moveCardDown = (gesture.moving && location.y == END);
//                
//                [UIView beginAnimations:nil context:nil];
//                if(moveCardDown){
//                    self.view.layer.transform = [self transformAtPosition:1];
//                    gesture.snapBackAnimation.toValue = @(END);
//                    
//                    
//                    
//                    
//                    [gesture.snapBackAnimation setCompletionBlock:^(POPAnimation *pop, BOOL complete) {
//                        
//                        
//                        if(self.cardViewController.isBeingPresented){
//                            
//                            if(complete){
//                                [self.transitionContext cancelInteractiveTransition];
//                                [self.transitionContext completeTransition:NO];
//                                self.transitionContext = nil;
//                            }
//                        }else{
//                            
//                            if(complete){
//                                CGPoint p = [self.cardViewController.view.superview convertPoint:self.cardViewController.view.center toView:self.view];
//                                self.view.center = p;
//                                [self.view addSubview:self.view];
//                                
//                                [self.transitionContext finishInteractiveTransition];
//                                [self.transitionContext completeTransition:YES];
//                                self.transitionContext = nil;
//                                [self.view addSubview:self.view];
//                            }
//                        }
//                        
//                        
//                        
//                    }];
//                    
//                    
//                    
//                    
//                }else{
//                    
//                    gesture.snapBackAnimation.toValue = @(START);
//                    
//                    [gesture.snapBackAnimation setCompletionBlock:^(POPAnimation *pop, BOOL complete) {
//                        if(complete){
//                            
//                            
//                            if(self.isBeingPresented){
//                                
//                                UIView *container  = [self.transitionContext containerView];
//                                CGPoint p = [self.view.superview convertPoint:self.view.center toView:container];
//                                self.view.center = p;
//                                [container addSubview:self.view];
//                                
//                                [self.transitionContext finishInteractiveTransition];
//                                [self.transitionContext completeTransition:YES];
//                                self.transitionContext = nil;
//                                
//                                
//                                
//                                
//                            } else{
//                                
//                                [self.transitionContext cancelInteractiveTransition];
//                                [self.transitionContext completeTransition:NO];
//                                self.transitionContext = nil;
//                                
//                                
//                                
//                                
//                            }
//                            
//                            
//                        }
//                        
//                    }];
//                    
//                    
//                    
//                    
//                }
//                [UIView commitAnimations];
//                
//                
//            }
//            
//            
//            
//        }
//        
//    }];
//    self.moveGesture.velocityDamping = 4;
//    [self.view addGestureRecognizer:self.moveGesture];
//
//    
//    
//}



- (void) show{
    
    
}


//- (id <UIViewControllerAnimatedTransitioning>) animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source{
//    return presented == self;
//}
//- (id <UIViewControllerAnimatedTransitioning>) animationControllerForDismissedController:(UIViewController *)dismissed{
//    return dismissed == self;
//}
//- (id <UIViewControllerInteractiveTransitioning>) interactionControllerForPresentation:(id <UIViewControllerAnimatedTransitioning>)animator{
//    return self.shouldBeInteractive ? self : nil;
//}
//- (id <UIViewControllerInteractiveTransitioning>) interactionControllerForDismissal:(id <UIViewControllerAnimatedTransitioning>)animator{
//    return self.shouldBeInteractive ? self : nil;
//}
//
//
//- (void) animationEnded:(BOOL) transitionCompleted{
//    NSLog(@"ENENNED %@",transitionCompleted ? @"COMPLETE" : @"CANCEL");
//}
//
//
//
//- (NSTimeInterval) transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext{
//    return 1;
//}
//- (void) animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    self.transitionContext = transitionContext;
//    
//    TKLog(@"ANIMATE!!! transitionContext: %@",transitionContext);
//    
//    [UIView beginAnimations:nil context:nil];
//    self.cardViewController.view.layer.transform = [self transformAtPosition:0];
//    self.moveGesture.snapBackAnimation.toValue = @(START);
//    [self.moveGesture.snapBackAnimation setCompletionBlock:^(POPAnimation *pop, BOOL complete) {
//        if(complete){
//            UIView *container  = [transitionContext containerView];
//            CGPoint p = [self.cardViewController.view.superview convertPoint:self.cardViewController.view.center toView:container];
//            self.cardViewController.view.center = p;
//            [container addSubview:self.cardViewController.view];
//            [transitionContext completeTransition:YES];
//        }
//    }];
//    [UIView commitAnimations];
//    
//}
//- (void) startInteractiveTransition:(id <UIViewControllerContextTransitioning>)transitionContext{
//    TKLog(@"INTERACT %@",transitionContext);
//    self.transitionContext = transitionContext;
//}
//
//- (CGFloat) completionSpeed{
//    return 4;
//}
//- (UIViewAnimationCurve) completionCurve{
//    return UIViewAnimationCurveLinear;
//}

@end


