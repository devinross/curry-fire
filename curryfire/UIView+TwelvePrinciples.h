//
//  UIView+TwelvePrinciples.h
//  curryfire
//
//  Created by Devin Ross on 4/22/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import UIKit;
@import curry;

@interface UIView (TwelvePrinciples)

- (void) zoomToYPoint:(CGFloat)endYPoint completion:(void (^)(BOOL finished))completion;
- (void) zoomToYPoint:(CGFloat)endYPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;

- (void) zoomToXPoint:(CGFloat)endXPoint completion:(void (^)(BOOL finished))completion;


- (void) tickle;
- (void) tickleWithCompletion:(void (^)(BOOL finished))completion;
- (void) tickleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;


- (void) shakeAnimationWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;
- (void) shakeAnimationWithCompletion:(void (^)(BOOL finished))completion;

- (void) wiggle;
- (void) wiggleWithRotation:(CGFloat)angle;
- (void) wiggleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay rotation:(CGFloat)angle;


- (void) runForrestRunToPoint:(CGPoint)point withCompletion:(void (^)(BOOL finished))completion;
- (void) runForrestRunWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay toPoint:(CGPoint)point completion:(void (^)(BOOL finished))completion;

@end
