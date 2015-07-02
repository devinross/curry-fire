//
//  Positioning+UIScrollView.m
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

#import "UIScrollView+Positioning.h"

@implementation UIScrollView (Positioning)

- (CGFloat) contentWidth{
	return self.contentSize.width;
}
- (void) setContentWidth:(CGFloat)contentWidth{
	self.contentSize = CGSizeMake(contentWidth, self.contentSize.height);
}
- (CGFloat) contentHeight{
	return self.contentSize.height;
}
- (void) setContentHeight:(CGFloat)contentHeight{
	self.contentSize = CGSizeMake(self.contentSize.width, contentHeight);
}

- (CGFloat) contentXOffset{
	return self.contentOffset.x;
}
- (CGFloat) contentYOffset{
	return self.contentOffset.y;
}


- (void) setContentXOffset:(CGFloat)contentXOffset{
	self.contentOffset = CGPointMake(contentXOffset, self.contentOffset.y);
}

- (void) setContentYOffset:(CGFloat)contentYOffset{
	self.contentOffset = CGPointMake(self.contentOffset.x, contentYOffset);
}

@end
