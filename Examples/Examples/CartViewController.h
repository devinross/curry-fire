//
//  CartViewController.h
//  Examples
//
//  Created by Devin Ross on 4/23/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import UIKit;
@import curry;
@import curryfire;


@interface CartViewController : TKCustomPresentationViewController


@property (nonatomic,strong) TKMoveGestureRecognizer *moveGesture;

@property (nonatomic,strong) UIView *backgroundView;
@property (nonatomic,strong) UIImageView *snapShotView;
@property (nonatomic,strong) UIImageView *blurView;


@property (nonatomic,weak) UIViewController *presenterViewController;


@end
