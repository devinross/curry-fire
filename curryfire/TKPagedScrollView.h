//
//  TKPagedScrollView.h
//  curryfire
//
//  Created by Devin Ross on 6/18/15.
//  Copyright (c) 2015 Devin Ross. All rights reserved.
//

@import curry;
@import UIKit;

@class TKPagedScrollView;

@protocol TKPagedScrollViewDelegate <NSObject>

@optional

- (void) pagedScrollViewDidScroll:(TKPagedScrollView *)scrollView;


- (void) pagedScrollView:(TKPagedScrollView *)scrollView didMoveToPage:(NSInteger)page;



- (void) pagedScrollViewWillBeginDragging:(TKPagedScrollView *)scrollView;
- (void) pagedScrollViewDidEndDragging:(TKPagedScrollView *)scrollView willDecelerate:(BOOL)decelerate;

- (void) pagedScrollViewWillBeginDecelerating:(TKPagedScrollView *)scrollView;
- (void) pagedScrollViewDidEndDecelerating:(TKPagedScrollView *)scrollView;
- (void) pagedScrollViewDidEndScrollingAnimation:(TKPagedScrollView *)scrollView;

- (BOOL) pagedScrollViewShouldScrollToTop:(TKPagedScrollView *)scrollView;
- (void) pagedScrollViewDidScrollToTop:(TKPagedScrollView *)scrollView;


@end


typedef NS_ENUM(NSUInteger, TKPageScrollDirection) {
    TKPageScrollDirectionVertical,
    TKPageScrollDirectionHorizontal
};


@interface TKPagedScrollView : UIView

- (id) initWithFrame:(CGRect)frame direction:(TKPageScrollDirection)direction;

@property (nonatomic,readonly) TKPageScrollDirection scrollDirection;

@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic,strong) NSArray *pages;
@property (nonatomic,assign) NSInteger currentPage;

@property (nonatomic,weak) id<TKPagedScrollViewDelegate>delegate;

- (void) scrollToPreviousPage;
- (void) scrollToNextPage;

@end
