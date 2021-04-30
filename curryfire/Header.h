//
//  Header.h
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

#ifndef curryfire_Header_h
#define curryfire_Header_h

#if TARGET_OS_IOS
@import curry;
@import pop;
#endif

#if TARGET_OS_TV
@import curryTV;
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
#import <curryfire/ShortHand.h>
#endif

#if TARGET_OS_IOS
#import <curryfire/TKMoveGestureRecognizer.h>
#import <curryfire/TKInteractiveMoveTransition.h>
#import <curryfire/TKNavigationTransistionController.h>
#endif

#if TARGET_OS_IOS || TARGET_OS_TV
#import <curryfire/TKAnimatedCounterLabel.h>
#import <curryfire/TKProgressRingView.h>
#import <curryfire/UIView+Confetti.h>
#endif


#endif
