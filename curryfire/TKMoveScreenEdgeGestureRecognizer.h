//
//  TKMoveScreenEdgeGestureRecognizer.h
//  Created by Devin Ross on 6/12/15.
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
#import "TKMoveGestureRecognizer.h"

/** `TKMoveScreenEdgeGestureRecognizer` is a screen-edge-pan-gesture-recognizer built to move a view between certain locations. */
@interface TKMoveScreenEdgeGestureRecognizer : UIScreenEdgePanGestureRecognizer

/** Creates and returns a gesture recognizer to move a view between points.
 @param movableView The view that the gesture will move.
 @param axis The directions the movable can move in.
 @return A newly minted move-gesture-recognizer.
 */
+ (instancetype) gestureWithAxis:(TKMoveGestureAxis)axis movableView:(UIView*)movableView;

/** Creates and returns a gesture recognizer to move a view between points.
 @param movableView The view that the gesture will move.
 @param axis The directions the movable can move in.
 @param locations An array of locations that the view can move to. If the axis is X&Y, then the array should contain `NSValue` objects with a `CGPoint`. Otherwise, it should an array of `NSNumbers`.
 @return A newly minted move-gesture-recognizer.
 */
+ (instancetype) gestureWithAxis:(TKMoveGestureAxis)axis movableView:(UIView*)movableView locations:(NSArray*)locations;

/** Creates and returns a gesture recognizer to move a view between points.
 @param movableView The view that the gesture will move.
 @param axis The directions the movable can move in.
 @param locations An array of locations that the view can move to. If the axis is X&Y, then the array should contain `NSValue` objects with a `CGPoint`. Otherwise, it should an array of `NSNumbers`.
 @param block A callback block for the gesture-recognizer.
 @return A newly minted move-gesture-recognizer.
 */
+ (instancetype) gestureWithAxis:(TKMoveGestureAxis)axis movableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveScreenEdgeGestureRecognizer *gesture, CGPoint position, CGPoint location ))block;

/** Creates and returns a gesture recognizer to move a view between points.
 @param movableView The view that the gesture will move.
 @param axis The directions the movable can move in.
 @return A newly minted move-gesture-recognizer.
 */
- (instancetype) initWithAxis:(TKMoveGestureAxis)axis movableView:(UIView*)movableView;

/** Creates and returns a gesture recognizer to move a view between points.
 @param movableView The view that the gesture will move.
 @param axis The directions the movable can move in.
 @param locations An array of locations that the view can move to. If the axis is X&Y, then the array should contain `NSValue` objects with a `CGPoint`. Otherwise, it should an array of `NSNumbers`.
 @return A newly minted move-gesture-recognizer.
 */
- (instancetype) initWithAxis:(TKMoveGestureAxis)axis movableView:(UIView*)movableView locations:(NSArray*)locations;

/** Creates and returns a gesture recognizer to move a view between points.
 @param movableView The view that the gesture will move.
 @param axis The directions the movable can move in.
 @param locations An array of locations that the view can move to. If the axis is X&Y, then the array should contain `NSValue` objects with a `CGPoint`. Otherwise, it should an array of `NSNumbers`.
 @param block A callback block for the gesture-recognizer.
 @return A newly minted move-gesture-recognizer.
 */
- (instancetype) initWithAxis:(TKMoveGestureAxis)axis movableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveScreenEdgeGestureRecognizer *gesture, CGPoint position, CGPoint location ))block;

/** The callback of the gesture-recognizer. */
@property (nonatomic,copy,setter=setMoveHandler:) void (^moveHandler)(TKMoveScreenEdgeGestureRecognizer *gesture, CGPoint position, CGPoint location);

/** The directions the movable can go. */
@property (nonatomic,readonly) TKMoveGestureAxis axis;

/** A flag that indicates if the gesture is active. */
@property (nonatomic,readonly) BOOL moving;

/** A flag that indicates if the movable view is moving to a resting location. */
@property (nonatomic,readonly) BOOL animating;

/** If YES, it keeps the view within the location bounds. Otherwise NO. */
@property (nonatomic,assign) BOOL canMoveOutsideLocationBounds;

/** The view that the gesture will move. */
@property (nonatomic,strong) UIView *movableView;

/** Resting locations for the movable view. */
@property (nonatomic,strong) NSArray *locations;

/** The POPSpringAnimation used to animate the movable view to a resting place. */
@property (nonatomic,strong) POPSpringAnimation *snapBackAnimation;

/** Reduces the velocity used to determine the resting location after a gesture. */
@property (nonatomic,assign) CGFloat velocityDamping;

/** Animates the movable view to a certain point.
 @param point The point the movable view will relocate to.
 */
- (void) moveToPoint:(CGPoint)point;

@end
