//
//  UIView+Postioning.m
//  Created by Devin Ross on 4/17/15.
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

#import "UIView+Positioning.h"
@import curry;

@implementation UIView (Positioning)


- (CGPoint) convertCenterToView:(UIView*)view{
    return [self.superview convertPoint:self.center toView:view];
}
- (CGRect) convertFrameToView:(UIView*)view{
    return [self.superview convertRect:self.frame toView:view];
}

- (void) moveToView:(UIView*)view{
    self.center = [self convertCenterToView:view];
    [self removeFromSuperview];
    [view addSubview:self];
}
- (void) moveToBackOfView:(UIView*)view{
    self.center = [self convertCenterToView:view];
    [self removeFromSuperview];
    [view addSubviewToBack:self];
}

- (CGPoint) middle{
    return CGPointMake(CGFrameGetWidth(self)/2, CGFrameGetHeight(self)/2);
}

- (CGFloat) width{
    return CGFrameGetWidth(self);
}
- (void) setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat) height{
    return CGFrameGetHeight(self);
}
- (void) setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGSize) size{
    return self.frame.size;
}
- (void) setSize:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGPoint) origin{
    return self.frame.origin;
}
- (void) setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGFloat) minX{
    return CGFrameGetMinX(self);
}
- (void) setMinX:(CGFloat)minX{
    self.center = CGPointMake(minX+CGFrameGetWidth(self)/2, self.center.y);
}

- (CGFloat) minY{
    return CGFrameGetMinY(self);
}
- (void) setMinY:(CGFloat)minY{
    self.center = CGPointMake(self.center.x, minY+CGFrameGetHeight(self)/2);
}

- (CGFloat) midX{
    return CGFrameGetMidX(self);
}
- (void) setMidX:(CGFloat)midX{
    self.center = CGPointMake(midX, self.center.y);
}

- (CGFloat) midY{
    return CGFrameGetMidY(self);
}
- (void) setMidY:(CGFloat)midY{
    self.center = CGPointMake(self.center.x, midY);
}

- (CGFloat) maxX{
    return CGFrameGetMaxX(self);
}
- (void) setMaxX:(CGFloat)maxX{
    self.center = CGPointMake(maxX-CGFrameGetWidth(self)/2, self.center.y);
}

- (CGFloat) maxY{
    return CGFrameGetMaxY(self);
}
- (void) setMaxY:(CGFloat)maxY{
    self.center = CGPointMake(self.center.x, maxY-CGFrameGetHeight(self)/2);
}

- (CGFloat) originX{
    return CGFrameGetMinX(self);
}
- (void) setOriginX:(CGFloat)originX{
    self.frame = CGRectMake(originX, CGFrameGetMinY(self), CGFrameGetWidth(self),CGFrameGetHeight(self));
}

- (CGFloat) originY{
    return CGFrameGetMinY(self);
}
- (void) setOriginY:(CGFloat)originY{
    self.frame = CGRectMake(CGFrameGetMinX(self), originY, CGFrameGetWidth(self),CGFrameGetHeight(self));
}

- (CGFloat) centerX{
    return self.center.x;
}
- (void) setCenterX:(CGFloat)centerX{
    self.center = CGPointMake(centerX, self.center.y);
}

- (CGFloat) centerY{
    return self.center.y;
}
- (void) setCenterY:(CGFloat)centerY{
    self.center = CGPointMake(self.center.x, centerY);
}

@end
