//
//  TKAnimatedCounterLabel.h
//  Created by Devin Ross on 1/14/15.
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

/** The curve that the progress will animate at. */
typedef enum {
	TKAnimatedCounterLabelAnimationCurveLinear = 0,
	TKAnimatedCounterLabelAnimationCurveQuadratic = 1,
	TKAnimatedCounterLabelAnimationCurveSpring = 2,
} TKAnimatedCounterLabelAnimationCurve;


/** `TKAnimatedCounterLabel` is a label used specifically to animate the counting up or down of a number.  */
@interface TKAnimatedCounterLabel : UIView

/** The number formatter used to generate the text string for a numer. If you want to count money, you should change this to a current style formatter. */
@property (nonatomic,strong) NSNumberFormatter *numberFormatter;

/** The progress of the circle. */
@property (nonatomic,assign) TKAnimatedCounterLabelAnimationCurve curve;


/* The current text to this number with animating.
 @param number The number.
 */
- (void) setNumber:(NSNumber *)number;


/* The current text to this number with animating.
 @param number The number.
 @param animated The duration of the animation.
 */
- (void) setNumber:(NSNumber *)number animated:(BOOL)animated;

/* The current text to this number with animating.
 @param number The number.
 @param duration The duration of the animation.
 */
- (void) setNumber:(NSNumber *)number duration:(NSTimeInterval)duration;

/* The current text to this number with animating.
 @param number The number.
 @param duration The duration of the animation.
 @param completion The completion callback.
 */
- (void) setNumber:(NSNumber *)number duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion;

/* The text of the label. */
@property (nonatomic,copy)  NSString *text;

/* The font of the label. */
@property (nonatomic,retain) UIFont *font;

/* The text color of the label. */
@property (nonatomic,retain) UIColor *textColor;

/* The line break mode of the label. */
@property (nonatomic,assign) NSLineBreakMode lineBreakMode;

/* The kerning of the label. */
@property (nonatomic,assign) CGFloat kerning;

/* The space inbetween characters. */
@property (nonatomic,assign) CGFloat characterPadding;

/* The text alignment of the label. */
@property (nonatomic,assign) NSTextAlignment textAlignment;

/* Default is '9'. The character width of each character is uniform so it animates nicely. The model character is the character used to figure out the character width. */
@property (nonatomic,copy) NSString *modelCharacter;

@property (nonatomic,strong) POPSpringAnimation *springAnimation;



@end
