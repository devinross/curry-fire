//
//  UIView+TwelvePrinciples.m
//  curryfire
//
//  Created by Devin Ross on 4/22/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "UIView+TwelvePrinciples.h"
#import "UIView+Positioning.h"
#import "ShortHand.h"

@implementation UIView (TwelvePrinciples)


- (void) zoomToYPoint:(CGFloat)endYPoint completion:(void (^)(BOOL finished))completion{
    [self zoomToYPoint:endYPoint duration:0.7 delay:0 completion:completion];
}
- (void) zoomToYPoint:(CGFloat)endYPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion{
    
    CGAffineTransform baseTransform = self.transform;
    
    if(endYPoint > self.centerY){
        CGFloat yy = CGRectGetMinY(self.frame);
        self.layer.anchorPoint = CGPointMake(0.5, 0);
        self.center = CGPointMake(self.centerX, yy);
    }else{
        CGFloat yy = CGRectGetMaxY(self.frame);
        self.layer.anchorPoint = CGPointMake(0.5, 1);
        self.center = CGPointMake(self.centerX, yy);
    }

//    CGFloat xScale = self.transform.a;
//    CGFloat yScale = self.transform.d;
    CGFloat xScale = 1, yScale = 1;
    
    [UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            self.transform = CGConcat(baseTransform, CGScale(xScale+0.1, yScale-0.3)) ;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.3 animations:^{
            self.transform = CGScale(xScale-0.3, yScale+0.3);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.6 animations:^{
            self.center = CGPointMake(self.centerX, endYPoint);
        }];

    } completion:^(BOOL finished){
        self.transform = baseTransform;
        CGFloat minY = self.minY + self.height / 2.0f;
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
        self.centerY = minY;
        if(completion) completion(finished);
    }];
}
- (void) zoomToXPoint:(CGFloat)endXPoint completion:(void (^)(BOOL finished))completion{
    [self zoomToXPoint:endXPoint completion:completion];
}
- (void) zoomToXPoint:(CGFloat)endXPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion{
    
    CGAffineTransform baseTransform = self.transform;

    if(endXPoint > self.centerX){
        CGFloat xx = CGRectGetMinX(self.frame);
        self.layer.anchorPoint = CGPointMake(0, 0.5);
        self.center = CGPointMake(xx, self.centerY);
    }else{
        CGFloat xx = CGRectGetMaxX(self.frame);
        self.layer.anchorPoint = CGPointMake(1, 1);
        self.center = CGPointMake(xx, self.centerY);
    }
    
    CGFloat xScale = self.transform.a;
    CGFloat yScale = self.transform.d;
    
    [UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            self.transform = CGScale(xScale-0.3, yScale+0.1);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.3 animations:^{
            self.transform = CGScale(xScale+0.3, yScale-0.3);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.6 animations:^{
            self.center = CGPointMake(endXPoint, self.centerY);
        }];
        
    } completion:^(BOOL finished){
        self.transform = baseTransform;

        CGFloat minX = self.minX + self.width / 2.0f;
        self.layer.anchorPoint = CGPointMake(0.5, 0.5);
        self.centerX = minX;
        if(completion) completion(finished);
    }];
}



