//
//  PagedScrollViewViewController.h
//  Examples
//
//  Created by Devin Ross on 6/18/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import curry;
@import curryfire;

@interface PagedScrollViewViewController : UIViewController <TKPagedScrollViewDelegate>

@property (nonatomic,strong) TKPagedScrollView *scrollView;

@end
