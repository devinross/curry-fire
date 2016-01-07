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
#import "ShortHand.h"

@interface TKMoveGestureRecognizer ()

@property (nonatomic,assign) BOOL moving;

@property (nonatomic,assign) CGPoint startPoint;

@end

@implementation TKMoveGestureRecognizer

#pragma mark Init & Friends
+ (instancetype) gestureWithAxis:(TKMoveGestureAxis)axis movableView:(UIView*)movableView{
    return [[TKMoveGestureRecognizer alloc] initWithAxis:axis movableView:movableView];
}
+ (instancetype) gestureWithAxis:(TKMoveGestureAxis)axis movableView:(UIView*)movableView locations:(NSArray*)locations{
    return [[TKMoveGestureRecognizer alloc] initWithAxis:axis movableView:movableView locations:locations];
}
+ (instancetype) gestureWithAxis:(TKMoveGestureAxis)axis movableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveGestureRecognizer *gesture, CGPoint position,CGPoint location ))block{
    return [[TKMoveGestureRecognizer alloc] initWithAxis:axis movableView:movableView locations:locations moveHandler:block];
}

- (instancetype) initWithAxis:(TKMoveGestureAxis)axis movableView:(UIView*)movableView{
    self = [self initWithAxis:axis movableView:movableView locations:nil moveHandler:nil];
    return self;
}
- (instancetype) initWithAxis:(TKMoveGestureAxis)axis movableView:(UIView *)movableView locations:(NSArray*)locations{
    self = [self initWithAxis:axis movableView:movableView locations:locations moveHandler:nil];
    return self;
}
- (instancetype) initWithTarget:(id)target action:(SEL)action{
    if(!(self=[super initWithTarget:target action:action])) return nil;
    
    _axis = TKMoveGestureAxisXY;
    [self addTarget:self action:@selector(pan:)];
    self.velocityDamping = 20;
    self.canMoveOutsideLocationBounds = YES;
    
    return self;
}
- (instancetype) initWithAxis:(TKMoveGestureAxis)direction movableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location ))block{
    self = [self initWithTarget:nil action:nil];
    
    _axis = direction;
    self.locations = locations;
    self.moveHandler = block;
    self.movableView = movableView;
    self.canMoveOutsideLocationBounds = YES;

    return self;
    
}



- (CGPoint) closestPointToLocation:(CGPoint)projectedPoint currentPoint:(CGPoint)currentPoint{
    
    CGFloat minDistance = 100000000;
    CGPoint retPoint = CGPointZero;
    
    if(self.axis == TKMoveGestureAxisXY){
        for(NSValue *endValue in self.locations){
            CGPoint locationPoint = [endValue CGPointValue];
            CGFloat dis = CGPointGetDistance(projectedPoint, locationPoint);
            if(dis < minDistance){
                retPoint = locationPoint;
                minDistance = dis;
            }
        }
        return retPoint;
    }

    
    if(self.axis == TKMoveGestureAxisY){
        for(NSNumber *number in self.locations){
            CGPoint locationPoint = CGPointMake(currentPoint.x, number.doubleValue);
            CGFloat dis = CGPointGetDistance(projectedPoint, locationPoint);
            if(dis < minDistance){
                retPoint = locationPoint;
                minDistance = dis;
            }
        }
        return retPoint;
    }

    

    for(NSNumber *number in self.locations){
        CGPoint locationPoint = CGPointMake(number.doubleValue,currentPoint.y);
        CGFloat dis = CGPointGetDistance(projectedPoint, locationPoint);
        if(dis < minDistance){
            retPoint = locationPoint;
            minDistance = dis;
        }
    }
    return retPoint;
    
    
}
- (CGPoint) minimumLocation{
    
    if(self.axis == TKMoveGestureAxisX){
        return CGPointMake([[self.locations valueForKeyPath:@"@min.self"] doubleValue], self.movableView.center.y);
        
    }else if(self.axis == TKMoveGestureAxisY){
        return CGPointMake(self.movableView.center.x, [[self.locations valueForKeyPath:@"@min.self"] doubleValue]);
    }
    
    NSArray *sortedArray = [self.locations sortedArrayUsingComparator:^NSComparisonResult(NSValue *obj1, NSValue *obj2) {
        CGPoint p1 = [obj1 CGPointValue];
        CGPoint p2 = [obj2 CGPointValue];
        if (p1.x == p2.x) return p1.y < p2.y;
        return p1.x < p2.x;
    }];
    return [sortedArray.firstObject CGPointValue];
    
}
- (CGPoint) maximumLocation{
    
    if(self.axis == TKMoveGestureAxisX){
        return CGPointMake([[self.locations valueForKeyPath:@"@max.self"] doubleValue], self.movableView.center.y);
        
    }else if(self.axis == TKMoveGestureAxisY){
        return CGPointMake(self.movableView.center.y, [[self.locations valueForKeyPath:@"@max.self"] doubleValue]);
        
    }
    
    NSArray *sortedArray = [self.locations sortedArrayUsingComparator:^NSComparisonResult(NSValue *obj1, NSValue *obj2) {
        CGPoint p1 = [obj1 CGPointValue];
        CGPoint p2 = [obj2 CGPointValue];
        if (p1.x == p2.x) return p1.y < p2.y;
        return p1.x < p2.x;
    }];
    return [sortedArray.lastObject CGPointValue];
}


