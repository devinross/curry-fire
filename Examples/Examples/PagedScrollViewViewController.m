//
//  PagedScrollViewViewController.m
//  Examples
//
//  Created by Devin Ross on 6/18/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

#import "PagedScrollViewViewController.h"

@interface PagedScrollViewViewController ()

@end

@implementation PagedScrollViewViewController

- (void) loadView{
    [super loadView];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    

    
    self.scrollView = [[TKPagedScrollView alloc] initWithFrame:self.view.bounds direction:TKPageScrollDirectionVertical];
    self.scrollView.delegate = self;
    self.scrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self.view addSubview:self.scrollView];
    
    

    
    UIView *viewOne = [UIView viewWithFrame:CGRectMake(0, 0, self.view.width, 1000) backgroundColor:[UIColor randomColor]];
    
    TKGradientView *gradient = [[TKGradientView alloc] initWithFrame:viewOne.bounds];
    gradient.colors = @[[UIColor colorWithWhite:0 alpha:0.0],[UIColor colorWithWhite:0 alpha:0.5]];
    [viewOne addSubview:gradient];
    
    UIView *viewTwo = [UIView viewWithFrame:CGRectMake(0, viewOne.maxY, self.view.width, 2000) backgroundColor:[UIColor randomColor]];

    gradient = [[TKGradientView alloc] initWithFrame:viewTwo.bounds];
    gradient.colors = @[[UIColor colorWithWhite:0 alpha:0.0],[UIColor colorWithWhite:0 alpha:0.5]];
    [viewTwo addSubview:gradient];
    
    UIView *viewThree = [UIView viewWithFrame:CGRectMake(0, viewTwo.maxY, self.view.width, 2000) backgroundColor:[UIColor randomColor]];

    UIView *viewFour = [UIView viewWithFrame:CGRectMake(0, viewThree.maxY, self.view.width, 3000) backgroundColor:[UIColor randomColor]];

    
    self.scrollView.pages = @[viewOne,viewTwo,viewThree,viewFour];
    
    


    
    
    
}





@end
