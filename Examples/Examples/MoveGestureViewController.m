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

#import "MoveGestureViewController.h"


@implementation MoveGestureViewController

- (void) viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    self.toggleButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    self.toggleButton.frame = CGRectMake(0, self.view.height-50, 80, 50);
    [self.toggleButton addTarget:self action:@selector(toggle:) forControlEvents:UIControlEventTouchUpInside];
    self.toggleButton.tintColor = [UIColor blueColor];
    [self.toggleButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [self.view addSubview:self.toggleButton];
    
    CGFloat cubeWidth = 90, inset = 70, dotWidth = 10;
    CGRect rect;
    UIView *peg1, *peg2, *peg3;

    rect = CGRectCenteredXInRect(self.view.bounds, inset + cubeWidth/2, dotWidth, dotWidth);
    peg1 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dotWidth / 2];
    [self.view addSubview:peg1];

    rect = CGRectCenteredInRect(self.view.bounds, dotWidth, dotWidth);
    peg2 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dotWidth / 2];
    [self.view addSubview:peg2];

    rect = CGRectCenteredXInRect(self.view.bounds, self.view.height  - inset - cubeWidth/2 - dotWidth/2, dotWidth, dotWidth);
    peg3 = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithWhite:0.9 alpha:1] cornerRadius:dotWidth / 2];
    [self.view addSubview:peg3];

    rect = CGRectCenteredXInRect(self.view.bounds, inset, cubeWidth, cubeWidth);
    self.block = [UIView viewWithFrame:rect backgroundColor:[UIColor colorWithHex:0xf9b307] cornerRadius:8];
    [self.view addSubview:self.block];
    
    self.pegs = @[peg1,peg2,peg3];
    
    [self toggle:nil];

}

- (void) toggle:(UIButton*)sender{
    
    [self.block removeGestureRecognizer:self.block.gestureRecognizers.firstObject];
    
    if(sender.tag == 1){
        
        NSMutableArray *locations = [NSMutableArray arrayWithCapacity:self.pegs.count];
        for(UIView *peg in self.pegs)
            [locations addObject:NSCGPoint(peg.center)];
        
        TKMoveGestureRecognizer *gesture;
        gesture = [TKMoveGestureRecognizer gestureWithDirection:TKMoveGestureDirectionXY movableView:self.block locations:locations moveHandler:^(TKMoveGestureRecognizer *gesture, CGPoint position,CGPoint location) {
            TKLog(@"%f",position.y);
        }];
        [self.view addGestureRecognizer:gesture];
        
        sender.tag = 0;
        [self.toggleButton setTitle:NSLocalizedString(@"Axis: XY", @"") forState:UIControlStateNormal];

    }else{
        
        NSMutableArray *locations = [NSMutableArray arrayWithCapacity:self.pegs.count];
        for(UIView *peg in self.pegs)
            [locations addObject:@(peg.center.y)];
        
        TKMoveGestureRecognizer *gesture;
        gesture = [TKMoveGestureRecognizer gestureWithDirection:TKMoveGestureDirectionY movableView:self.block locations:locations moveHandler:^(TKMoveGestureRecognizer *gesture, CGPoint position,CGPoint location) {
            TKLog(@"%f",position.y);
        }];
        [self.view addGestureRecognizer:gesture];
        sender.tag = 1;
        [self.toggleButton setTitle:NSLocalizedString(@"Axis: Y", @"") forState:UIControlStateNormal];

    }
    
    
}

@end
