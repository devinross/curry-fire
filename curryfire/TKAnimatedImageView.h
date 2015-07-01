//
//  TKAnimatedImageView.h
//  Created by Devin Ross on 5/21/15.
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

/** `TKAnimatedImageView` is a reimplementation of UIImageView animated images with better access to the current frame in the animation sequence. */
@interface TKAnimatedImageView : UIImageView

/** Play an animation sequence with the given image frames. 
 @param images A array of `UIImage` objects.
 @param duration The duration of the animation.
 @param completion The completion block called upon the animation completing.
 */
- (void) playAnimationWithImages:(NSArray*)images duration:(NSTimeInterval)duration withCompletionBlock:(void (^)(BOOL finished))completion;

/** Play an animation sequence with the given image frames.
 @param images A array of `UIImage` objects.
 @param duration The duration of the animation.
 @param repeatCount The number of times the animation sequence plays.
 @param completion The completion block called upon the animation completing.
 */
- (void) playAnimationWithImages:(NSArray*)images duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount withCompletionBlock:(void (^)(BOOL finished))completion;


/** Stop animating. */
- (void) stopAnimating;


/** Returns the image of the current frame being displayed */
@property (nonatomic,readonly) UIImage *currentImage;

/** The current frame index. */
@property (nonatomic,readonly) NSInteger currentFrame;

@end
