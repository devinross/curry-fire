//
//  RingViewController.m
//  Examples
//
//  Created by Devin Ross on 5/1/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "ProgressRingViewController.h"

@interface ProgressRingViewController ()

@end

@implementation ProgressRingViewController

- (void) loadView{
    [super loadView];
    self.view.backgroundColor = [UIColor blackColor];
    
    CGRect rr = CGRectInset(self.view.bounds, 0, 0);
    
    self.progreessRingOne = [[TKProgressRingView alloc] initWithFrame:rr radius:66+31+31 strokeWidth:30];
    self.progreessRingOne.progressColor = [UIColor colorWithHex:0xe40520];
    [self.view addSubview:self.progreessRingOne];
    
    self.progreessRingTwo = [[TKProgressRingView alloc] initWithFrame:rr radius:66+31 strokeWidth:30];
    self.progreessRingTwo.progressColor = [UIColor colorWithHex:0x3fde00];
    [self.view addSubview:self.progreessRingTwo];
    
    self.progreessRingThree = [[TKProgressRingView alloc] initWithFrame:rr radius:66 strokeWidth:30];
    self.progreessRingThree.progressColor = [UIColor colorWithHex:0x00c0df];
    [self.view addSubview:self.progreessRingThree];
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    [self.progreessRingOne setProgress:0.3 duration:1];
    [self.progreessRingTwo setProgress:0.65 duration:1];
    [self.progreessRingThree setProgress:0.8 duration:1];

}

@end
