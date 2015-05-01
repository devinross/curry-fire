//
//  InteractiveTransitionViewController.m
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

#import "NavigationPushPopTransitionViewController.h"

@interface ZoomedViewController : UIViewController
@property (nonatomic,strong) UIScreenEdgePanGestureRecognizer *edgePanGestureRecognizer;

@end
@implementation ZoomedViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    // Setup a screen edge pan gesture recognizer to trigger from the right edge of the screen.
    self.edgePanGestureRecognizer = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:self action:@selector(handleScreenEdgePanGesture:)];
    self.edgePanGestureRecognizer.edges = UIRectEdgeLeft;
    [self.view addGestureRecognizer:self.edgePanGestureRecognizer];
}

- (void) handleScreenEdgePanGesture:(UIScreenEdgePanGestureRecognizer *)sender{
    CGFloat percent = sender.translationXPercentage;
    
    ZoomBlockAnimator *animator = [[TKNavigationTransistionController sharedInstance] animatorOfClass:[ZoomBlockAnimator class]];

    
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            animator.isInteractive = YES;
            [self.navigationController popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            // Update the transition using a UIPercentDrivenInteractiveTransition.
            [animator.percentDrivenInteractiveTransition updateInteractiveTransition:percent];
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled:

            // Cancel or finish depending on how the gesture ended.
            if (percent > 0.5 || fabs([sender velocityInView:self.view].x) > 1000)
                [animator.percentDrivenInteractiveTransition finishInteractiveTransition];
            else
                [animator.percentDrivenInteractiveTransition cancelInteractiveTransition];
            
            animator.isInteractive = NO;
            break;
        default:
            NSLog(@"unhandled state for gesture=%@", sender);
    }
}

@end


@interface NextViewController : UIViewController

@end


@implementation NavigationPushPopTransitionViewController

- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    
    self.title = @"Custom Transition";
    
    
    CGFloat pad = 20;
    CGFloat width = (self.view.width - (pad*3)) / 2;
    
    UIView *one = [UIView viewWithFrame:CGRectMake(pad, pad, width, width) backgroundColor:[UIColor randomColor]];
    [self.view addSubview:one];
    
    UIView *two = [UIView viewWithFrame:CGRectMake(pad*2+width, pad, width, width) backgroundColor:[UIColor randomColor]];
    [self.view addSubview:two];
    
    UIView *three = [UIView viewWithFrame:CGRectMake(pad, pad*2+width, width, width) backgroundColor:[UIColor randomColor]];
    [self.view addSubview:three];
    
    UIView *four = [UIView viewWithFrame:CGRectMake(pad*2+width, pad*2+width, width, width) backgroundColor:[UIColor randomColor]];
    [self.view addSubview:four];
    
    
    id block = ^(UIGestureRecognizer *sender) {
        
        ZoomedViewController *vc = [[ZoomedViewController alloc] init];
        vc.edgesForExtendedLayout = UIRectEdgeNone;
        ZoomBlockAnimator *animator = (id)[[TKNavigationTransistionController sharedInstance] animatorOfClass:[ZoomBlockAnimator class]];
        animator.selectedTile = sender.view;
        animator.originalTileFrame = animator.selectedTile.frame;
        [self.navigationController pushViewController:vc animated:YES];
        
    };
    
    [one addTapGestureWithHandler:block];
    [two addTapGestureWithHandler:block];
    [three addTapGestureWithHandler:block];
    [four addTapGestureWithHandler:block];
    
}
- (void) viewDidLoad{
    [super viewDidLoad];
    [[TKNavigationTransistionController sharedInstance] addAnimator:ZoomBlockAnimator.new];
}
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.navigationController.delegate = [TKNavigationTransistionController sharedInstance];
}

@end


@implementation ZoomBlockAnimator

- (Class) rootViewControllerClass{
    return [NavigationPushPopTransitionViewController class];
}
- (Class) detailViewControllerClass{
    return [UIViewController class];
}
- (void) pushAnimationFromRootViewController:(NavigationPushPopTransitionViewController*)fromViewController toDetailViewController:(ZoomedViewController*)detailViewController containerView:(UIView*)containerView context:(id<UIViewControllerContextTransitioning>)context{

    [containerView addSubview:detailViewController.view];
    self.selectedTile.center = [self.selectedTile.superview convertPoint:self.selectedTile.center toView:containerView];
    [containerView addSubview:self.selectedTile];
    detailViewController.view.alpha = 0;

    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:0 animations:^{

        CGFloat originY = [detailViewController.view.superview convertPoint:detailViewController.view.origin toView:containerView].y;
        self.selectedTile.frame = CGRectMake(0, originY, detailViewController.view.width, 200);
        fromViewController.view.alpha = 0;
        detailViewController.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        if(![self.transitionContext transitionWasCancelled]){
            self.selectedTile.center = [self.selectedTile.superview convertPoint:self.selectedTile.center toView:detailViewController.view];
            [detailViewController.view addSubview:self.selectedTile];
        }
        

        [self completeTransition];
        
    }];
    
    
}
- (void) popAnimationToRootViewController:(NavigationPushPopTransitionViewController*)rootViewController fromDetailViewController:(ZoomedViewController*)detailViewController containerView:(UIView*)containerView context:(id<UIViewControllerContextTransitioning>)context{
    
    rootViewController.view.alpha = 0;
    [containerView addSubviewToBack:rootViewController.view];
    
    
    
    self.selectedTile.center = [self.selectedTile.superview convertPoint:self.selectedTile.center toView:containerView];
    [containerView addSubview:self.selectedTile];
    detailViewController.view.alpha = 0;
    
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.2 options:0 animations:^{
        

        self.selectedTile.frame = [rootViewController.view convertRect:self.originalTileFrame toView:containerView];
        
        detailViewController.view.alpha = 0;
        rootViewController.view.alpha = 1;
        
    } completion:^(BOOL finished) {
        
        
        if(![self.transitionContext transitionWasCancelled]){
            self.selectedTile.center = [self.selectedTile.superview convertPoint:self.selectedTile.center toView:rootViewController.view];
            [rootViewController.view addSubview:self.selectedTile];
            [detailViewController.view removeFromSuperview];
        }
        

        [self completeTransition];
        
    }];
    
}
- (NSTimeInterval) transitionDuration{
    return 0.6;
}

@end

