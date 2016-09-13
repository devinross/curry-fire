//
//  UIView+TwelvePrinciples.h
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

@import UIKit;
@import curry;


/** Additional functionality for `UIView` to animate. */
@interface UIView (TwelvePrinciples)


#pragma mark Zoom

/** Zoom view to point.
 @param endYPoint The place to zoom to.
 @param completion The completion callback handler.
 */
- (void) zoomToYPoint:(CGFloat)endYPoint completion:(void (^)(BOOL finished))completion;

/** Zoom view to point.
 @param endYPoint The place to zoom to.
 @param duration The duration of the animation.
 @param delay The delay before the animation is played.
 @param completion The completion callback handler.
 */
- (void) zoomToYPoint:(CGFloat)endYPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;

/** Zoom view to point.
 @param endYPoint The place to zoom to.
 @param anticipation How much of a windup the view moves before zooming off.
 @param duration The duration of the animation.
 @param delay The delay before the animation is played.
 @param completion The completion callback handler.
 */
- (void) zoomToYPoint:(CGFloat)endYPoint anticipation:(CGFloat)anticipation duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;


- (void) turnOnADimeAtXPoint:(CGFloat)endXPoint duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;

/** Zoom view to point.
 @param endXPoint The place to zoom to.
 @param completion The completion callback handler.
 */
- (void) zoomToXPoint:(CGFloat)endXPoint completion:(void (^)(BOOL finished))completion;


#pragma mark Shake
/** Shake the view.
 @param completion The completion callback handler.
 */
- (void) shakeAnimationWithCompletion:(void (^)(BOOL finished))completion;

/** Shake the view.
 @param duration The duration of the animation.
 @param delay The delay before the animation is played.
 @param completion The completion callback handler.
 */
- (void) shakeAnimationWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;


- (void) hop;
- (void) hopWithToXPoint:(CGFloat)xPoint hopHeight:(CGFloat)hopHeight duration:(NSTimeInterval)duration delay:(NSTimeInterval)delay completion:(void (^)(BOOL finished))completion;

#pragma mark Wiggle
/** Wiggle the view.
 */
- (void) wiggle;

/** Wiggle the view.
 @param angle The range the view wiggle.
 */
- (void) wiggleWithRotation:(CGFloat)angle;

/** Wiggle the view.
 @param duration The duration of the animation.
 @param delay The delay before the animation is played.
 @param angle The range the view wiggle.
 */
- (void) wiggleWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay rotation:(CGFloat)angle;


#pragma mark Run Forrest
/** Run forrest. Run.
 @param point The place run to.
 @param completion The completion callback handler.
 */
- (void) runForrestRunToPoint:(CGPoint)point withCompletion:(void (^)(BOOL finished))completion;


/** Run forrest. Run.
 @param duration The duration of the animation.
 @param delay The delay before the animation is played.
 @param point The place run to.
 @param completion The completion callback handler.
 */
- (void) runForrestRunWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay toPoint:(CGPoint)point completion:(void (^)(BOOL finished))completion;

@end
