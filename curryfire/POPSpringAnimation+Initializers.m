//
//  POPSpringAnimation+Initializers.m
//  Created by Devin Ross on 5/1/15.
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

#import "POPSpringAnimation+Initializers.h"
#import "ShortHand.h"

@implementation POPSpringAnimation (TKInitializers)

+ (POPSpringAnimation*) springAnimationWithPropertyNamed:(NSString*)aName toValue:(id)value velocity:(id)velocity bouciness:(CGFloat)bouciness speed:(CGFloat)speed removeOnCompletion:(BOOL)removeOnCompletion completion:(void (^)(POPAnimation *anim, BOOL finished))completion {
    POPSpringAnimation *spring = [POPSpringAnimation animationWithPropertyNamed:aName];
    spring.toValue = value;
    spring.springBounciness = bouciness;
    spring.springSpeed = speed;
    spring.removedOnCompletion = removeOnCompletion;
    spring.velocity = velocity;
    [spring setCompletionBlock:completion];
    return spring;
}

+ (POPSpringAnimation*) springAnimationToPoint:(CGPoint)point velocity:(CGPoint)velocity bouciness:(CGFloat)bouciness speed:(CGFloat)speed removeOnCompletion:(BOOL)removeOnCompletion completion:(void (^)(POPAnimation *anim, BOOL finished))completion {
    
    return [POPSpringAnimation springAnimationWithPropertyNamed:kPOPLayerPosition
                                                        toValue:NSCGPoint(point)
                                                       velocity:NSCGPoint(velocity)
                                                      bouciness:bouciness
                                                          speed:speed
                                             removeOnCompletion:removeOnCompletion
                                                     completion:completion];
    

}

@end
