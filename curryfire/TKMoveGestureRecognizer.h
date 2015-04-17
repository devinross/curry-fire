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

@interface TKMoveGestureRecognizer : UIPanGestureRecognizer

+ (instancetype) gestureWithMovableView:(UIView*)movableView locations:(NSArray*)locations;
+ (instancetype) gestureWithMovableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location ))block;

- (instancetype) initWithMovableView:(UIView*)movableView;
- (instancetype) initWithMovableView:(UIView*)movableView locations:(NSArray*)locations;
- (instancetype) initWithMovableView:(UIView *)movableView locations:(NSArray*)locations moveHandler:(void (^)(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location ))block;

@property (nonatomic, copy, setter = setMoveHandler:) void (^moveHandler)(TKMoveGestureRecognizer *gesture, CGPoint position, CGPoint location);

@property (nonatomic,readonly) BOOL moving;
@property (nonatomic,strong) UIView *movableView;
@property (nonatomic,strong) NSArray *locations;
@property (nonatomic,strong) POPSpringAnimation *snapBackAnimation;

@property (nonatomic,assign) CGFloat velocityDamping;

@end