- (void) pan:(UIPanGestureRecognizer*)gesture{
    
    CGPoint velocity = [self velocityInView:self.view];
    UIView *panView = self.movableView;
    if(self.began || (!self.moving && self.changed)){
        self.startPoint = panView.center;
        [panView.layer pop_removeAnimationForKey:@"pop"];
        self.moving = YES;
    }
    
    CGPoint p = self.startPoint;
    
    if(self.axis == TKMoveGestureAxisXY || self.axis == TKMoveGestureAxisX)
        p.x += [self translationInView:self.view].x;
    if(self.axis == TKMoveGestureAxisXY || self.axis == TKMoveGestureAxisY)
        p.y += [self translationInView:self.view].y;
        
    if(self.axis == TKMoveGestureAxisX)
        p.y = self.movableView.center.y;
    if(self.axis == TKMoveGestureAxisY)
        p.x = self.movableView.center.x;

    if(!self.canMoveOutsideLocationBounds){
        
        CGPoint minPoint = [self minimumLocation];
        CGPoint maxPoint = [self maximumLocation];
        
        if(self.axis == TKMoveGestureAxisX || self.axis == TKMoveGestureAxisXY)
            p.x = MIN(maxPoint.x,MAX(minPoint.x,p.x));
        if(self.axis == TKMoveGestureAxisY || self.axis == TKMoveGestureAxisXY)
            p.y = MIN(maxPoint.y,MAX(minPoint.y,p.y));

    }
    
    CGPoint blockPoint = p;
    
    if(self.state == UIGestureRecognizerStateChanged){
        
        panView.center = p;

    }else if(self.state == UIGestureRecognizerStateEnded || self.state == UIGestureRecognizerStateCancelled){
        
        CGFloat projectedX = p.x + velocity.x / self.velocityDamping;
        CGFloat projectedY = p.y + velocity.y / self.velocityDamping;
        CGPoint projectedPoint = CGPointMake(projectedX, projectedY);
        blockPoint = [self closestPointToLocation:projectedPoint currentPoint:p];
        
        if(self.axis == TKMoveGestureAxisX){
            self.snapBackAnimation.fromValue = @(p.x);
            self.snapBackAnimation.toValue = @(blockPoint.x);
            self.snapBackAnimation.velocity = @(velocity.x);
        }else if(self.axis == TKMoveGestureAxisY){
            self.snapBackAnimation.fromValue = @(p.y);
            self.snapBackAnimation.toValue = @(blockPoint.y);
            self.snapBackAnimation.velocity = @(velocity.y);
        }else{
            self.snapBackAnimation.fromValue = NSCGPoint(p);
            self.snapBackAnimation.toValue = NSCGPoint(blockPoint);
            self.snapBackAnimation.velocity = NSCGPoint(velocity);
        }
        

        [panView.layer pop_addAnimation:self.snapBackAnimation forKey:@"pop"];
        self.moving = NO;
    }
    
    CGPoint minPoint = [self minimumLocation];
    CGPoint maxPoint = [self maximumLocation];
    CGPoint perc = CGPointMake((p.x - minPoint.x) / (maxPoint.x - minPoint.x), (p.y - minPoint.y) / (maxPoint.y - minPoint.y));
    
    if(self.moveHandler)
        self.moveHandler(self,perc,blockPoint);
    

}


