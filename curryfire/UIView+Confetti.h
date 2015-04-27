//
//  UIView+Confetti.h
//  curryfire
//
//  Created by Devin Ross on 4/22/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import UIKit;
@import QuartzCore;
@import curry;

@interface UIView (Confetti)

- (void) rainConfetti;

- (void) confettiAnimationWithCompletion:(void (^)(BOOL complete))block;

- (void) confettiAnimationWithCompletion:(void (^)(BOOL complete))block numberOfRowsAndColumns:(NSInteger)rowsAndColumns;

@end
