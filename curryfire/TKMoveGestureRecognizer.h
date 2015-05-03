//
//  TKMoveViewGestureRecognizer.h
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

@import UIKit;
@import pop;
@import curry;

typedef enum {
    TKMoveGestureDirectionXY = 0,
    TKMoveGestureDirectionX = 1,
    TKMoveGestureDirectionY = 2,
} TKMoveGestureDirection;


@interface TKMoveGestureRecognizer : UIPanGestureRecognizer

+ (instancetype) gestureWithDirection:(TKMoveGestureDirection)direction movableView:(UIView*)movableView;
+ (instancetype) gestureWithDirection:(TKMoveGestureDirection)direction movableView:(UIView*)movableView locations:(NSArray*)locations;
+ (instancetype) gestureWithDirection:(TKMoveGestureDirection)direction movableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location ))block;

- (instancetype) initWithDirection:(TKMoveGestureDirection)direction movableView:(UIView*)movableView;
- (instancetype) initWithDirection:(TKMoveGestureDirection)direction movableView:(UIView*)movableView locations:(NSArray*)locations;
- (instancetype) initWithDirection:(TKMoveGestureDirection)direction movableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location ))block;

@property (nonatomic,copy,setter=setMoveHandler:) void (^moveHandler)(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location);

@property (nonatomic,readonly) TKMoveGestureDirection direction;

@property (nonatomic,readonly) BOOL moving;
@property (nonatomic,readonly) BOOL animating;

@property (nonatomic,strong) UIView *movableView;
@property (nonatomic,strong) NSArray *locations;
@property (nonatomic,strong) POPSpringAnimation *snapBackAnimation;
@property (nonatomic,assign) CGFloat velocityDamping;


- (void) moveToPoint:(CGPoint)point;


@end
