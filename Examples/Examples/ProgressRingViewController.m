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
	self.progreessRingOne.curve = TKProgressRingAnimationCurveSpring;
    [self.view addSubview:self.progreessRingOne];
	self.progreessRingOne.progress = 0.001;
    
    self.progreessRingTwo = [[TKProgressRingView alloc] initWithFrame:rr radius:66+31 strokeWidth:30];
    self.progreessRingTwo.progressColor = [UIColor colorWithHex:0x3fde00];
	self.progreessRingTwo.curve = TKProgressRingAnimationCurveQuadratic;
    [self.view addSubview:self.progreessRingTwo];
	self.progreessRingTwo.progress = 0.001;

    
    self.progreessRingThree = [[TKProgressRingView alloc] initWithFrame:rr radius:66 strokeWidth:30];
    self.progreessRingThree.progressColor = [UIColor colorWithHex:0x00c0df];
    [self.view addSubview:self.progreessRingThree];
	self.progreessRingThree.curve = TKProgressRingAnimationCurveLinear;
	self.progreessRingThree.progress = 0.001;

}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];

	
	

		
	[self.progreessRingThree setProgress:0.20 duration:0.3];

	double delayInSeconds = 0.5;
	dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
	dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
	
		[self.progreessRingTwo setProgress:0.45 duration:1];

		
		double delayInSeconds = 0.8;
		dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
		dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
			
			[self.progreessRingOne setProgress:0.65 duration:1];
			
			
		});
		
	});
		


}

@end
