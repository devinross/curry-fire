//
//  UIView+GestureRecognizerBlock.h
//  Created by Devin Ross on 4/17/15.
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

/** Additional functionality to `UIView` to add gesture */
@interface UIView (GestureRecognizerBlock)

/** Add a `UITapGesture` with a callback handler.
 @param block The callback handler.
 */
- (UITapGestureRecognizer*) addTapGestureWithHandler:(void (^)(UIGestureRecognizer *sender))block;

/** Add a `UITapGesture` with a target and action.
 @param target The target.
 @param action The action.
 */
- (UITapGestureRecognizer*) addTapGestureWithTarget:(id)target action:(SEL)action;


@end
