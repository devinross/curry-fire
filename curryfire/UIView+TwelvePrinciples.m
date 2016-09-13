//
//  UIView+TwelvePrinciples.m
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

#import "UIView+TwelvePrinciples.h"
#import "ShortHand.h"


@implementation UIView (TwelvePrinciples)


- (void) zoomToYPoint:(CGFloat)endYPoint completion:(void (^)(BOOL finished))completion{
    [self zoomToYPoint:endYPoint duration:0.7 delay:0 completion:completion];
}


- (void) zoomToYPoint:(CGFloat)endYPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion{
	[self zoomToYPoint:endYPoint anticipation:30 duration:duration delay:delay completion:completion];
}

- (void) zoomToYPoint:(CGFloat)endYPoint anticipation:(CGFloat)anticipation duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion{
	
	CGAffineTransform baseTransform = self.transform;
	
	if(endYPoint > self.centerY){
		CGFloat yy = CGRectGetMinY(self.frame);
		self.layer.anchorPoint = CGPointMake(0.5, 0);
		self.center = CGPointMake(self.centerX, yy);
		anticipation *= -1;
	}else{
		CGFloat yy = CGRectGetMaxY(self.frame);
		self.layer.anchorPoint = CGPointMake(0.5, 1);
		self.center = CGPointMake(self.centerX, yy);
	}
	
	
	CGFloat xScale = 1, yScale = 1;
	
	[UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
		
		[UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.2 animations:^{
			self.transform = CGConcat(baseTransform, CGScale(xScale+0.1, yScale-0.3));
		}];
		
	
		
		[UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.3 animations:^{
			self.transform = CGScale(xScale-0.3, yScale+0.3);
		}];
		
		[UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.4 animations:^{
			self.centerY += anticipation;
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


- (void) hop{
	[self hopWithToXPoint:self.superview.width * 1.5 hopHeight:40 duration:0.7 delay:0 completion:nil];
}
- (void) hopWithToXPoint:(CGFloat)xPoint hopHeight:(CGFloat)hopHeight duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion{
	
	CGFloat y = self.center.y;
	CGAffineTransform baseTransform = self.transform;
	
	CGPoint midPoint = CGPointGetMidpoint(self.center, CGPointMake(xPoint, self.centerY));
	
	[UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
		
		[UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
			self.transform = CGConcat(CGScale(0.8, 1), CGRotate(-15 * M_PI / 180));
		}];
		[UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.3 animations:^{
			self.center = CGPointMake(midPoint.x, y - hopHeight);
			self.transform = CGConcat(CGScale(1.4, 1), CGRotate(0 * M_PI / 180));
		}];
		[UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations:^{
			self.center = CGPointMake(xPoint, y);
		}];
		[UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.2 animations:^{
			self.transform = CGConcat(CGScale(1.1, 1), CGRotate(15 * M_PI / 180));
		}];
		[UIView addKeyframeWithRelativeStartTime:0.8 relativeDuration:0.2 animations:^{
			self.transform = baseTransform;
		}];
		
	}completion:completion];
	
}



- (void) turnOnADimeAtXPoint:(CGFloat)endXPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion{
	
	BOOL movingRight = endXPoint > self.centerX;

	CGFloat anchorX = movingRight ? self.maxX : self.minX;
	CGFloat anchorY = self.maxY;
	CGFloat mult = movingRight ? 1 : -1;
	self.layer.anchorPoint = movingRight ? CGPointMake(1, 1) : CGPointMake(0, 1);
	
	CGFloat twist = movingRight ? 0.1 : -0.1;
	CGAffineTransform twistTransform = CGAffineTransformIdentity;
	twistTransform.c = twist;
	
	CGFloat x = endXPoint + (movingRight ? 1 : -1) * self.width / 2;
	self.center = CGPointMake(anchorX, anchorY);
	
	[UIView animateKeyframesWithDuration:duration delay:delay options:UIViewKeyframeAnimationOptionCalculationModeCubic animations:^{
		
		double s = 0.0, dur = 0.3;
		
		[UIView addKeyframeWithRelativeStartTime:s relativeDuration:dur/2 animations:^{
			self.transform = twistTransform;
		}];
		
		[UIView addKeyframeWithRelativeStartTime:s + dur/2 relativeDuration:dur/2 animations:^{
			CGAffineTransform transform = CGAffineTransformIdentity;
			transform.c = 0;
			self.transform = transform;
		}];
		
		
		[UIView addKeyframeWithRelativeStartTime:s relativeDuration:dur animations:^{
			self.center = CGPointMake(x + 20 * mult, anchorY);
		}];
		
		s += dur;
		dur = 0.2;
		
		[UIView addKeyframeWithRelativeStartTime:s relativeDuration:dur animations:^{
			CGAffineTransform transform = CGAffineTransformIdentity;
			transform.c = 0;
			transform = CGConcat(transform, CGRotate(-2 * M_PI / 180.0f));
			self.transform = transform;
			self.center = CGPointMake(x + 30 * mult, anchorY-16);
		}];
		
		s += dur;
		dur = 0.2;
		
		[UIView addKeyframeWithRelativeStartTime:s relativeDuration:dur animations:^{
			CGAffineTransform transform = CGAffineTransformIdentity;
			transform.c = 0;
			transform = CGConcat(transform, CGRotate(-1 * M_PI / 180.0f));
			self.transform = transform;
			self.center = CGPointMake(x + 15 * mult, anchorY-20);
		}];
		
		s += dur;
		dur = 0.2;
		
		[UIView addKeyframeWithRelativeStartTime:s relativeDuration:dur  animations:^{
			CGAffineTransform transform = CGAffineTransformIdentity;
			transform = CGConcat(transform, CGRotate(0 * M_PI / 180.0f));
			self.transform = transform;
			self.center = CGPointMake(x, anchorY);
		}];
		
		
	} completion:^(BOOL finished) {
		
		
		CGFloat xx = CGRectGetMidX(self.frame), yy = CGRectGetMidY(self.frame);
		
		self.layer.anchorPoint = CGPointMake(0.5, 0.5);
		self.center = CGPointMake(xx,yy);
		
		if(completion)
			completion(finished);
		
	}];

	
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
	
	
	BOOL movingRight = point.x > self.centerX;
	
    CGAffineTransform baseTransform = self.transform;
	CGAffineTransform transform = baseTransform;
	transform.c = movingRight ? 0.5 : -0.5;

	CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform"];
	animation.autoreverses = YES;
	animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(baseTransform)];
	animation.toValue = [NSValue valueWithCATransform3D:CATransform3DMakeAffineTransform(transform)];
	animation.duration = duration / 4;
	[self.layer addAnimation:animation forKey:@"forrest"];
    
	
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.4 options:0 animations:^{
        self.center = point;
    }completion:completion];
    
}

@end
