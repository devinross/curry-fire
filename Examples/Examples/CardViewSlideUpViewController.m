//
//  CustomPresentationViewController.m
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

#import "CardViewSlideUpViewController.h"

#define START self.view.bounds.size.height / 2
#define END self.view.bounds.size.height * 1.5 - 130

@implementation CardViewSlideUpViewController

- (void) loadView{
    [super loadView];
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.2 alpha:1];
    
    UILabel *btn = [UILabel labelWithFrame:CGRectMake(20, 0, 100, 60) text:@"BACK" font:[UIFont boldSystemFontOfSize:14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    btn.userInteractionEnabled = YES;
    [btn addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }];
    [self.view addSubview:btn];
    
    self.cardView = [UIView viewWithFrame:self.view.bounds backgroundColor:[UIColor whiteColor] cornerRadius:10];
    self.cardView.layer.transform = [self transformAtPosition:1];
    self.cardView.center = CGPointMake(self.view.bounds.size.width/2, END);
    [self.view addSubview:self.cardView];
    
    
    TKMoveGestureRecognizer *move = [TKMoveGestureRecognizer gestureWithDirection:TKMoveGestureDirectionY movableView:self.cardView locations:@[@(START),@(END)] moveHandler:^(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location) {
        
        if(gesture.began || gesture.changed){

            self.cardView.layer.transform = [self transformAtPosition:position.y];

        }else if(gesture.cancelled || gesture.ended || !gesture){
            
            
            BOOL moveCardDown = (gesture.moving && location.y == END) || (!gesture.moving && location.y != END);
            if(!gesture)
                moveCardDown = location.y == END;
            
            [UIView beginAnimations:nil context:nil];
            if(moveCardDown){
                self.cardView.layer.transform = [self transformAtPosition:1];
                gesture.snapBackAnimation.toValue = @(END);
            }else{
                self.cardView.layer.transform = [self transformAtPosition:0];
                gesture.snapBackAnimation.toValue = @(START);
            }
            [UIView commitAnimations];
        }
        
    }];
    
    move.velocityDamping = 4;
    [self.cardView addGestureRecognizer:move];
    
    
    btn = [UILabel labelWithFrame:CGRectMake(20, 100, 100, 60) text:@"Slide Up" font:[UIFont boldSystemFontOfSize:14] textColor:[UIColor whiteColor] textAlignment:NSTextAlignmentLeft];
    btn.userInteractionEnabled = YES;
    [btn addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
        if(self.cardView.center.y == END)
            [move moveToPoint:CGPointMake(self.cardView.centerX, START)];
        else
            [move moveToPoint:CGPointMake(self.cardView.centerY, END)];
    }];
    [self.view addSubviewToBack:btn];
    
    
}
- (void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
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
