//
//  CartViewController.m
//  Examples
//
//  Created by Devin Ross on 4/23/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "CartViewController.h"

@interface CartViewController ()

@end

@implementation CartViewController


- (instancetype) init{
    if(!(self=[super init])) return nil;
    self.title = @"Cart";
    return self;
}

- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor randomColor];
    

    
    
    
    
    self.moveGesture = [TKMoveGestureRecognizer gestureWithDirection:TKMoveGestureDirectionY movableView:self.view locations:nil moveHandler:^(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location) {
        
        
        if(gesture.began){
            
            [self.moveGesture.snapBackAnimation setCompletionBlock:nil];
        }
        
        if(gesture.ended){
            
            
            NSLog(@"%@ %@",self.presentedViewController,self.presentingViewController);
            
            if(self.presenterViewController.view.middle.y == location.y && self.presentingViewController == nil){
                
                
                
                [self.moveGesture.snapBackAnimation setCompletionBlock:^(POPAnimation *pop, BOOL complete) {
                    
                    [self transitionEnded];
                    
                }];
                
                [self.presenterViewController presentViewController:self animated:YES completion:nil];
            }else if(self.presenterViewController.view.middle.y != location.y && self.presentingViewController != nil){
                
                
                [self.moveGesture.snapBackAnimation setCompletionBlock:^(POPAnimation *pop, BOOL complete) {
                    [self transitionEnded];
                }];
                
                [self dismissViewControllerAnimated:YES completion:nil];

            }
            
            
        }
        
        
    }];
    
    [self.view addGestureRecognizer:self.moveGesture];
    
    
}
- (void) transitionEnded{
    UIViewController *toViewController = [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

    UIView *container = [self.transitionContext containerView];
    if(toViewController == self ){
        
        self.view.center = [self.view.superview convertPoint:self.view.center toView:container];
        [container addSubview:self.view];
    }else{
        
        //self.view.center = [self.view.superview convertPoint:self.view.center toView:containerView];
        [self.presenterViewController.view addSubview:self.view];
    }
    
    [super transitionEnded];
    [self.moveGesture.snapBackAnimation setCompletionBlock:nil];

}

- (void) presentTransistionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView fromViewController:(UIViewController*)viewController{


    

    
    [UIView animateWithDuration:1 delay:0 options:0 animations:^{
        
        self.view.backgroundColor = [UIColor randomColor];
        
        
    } completion:^(BOOL finished) {
        
    }];
    
    
}

- (void) dismissTransistionAnimation:(id<UIViewControllerContextTransitioning>)transitionContext containerView:(UIView*)containerView toViewController:(UIViewController*)viewController{
    
    
    //[containerView addSubview:viewController.view];
    
    //[self.view removeFromSuperview];
    
    TKLog(@"%@",self.presenterViewController);
    TKLog(@"%@",self.view);

    //self.view.center = [self.view.superview convertPoint:self.view.center toView:self.presenterViewController.view];
    
    [UIView animateWithDuration:1 delay:0 options:0 animations:^{
        
        self.view.backgroundColor = [UIColor randomColor];
        
    } completion:^(BOOL finished) {
        

    }];
    
}

@end
