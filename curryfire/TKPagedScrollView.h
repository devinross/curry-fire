//
//  TKPagedScrollView.h
//  Created by Devin Ross on 6/18/15.
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

@import curry;
@import UIKit;

@class TKPagedScrollView;

/** The delegate for `TKPagedScrollView`. Use this delegate instead of taking `UIScrollView`'s delegate.  */
@protocol TKPagedScrollViewDelegate <NSObject>

@optional

/** Tells the delegate when the user scrolls the content view within the receiver.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 */
- (void) pagedScrollViewDidScroll:(TKPagedScrollView *)pagedScrollView;

/** The event sent when a paged scroll view will animate to a different page.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 @param page The page that will become the active page.
 */
- (void) pagedScrollView:(TKPagedScrollView *)pagedScrollView willMoveToPage:(NSInteger)page;

/** The event sent when a paged scroll view did animate to a different page.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 @param page The page that did become the active page.
 */
- (void) pagedScrollView:(TKPagedScrollView *)pagedScrollView didMoveToPage:(NSInteger)page;

/** Tells the delegate when the scroll view is about to start scrolling the content.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 */
- (void) pagedScrollViewWillBeginDragging:(TKPagedScrollView *)pagedScrollView;

/** Tells the delegate when dragging ended in the scroll view.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 @param decelerate YES if the scrolling movement will continue, but decelerate, after a touch-up gesture during a dragging operation. If the value is NO, scrolling stops immediately upon touch-up.
 */
- (void) pagedScrollViewDidEndDragging:(TKPagedScrollView *)pagedScrollView willDecelerate:(BOOL)decelerate;

/** Tells the delegate that the scroll view is starting to decelerate the scrolling movement.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 */
- (void) pagedScrollViewWillBeginDecelerating:(TKPagedScrollView *)pagedScrollView;

/** Tells the delegate that the scroll view has ended decelerating the scrolling movement.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 */
- (void) pagedScrollViewDidEndDecelerating:(TKPagedScrollView *)pagedScrollView;

/** Tells the delegate when a scrolling animation in the scroll view concludes.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 */
- (void) pagedScrollViewDidEndScrollingAnimation:(TKPagedScrollView *)pagedScrollView;


/** Asks the delegate if the scroll view should scroll to the top of the content.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 */
- (BOOL) pagedScrollViewShouldScrollToTop:(TKPagedScrollView *)pagedScrollView;

/** Tells the delegate that the scroll view scrolled to the top of the content.
 @param pagedScrollView The paged-scroll-view object in which the scrolling occurred.
 */
- (void) pagedScrollViewDidScrollToTop:(TKPagedScrollView *)pagedScrollView;


@end

/** The direction a `TKPagedScrollView` would layout pages in. */
typedef NS_ENUM(NSUInteger, TKPageScrollDirection) {
    TKPageScrollDirectionVertical,
    TKPageScrollDirectionHorizontal
};

/** `TKPagedScrollView` a scroll view container that holds a `UIScrollView`. The view acts like a `UIScrollView` that has pages of length longer than the actual scroll view frame. */
@interface TKPagedScrollView : UIView

/** Initializes and returns a paged scroll view.
 @param frame The frame for the view.
 @param direction The direction that scroll view will scroll.
 @return A newly created paged scroll view or nil.
 */
- (id) initWithFrame:(CGRect)frame direction:(TKPageScrollDirection)direction;

/** The direction a `TKPagedScrollView` would layout pages in. */
@property (nonatomic,readonly) TKPageScrollDirection scrollDirection;

/** A flag that indicates if the current page is changing. */
@property (nonatomic,readonly) BOOL animatingPages;

/** Access to the underlying `UIScrollView`. Do not take the `UIScrollView`'s delegate. */
@property (nonatomic,strong) UIScrollView *scrollView;

/** An array of views that are laid out to form the scroll view. The page size of each view is determined based on the size of the view. */
@property (nonatomic,strong) NSArray *pages;

/** The current page */
@property (nonatomic,assign) NSInteger currentPage;

/** The delegate of the paged-scroll-view object. */
@property (nonatomic,weak) id <TKPagedScrollViewDelegate> delegate;

/** Scroll to the previous page. */
- (void) scrollToPreviousPage;

/** Scroll to the next page. */
- (void) scrollToNextPage;


/** Scroll to a specific page. 
 @param page The page that will become the current one.
 @param animated Whether the change is animated or not.
 */
- (void) scrollToPage:(NSInteger)page animated:(BOOL)animated;


/** Resets the layout of the pages. */
- (void) updatePagesLayout;

@end
