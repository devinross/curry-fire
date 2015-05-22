//
//  TKAnimatedImageView.m
//  Created by Devin Ross on 5/21/15.
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

#import "TKAnimatedImageView.h"

typedef void (^TKAnimationCompletionBlock)(BOOL completed);

@interface TKAnimatedImageView ()
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,assign) NSInteger currentFrame;
@property (nonatomic,copy) TKAnimationCompletionBlock completionBlock;
@end

@implementation TKAnimatedImageView

#define FRAME_RATE 60.0f

- (void) playAnimationWithImages:(NSArray*)images duration:(NSTimeInterval)duration withCompletionBlock:(void (^)(BOOL finished))finished{
    [self playAnimationWithImages:images duration:duration repeatCount:1 withCompletionBlock:finished];
}

- (void) playAnimationWithImages:(NSArray*)images duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount withCompletionBlock:(void (^)(BOOL finished))finished{
   
    if(self.timer){
        [self.timer invalidate];
        if(self.completionBlock)
            self.completionBlock(NO);
        self.timer = nil;
        self.completionBlock = nil;
        self.images = nil;
        self.currentFrame = 0;
    }

    
    if(images.count < 1) return;
    
    self.images = images;
    self.image = images.firstObject;
    self.completionBlock = finished;
    
    __block NSInteger ctr = 0;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0f / FRAME_RATE repeats:YES block:^{
        
        CGFloat perc = (ctr  / (FRAME_RATE * duration));
        NSInteger frame = round(perc * (images.count-1));
        frame = frame % images.count;

        if(repeatCount > 0 && ctr >= FRAME_RATE * duration * repeatCount){
            [self.timer invalidate];
            self.timer = nil;
            if(finished) finished(YES);
        }else{
            self.currentFrame = frame;
            self.image = images[frame];
        }
        
        ctr++;
    }];
    
}

- (UIImage*) currentImage{
    return self.images[self.currentFrame];
}

- (void) stopAnimating{
    [super stopAnimating];
    [self.timer invalidate];
    if(self.completionBlock)
        self.completionBlock(NO);
    self.timer = nil;
    self.completionBlock = nil;
}



@end
