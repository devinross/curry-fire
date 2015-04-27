//
//  UIPanGestureRecognizer+VelocityDirection.m
//  Created by Devin Ross on 4/23/15.
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

#import "UIPanGestureRecognizer+VelocityDirection.h"

@implementation UIPanGestureRecognizer (VelocityDirection)


- (BOOL) velocityIsVertical{
    CGPoint velocity = [self velocityInView:self.view];
    return fabs(velocity.y) > fabs(velocity.x);
}
- (BOOL) velocityIsHorizontal{
    CGPoint velocity = [self velocityInView:self.view];
    return fabs(velocity.x) > fabs(velocity.y);
}

- (BOOL) velocityIsUp{
    CGPoint velocity = [self velocityInView:self.view];
    return fabs(velocity.y) > fabs(velocity.x) && velocity.y < 0;
}
- (BOOL) velocityIsDown{
    CGPoint velocity = [self velocityInView:self.view];
    return fabs(velocity.y) > fabs(velocity.x) && velocity.y > 0;
}
- (BOOL) velocityIsLeft{
    CGPoint velocity = [self velocityInView:self.view];
    return fabs(velocity.x) > fabs(velocity.y) && velocity.x < 0;
}
- (BOOL) velocityIsRight{
    CGPoint velocity = [self velocityInView:self.view];
    return fabs(velocity.x) > fabs(velocity.y) && velocity.x > 0;
}




@end
