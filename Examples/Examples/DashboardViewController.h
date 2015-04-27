//
//  DashboardViewController.h
//  Examples
//
//  Created by Devin Ross on 4/23/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import UIKit;
@import curry;
@import curryfire;

@class CartViewController;

@interface DashboardViewController : UIViewController


@property (nonatomic,strong) CartViewController *cartViewController;

@end


