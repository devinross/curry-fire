//
//  PageControlViewController.m
//  Examples
//
//  Created by Devin Ross on 3/27/16.
//  Copyright © 2016 Devin Ross. All rights reserved.
//

#import "PageControlViewController.h"

@interface PageControlViewController ()

@end

@implementation PageControlViewController

- (void) loadView{
	[super loadView];
	self.view.backgroundColor = [UIColor whiteColor];
	
	self.pageControl = [[TKPageControl alloc] initWithFrame:CGRectMake(0, 180, self.view.width, 40)];
	self.pageControl.numberOfPages = 5;
	self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
	self.pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0 alpha:0.3];
	[self.view addSubview:self.pageControl];
	
}

@end
