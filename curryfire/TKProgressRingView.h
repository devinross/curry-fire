//
//  TKProgressRingView.h
//  Created by Devin Ross on 1/12/15.
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
@import pop;


/** The axis that a move gesture could move in. */
typedef enum {
	TKProgressRingAnimationCurveLinear = 0,
	TKProgressRingAnimationCurveQuadratic = 1,
	TKProgressRingAnimationCurveSpring = 2,
} TKProgressRingAnimationCurve;


/** `TKProgressRingView` is a view designed to animate a progress similiar to that in that in the Activity app. */
@interface TKProgressRingView : UIView

/** Initializes and returns a progress ring of the given frame, radius and stroke width. 
 @param frame The frame of the rectangle.
 @param radius The radius for the the ring.
 @param strokeWidth The width of the ring.
 @return An instance of the progress ring or nil.
 */
- (instancetype) initWithFrame:(CGRect)frame radius:(CGFloat)radius strokeWidth:(CGFloat)strokeWidth;

/** The progress of the circle. */
@property (nonatomic,assign) CGFloat progress;

/** The progress of the circle. */
@property (nonatomic,assign) TKProgressRingAnimationCurve curve;

/** The radius of the circle. */
@property (nonatomic,assign) CGFloat radius;

/** The width of the ring. */
@property (nonatomic,assign) CGFloat strokeWidth;

/** The image used by the progress meter. Typically its a radial gradient image */
@property (nonatomic,strong) UIImage *progressImage;

/** The progress color. */
@property (nonatomic,strong) UIColor *progressColor;

/** Set the progress by animating.
 @param progress The progress that the ring will be set to.
 @param animated A flag to have the progress set by animation.
 */
- (void) setProgress:(CGFloat)progress animated:(BOOL)animated;

/** Set the progress by animating.
 @param progress The progress that the ring will be set to.
 @param duration The duration of the animation.
 */
- (void) setProgress:(CGFloat)progress duration:(NSTimeInterval)duration;

/** The circle layer. */
@property (nonatomic,strong) CAShapeLayer *circleLayer;

/** The layer thats used to give the background a color. */
@property (nonatomic,strong) CAShapeLayer *fullCircleLayer;

/** The view that displays the image for a background image. */
@property (nonatomic,strong) UIImageView *baseGradientView;

/** The view that displays the image for a progress ring image. */
@property (nonatomic,strong) UIImageView *progressGradientView;


@property (nonatomic,strong) POPSpringAnimation *springAnimation;


@end