- (void) tickle{
    [self tickleWithCompletion:nil];
}
- (void) tickleWithCompletion:(void (^)(BOOL finished))completion{
    [self tickleWithDuration:1 delay:0 completion:completion];
}
- (void) tickleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion{
    
    CGAffineTransform baseTransform = self.transform;
//    CGFloat xScale = self.transform.a, yScale = self.transform.d;
    
    CGFloat x = 1;
    
    
    [UIView animateKeyframesWithDuration:1.0 delay:delay options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.1 animations:^{
            self.transform = CGConcat(baseTransform, CGScale(x, x));
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.1 relativeDuration:0.2 animations:^{
            self.transform = CGConcat(baseTransform, CGScale(x+0.05, x-0.05));
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.2 animations:^{
            self.transform = CGConcat(baseTransform, CGScale(x-0.05, x+0.05));
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.2 animations:^{
            self.transform = CGConcat(baseTransform, CGScale(x+0.05, x-0.05));
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.2 animations:^{
            self.transform = baseTransform;
        }];
        [UIView addKeyframeWithRelativeStartTime:0.9 relativeDuration:0.1 animations:^{
            //self.transform = CGAffineTransformIdentity;
        }];
        
        
    }completion:nil];
    
}


- (void) shakeAnimationWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion{
    
    CGFloat centerY = self.centerY, centerX = self.centerX;
    
    [UIView animateKeyframesWithDuration:0.6 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeCubicPaced animations:^{
        
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
            self.center = CGPointMake(centerX - 15, centerY);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.2 relativeDuration:0.2 animations:^{
            self.center = CGPointMake(centerX + 15, centerY);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.4 relativeDuration:0.2 animations:^{
            self.center = CGPointMake(centerX - 10, centerY);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.2 animations:^{
            self.center = CGPointMake(centerX + 10, centerY);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.2 animations:^{
            self.center = CGPointMake(centerX + 0, centerY);
        }];
        
    } completion:completion];

}
- (void) shakeAnimationWithCompletion:(void (^)(BOOL finished))completion{
    [self shakeAnimationWithDuration:0.6 delay:0 completion:completion];
}


- (void) wiggle{
    [self wiggleWithRotation:0.06];
}
- (void) wiggleWithRotation:(CGFloat)angle{
    [self wiggleWithDuration:0.5 delay:0 rotation:angle];
}
- (void) wiggleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay betweenAngleOne:(CGFloat)angleOne angleTwo:(CGFloat)angleTwo{
    
    CGAffineTransform transform = self.transform;
    CGFloat currentAngle = atan2(transform.b, transform.a);
    CABasicAnimation *animation;
    
    CATransform3D second = CATransform3DMakeRotation(angleTwo, 0, 0, 1.0);
    CFTimeInterval secondBeginTime;

    if(angleOne == currentAngle || angleTwo == currentAngle){
        if(angleTwo == currentAngle)
            second = CATransform3DMakeRotation(angleOne, 0, 0, 1.0);
        secondBeginTime = CACurrentMediaTime() + delay;
    }else{
        
        CATransform3D first = CATransform3DMakeRotation(angleOne, 0, 0, 1.0);
        animation = [CABasicAnimation animationWithKeyPath:@"transform"];
        animation.fromValue = NSCATransform3D(self.layer.transform);
        animation.toValue = NSCATransform3D(first);
        animation.duration = duration / 2.0;
        animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        animation.removedOnCompletion = NO;
        animation.beginTime = CACurrentMediaTime() + delay;
        animation.fillMode = kCAFillModeForwards;
        [self addAnimation:animation];
        secondBeginTime = CACurrentMediaTime() + duration / 2.0 + delay;
    }
    
    animation = [CABasicAnimation animationWithKeyPath:@"transform"]; 	// Create a basic animation to animate the layer's transform
    animation.toValue = NSCATransform3D(second); 	// Assign the transform as the animation's value
    animation.autoreverses = YES;
    animation.duration = duration;
    animation.repeatCount = HUGE_VALF;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.beginTime = secondBeginTime;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    [self addAnimation:animation];
    
    
}
- (void) wiggleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay rotation:(CGFloat)angle{
    [self wiggleWithDuration:duration delay:delay betweenAngleOne:angle angleTwo:-angle];
}

- (void) runForrestRunToPoint:(CGPoint)point withCompletion:(void (^)(BOOL finished))completion{
    
    [self runForrestRunWithDuration:1 delay:0 toPoint:point completion:completion];
    
}
- (void) runForrestRunWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay toPoint:(CGPoint)point completion:(void (^)(BOOL finished))completion{
    
    CGAffineTransform baseTransform = self.transform;
    [UIView animateWithDuration:duration/1.5 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:0.4 options:UIViewAnimationOptionAutoreverse animations:^{

        CGAffineTransform transform = baseTransform;
        transform.c = 0.5;
        self.transform = transform;
    }completion:^(BOOL finished){
        self.transform = baseTransform;
    }];
    
    
    
    
    
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.6 initialSpringVelocity:0.4 options:0 animations:^{
        self.center = point;
    }completion:completion];
    
}

@end
