//
//  ViewController.m
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

#import "ViewController.h"


@implementation ViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CGFloat cubeWidth = 90, inset = 70, dotWidth = 10;
    CGRect rect;
    UIView *notch1, *notch2, *notch3;

    rect = CGRectCenteredXInRect(self.view.bounds, inset + cubeWidth/2, dotWidth, dotWidth);
    notch1 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dotWidth / 2];
    [self.view addSubview:notch1];

    rect = CGRectCenteredInRect(self.view.bounds, dotWidth, dotWidth);
    notch2 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dotWidth / 2];
    [self.view addSubview:notch2];

    rect = CGRectCenteredXInRect(self.view.bounds, self.view.height  - inset - cubeWidth/2 - dotWidth/2, dotWidth, dotWidth);
    notch3 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dotWidth / 2];
    [self.view addSubview:notch3];

    rect = CGRectCenteredXInRect(self.view.bounds, inset, cubeWidth, cubeWidth);
    self.peg = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithHex:0xf9b307] cornerRadius:8];
    [self.view addSubview:self.peg];
    

    NSArray *locs = @[@(notch1.center.y),@(notch2.center.y),@(notch3.center.y)]; //@[NSCGPoint(notch1.center),NSCGPoint(notch2.center),NSCGPoint(notch3.center)]; //
    TKMoveGestureRecognizer *gesture;
    gesture = [TKMoveGestureRecognizer gestureWithDirection:TKMoveGestureDirectionY movableView:self.peg locations:locs moveHandler:^(TKMoveGestureRecognizer *gesture, CGPoint position,CGPoint location) {
        
        TKLog(@"%@",NSCGPoint(position));
        
    }];
    [self.view addGestureRecognizer:gesture];

}

@end