- (void) moveToPoint:(CGPoint)point{
    
    UIView *panView = self.movableView;
    CGPoint center = panView.center;
    CGPoint blockPoint = center;
    
    if(self.axis == TKMoveGestureAxisXY || self.axis == TKMoveGestureAxisX)
        blockPoint.x = point.x;
    if(self.axis == TKMoveGestureAxisXY || self.axis == TKMoveGestureAxisY)
        blockPoint.y = point.y;
    
    
    if(self.axis == TKMoveGestureAxisX){
        self.snapBackAnimation.fromValue = @(center.x);

        self.snapBackAnimation.toValue = @(blockPoint.x);
    }else if(self.axis == TKMoveGestureAxisY){
        self.snapBackAnimation.fromValue = @(center.y);
        self.snapBackAnimation.toValue = @(blockPoint.y);
    }else{
        self.snapBackAnimation.fromValue = NSCGPoint(center);
        self.snapBackAnimation.toValue = NSCGPoint(blockPoint);
    }
    
    [panView.layer pop_addAnimation:self.snapBackAnimation forKey:@"pop"];
    
    
    CGPoint minPoint = [self minimumLocation];
    CGPoint maxPoint = [self maximumLocation];
    CGPoint perc = CGPointMake((blockPoint.x - minPoint.x) / (maxPoint.x - minPoint.x), (blockPoint.y - minPoint.y) / (maxPoint.y - minPoint.y));
    
    if(self.moveHandler)
        self.moveHandler(nil,perc,blockPoint);

}


#pragma mark UITouchMoved
//- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
//    [super touchesBegan:touches withEvent:event];
//    
//    if (self.animating && [self state] == UIGestureRecognizerStatePossible) {
//        [self setState:UIGestureRecognizerStateBegan];
//    }
//    
//}
//- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
//    [super touchesMoved:touches withEvent:event];
//
//    if ([self state] == UIGestureRecognizerStatePossible) {
//        [self setState:UIGestureRecognizerStateBegan];
//        self.startPoint = self.movableView.center;
//    } else {
//        [self setState:UIGestureRecognizerStateChanged];
//    }
//    
//    
//}
//- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
//    [super touchesEnded:touches withEvent:event];
//    [self setState:UIGestureRecognizerStateEnded];
//}
//- (void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event{
//    [super touchesCancelled:touches withEvent:event];
//    [self setState:UIGestureRecognizerStateCancelled];
//}


#pragma mark Properties
- (NSString*) popAnimationPropertyName{
    if(self.axis == TKMoveGestureAxisX)
        return kPOPLayerPositionX;
    else if(self.axis == TKMoveGestureAxisY)
        return kPOPLayerPositionY;
    return kPOPLayerPosition;
}
- (POPSpringAnimation*) snapBackAnimation{
    if(_snapBackAnimation) return _snapBackAnimation;
    _snapBackAnimation = [POPSpringAnimation animationWithPropertyNamed:self.popAnimationPropertyName];
    _snapBackAnimation.springBounciness = 1.5;
    _snapBackAnimation.springSpeed = 2;
    _snapBackAnimation.removedOnCompletion = YES;
    return _snapBackAnimation;
}

- (BOOL) animating{
    return [self.movableView.layer pop_animationForKey:@"pop"] != nil;
}

@end