//
//  DashboardViewController.m
//  Examples
//
//  Created by Devin Ross on 4/23/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "DashboardViewController.h"
#import "CartViewController.h"

@interface DashboardViewController ()

@end

@implementation DashboardViewController

- (instancetype) init{
    if(!(self=[super init])) return nil;
    self.cartViewController = [[CartViewController alloc] init];
    self.title = @"Dash";
    return self;
}


- (void) loadView{
    [super loadView];
    
    
    self.cartViewController.view.frame = CGRectMake(0, self.view.height-200, self.cartViewController.view.width, self.cartViewController.view.height);
    self.cartViewController.presenterViewController = self;
    [self.view addSubview:self.cartViewController.view];
    
    self.cartViewController.moveGesture.locations = @[@(self.cartViewController.view.centerY),@(self.view.middle.y)];
    
    
    
    
    [self.cartViewController.view addTapGestureWithHandler:^(UIGestureRecognizer *sender) {
        [self.navigationController presentViewController:self.cartViewController animated:YES completion:nil];
    }];
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

@end



