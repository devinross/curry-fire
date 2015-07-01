//
//  Positioning+UIScrollView.h
//  Created by Devin Ross on 7/1/15.
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

/** Additional functionality dealing with `UIScrollView` positioning. */
@interface UIScrollView (Positioning)

/** Returns the content width of a scroll-view. */
@property (nonatomic,assign) CGFloat contentWidth;

/** Returns the content height of a scroll-view. */
@property (nonatomic,assign) CGFloat contentHeight;

/** Returns the content x offset of a scroll-view. */
@property (nonatomic,assign) CGFloat contentXOffset;

/** Returns the content y offset of a scroll-view. */
@property (nonatomic,assign) CGFloat contentYOffset;

@end
