//
//  TKMoveViewGestureRecognizer.m
//  Created by Devin Ross on 4/16/15.
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

#import "TKMoveGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface TKMoveGestureRecognizer ()

@property (nonatomic,assign) BOOL moving;
@property (nonatomic,assign) CGPoint startPoint;

@end

@implementation TKMoveGestureRecognizer

#pragma mark Init & Friends
+ (instancetype) gestureWithMovableView:(UIView*)movableView{
    return [[TKMoveGestureRecognizer alloc] initWithMovableView:movableView];
}
+ (instancetype) gestureWithMovableView:(UIView*)movableView locations:(NSArray*)locations{
    return [[TKMoveGestureRecognizer alloc] initWithMovableView:movableView locations:locations];
}
+ (instancetype) gestureWithMovableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveGestureRecognizer *gesture, CGPoint position,CGPoint location ))block{
    return [[TKMoveGestureRecognizer alloc] initWithMovableView:movableView locations:locations moveHandler:block];
}


- (instancetype) initWithMovableView:(UIView*)movableView{
    self = [self initWithMovableView:movableView locations:nil moveHandler:nil];
    return self;
}
- (instancetype) initWithMovableView:(UIView *)movableView locations:(NSArray*)locations{
    self = [self initWithMovableView:movableView locations:locations moveHandler:nil];
    return self;
}
- (instancetype) initWithTarget:(id)target action:(SEL)action{
    if(!(self=[super initWithTarget:target action:action])) return nil;
    
    [self addTarget:self action:@selector(pan:)];
    self.velocityDamping = 20;
    
    return self;
}
- (instancetype) initWithMovableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location ))block{
    self = [self initWithTarget:nil action:nil];
    
    self.locations = locations;
    self.moveHandler = block;
    self.movableView = movableView;
    
    return self;
    
}

- (void) pan:(UIPanGestureRecognizer*)gesture{
    
    CGPoint velocity = [self velocityInView:self.view];
    UIView *panView = self.movableView;
    if(self.state == UIGestureRecognizerStateBegan){
        self.startPoint = panView.center;
        [panView.layer pop_removeAnimationForKey:@"pop"];
    }
    
    CGPoint p = self.startPoint;
    p.y += [self translationInView:self.view].y;
    
    CGPoint blockPoint = p;
    
    if(self.state == UIGestureRecognizerStateBegan || self.state == UIGestureRecognizerStateChanged){
        
        panView.center = p;

        
    }else if(self.state == UIGestureRecognizerStateEnded || self.state == UIGestureRecognizerStateCancelled){
        
        CGFloat minDistance = 100000000;
        CGFloat endY = 0;
        CGFloat projectedX = p.x + velocity.x / self.velocityDamping;
        CGFloat projectedY = p.y + velocity.y / self.velocityDamping;
        CGPoint projectedPoint = CGPointMake(projectedX, projectedY);
    
        for(NSNumber *endValue in self.locations){
            
            CGPoint locationPoint = CGPointMake(p.x, endValue.doubleValue);
            CGFloat dis = CGPointGetDistance(projectedPoint, locationPoint);
            
            if(dis < minDistance){
                
                endY = endValue.doubleValue;
                minDistance = dis;
                
            }
            
        }
        
        blockPoint = CGPointMake(p.x, endY);
        
        
        self.snapBackAnimation.fromValue = @(p.y);
        self.snapBackAnimation.toValue = @(endY);
        self.snapBackAnimation.velocity = @(velocity.y);
        [panView.layer pop_addAnimation:self.snapBackAnimation forKey:@"pop"];
        
        
        
    }
    

    CGPoint minPoint = [self minimumLocation];
    CGPoint maxPoint = [self maximumLocation];
    CGPoint perc = CGPointMake((p.x - minPoint.x) / (maxPoint.x - minPoint.x), (p.y - minPoint.y) / (maxPoint.y - minPoint.y));
    
    if(self.moveHandler)
        self.moveHandler(self,perc,blockPoint);
    

}

- (CGPoint) minimumLocation{
    
    
    return CGPointMake(self.movableView.center.x, [[self.locations valueForKeyPath:@"@min.self"] doubleValue]);
}
- (CGPoint) maximumLocation{
    return CGPointMake(self.movableView.center.x, [[self.locations valueForKeyPath:@"@max.self"] doubleValue]);
}


#pragma mark UITouchMoved
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesBegan:touches withEvent:event];
    
    if ([self state] == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateBegan];
        self.moving = NO;
    }
    
}
- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesMoved:touches withEvent:event];

    if ([self state] == UIGestureRecognizerStatePossible) {
        [self setState:UIGestureRecognizerStateBegan];
    } else {
        [self setState:UIGestureRecognizerStateChanged];
    }
    
    self.moving = YES;
    
}
- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesEnded:touches withEvent:event];

    [self setState:UIGestureRecognizerStateEnded];

}
- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
    [super touchesCancelled:touches withEvent:event];
    [self setState:UIGestureRecognizerStateCancelled];
}


#pragma mark Properties
- (POPSpringAnimation*) snapBackAnimation{
    if(_snapBackAnimation) return _snapBackAnimation;
    _snapBackAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPLayerPositionY];
    _snapBackAnimation.springBounciness = 1.5;
    _snapBackAnimation.springSpeed = 2;
    _snapBackAnimation.removedOnCompletion = NO;
    return _snapBackAnimation;
}


@end
