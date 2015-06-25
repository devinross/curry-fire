//
//  UIView+Confetti.m
//  Created by Devin Ross on 4/22/15.
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

#import "UIView+Confetti.h"
#import "UIView+Positioning.h"
#import "ShortHand.h"

@implementation UIView (Confetti)

- (void) rainConfetti{
    [self confettiAnimationWithCompletion:nil];
}
- (void) confettiAnimationWithCompletion:(void (^)(BOOL complete))block{
    [self confettiAnimationWithCompletion:block numberOfRowsAndColumns:5];
}





float randFloat(){
    return (float)rand()/(float)RAND_MAX;
}

- (void) confettiAnimationWithCompletion:(void (^)(BOOL complete))block numberOfRowsAndColumns:(NSInteger)rowsAndColumns{
    
    self.userInteractionEnabled = NO;
    

    CGFloat size = self.width / rowsAndColumns;
    CGSize imageSize = CGSizeMake(size, size);
    CGFloat cols = self.width / imageSize.width, rows = self.height / imageSize.height;
    
    NSInteger fullColumns = floorf(cols), fullRows = floorf(rows);
    
    CGFloat remainderWidth = self.width  - (fullColumns * imageSize.width);
    CGFloat remainderHeight = self.height - (fullRows * imageSize.height );
    
    
    if (cols > fullColumns) fullColumns++;
    if (rows > fullRows) fullRows++;
    
    CGRect originalFrame = self.layer.frame;
    CGRect originalBounds = self.layer.bounds;
    
    
    CGImageRef fullImage = [self _imageFromLayer:self.layer].CGImage;
    if ([self isKindOfClass:[UIImageView class]]){
        [(UIImageView*)self setImage:nil];
    }
    
    [[self.layer sublayers] makeObjectsPerformSelector:@selector(removeFromSuperlayer)];
    
    for(NSInteger i = 0; i < fullRows; i++){
        for (NSInteger j = 0; j < fullColumns; j++){
            CGSize tileSize = imageSize;
            
            if (j + 1 == fullColumns && remainderWidth > 0){
                tileSize.width = remainderWidth; // Last column
            }
            if (i + 1 == fullRows && remainderHeight > 0){
                tileSize.height = remainderHeight; // Last row
            }
            
            CGRect layerRect = CGRectMakeWithSize(j*imageSize.width, i*imageSize.height, tileSize);
            
            CGImageRef tileImage = CGImageCreateWithImageInRect(fullImage,layerRect);
            
            CALayer *layer = [CALayer layer];
            layer.frame = layerRect;
            layer.contents = (__bridge id)(tileImage);
            layer.borderWidth = 0;
            layer.borderColor = [UIColor blackColor].CGColor;
            [self.layer addSublayer:layer];
            
            CGImageRelease(tileImage);
        }
    }
    
    self.layer.frame = originalFrame;
    self.layer.bounds = originalBounds;
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    
    NSArray *sublayersArray = self.layer.sublayers;
    NSInteger ctr = 0;
    
    id last = ^(BOOL complete){
        if(block) block(complete);
    };
    
    for(CALayer *layer in sublayersArray){
        
        //Path
        CAKeyframeAnimation *moveAnim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        moveAnim.path = [self _pathForLayer:layer parentRect:originalFrame].CGPath;
        moveAnim.removedOnCompletion = YES;
        moveAnim.fillMode = kCAFillModeForwards;
        moveAnim.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut]];

        NSTimeInterval speed = 3.35 * randFloat();
        
        CAKeyframeAnimation *transformAnim = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
        
        CATransform3D startingScale = layer.transform;
        CATransform3D endingScale = CAConcat(CAScale(randFloat(), randFloat(), randFloat()), CARotate(M_PI*(1+randFloat()), randFloat(), randFloat(), randFloat()));
        
    
        transformAnim.values = @[NSCATransform3D(startingScale),NSCATransform3D(endingScale)];
        transformAnim.keyTimes = @[@0.0, @(speed*.25)];
        

        transformAnim.timingFunctions =  @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut],
                                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseIn],
                                           [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut], [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        transformAnim.fillMode = kCAFillModeForwards;
        transformAnim.removedOnCompletion = NO;
        
        //alpha
        CABasicAnimation *opacityAnim = [CABasicAnimation animationWithKeyPath:@"opacity"];
        opacityAnim.fromValue = [NSNumber numberWithFloat:1.0f];
        opacityAnim.toValue = [NSNumber numberWithFloat:0.f];
        opacityAnim.removedOnCompletion = NO;
        opacityAnim.duration = speed;
        opacityAnim.fillMode = kCAFillModeForwards;
        
        
        CAAnimationGroup *animGroup = [CAAnimationGroup animation];
        animGroup.animations = @[moveAnim,transformAnim,opacityAnim];
        animGroup.duration = speed;
        animGroup.fillMode = kCAFillModeForwards;
        [animGroup setValue:layer forKey:@"animationLayer"];
        [layer addAnimation:animGroup forKey:nil completion:ctr + 1 == sublayersArray.count ? last : nil];
        
        //take it off screen
        [layer setPosition:CGPointMake(0, -600)];
        ctr++;

    }
    
    
}

- (UIImage *) _imageFromLayer:(CALayer *)layer{
    UIGraphicsBeginImageContext([layer frame].size);
    
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *outputImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return outputImage;
}



- (UIBezierPath *) _pathForLayer:(CALayer *)layer parentRect:(CGRect)rect{
    UIBezierPath *particlePath = [UIBezierPath bezierPath];
    CGPoint start = layer.position;
    [particlePath moveToPoint:start];
    

    CGPoint curvePoint = CGPointZero;
    CGPoint endPoint = CGPointZero;
    CGFloat layerYPosAndHeight = (self.superview.height - ((layer.position.y+layer.frame.size.height))) * randFloat();
    CGFloat endY = self.superview.height - self.minY;
	CGFloat layerXPosAndHeight = layer.position.x + (randFloat() - 0.5) * 700;

	
    
    if (layer.position.x <= rect.size.width*0.5){
        //going left
        endPoint = CGPointMake(layerXPosAndHeight, endY);
        //curvePoint = CGPointMake((((layer.position.x*0.5)*r3)*upOrDown)*maxLeftRightShift, -layerYPosAndHeight);
        CGFloat midX =  MIN(endPoint.x, start.x) + fabs(endPoint.x-start.x) / 2;

        curvePoint = CGPointMake(midX, -layerYPosAndHeight);

    }else{
        endPoint = CGPointMake(layerXPosAndHeight, endY);
        //curvePoint = CGPointMake((((layer.position.x*0.5)*r3) *upOrDown+rect.size.width)*maxLeftRightShift, -layerYPosAndHeight);
        
        CGFloat midX =  MIN(endPoint.x, start.x) + fabs(endPoint.x-start.x) / 2;
        
        curvePoint = CGPointMake(midX, -layerYPosAndHeight);

    }
    
    [particlePath addQuadCurveToPoint:endPoint controlPoint:curvePoint];
    
    return particlePath;
    
}


@end
