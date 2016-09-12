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
@property (nonatomic,strong) CADisplayLink *displayLink;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSArray *images;
@property (nonatomic,assign) NSInteger currentFrame;
@property (nonatomic,copy) TKAnimationCompletionBlock completionBlock;

@property (nonatomic,assign) CFTimeInterval startTime;
@property (nonatomic,assign) NSTimeInterval duration;
@property (nonatomic,assign) NSInteger loops;

@property (nonatomic,assign) BOOL playingAnimation;

@end

@implementation TKAnimatedImageView

#define FRAME_RATE 60.0f

- (void) playAnimationWithImages:(NSArray*)images duration:(NSTimeInterval)duration withCompletionBlock:(void (^)(BOOL finished))finished{
	[self playAnimationWithImages:images duration:duration repeatCount:1 withCompletionBlock:finished];
}


- (void) tick:(CADisplayLink*)sender{
	
	if(self.startTime < 0){
		self.startTime = sender.timestamp;
	}
	
	NSTimeInterval timeLapse = sender.timestamp-self.startTime;
	NSTimeInterval perc = timeLapse / self.duration;
	NSTimeInterval loops = floor(perc);
	
	if(self.loops > 0 && loops == self.loops){
		self.image = self.images.lastObject;
		[self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		self.playingAnimation = NO;
		if(self.completionBlock)
			self.completionBlock(YES);
		return;
	}
	
	CGFloat framePerc = perc - loops;
	NSInteger ii = framePerc * self.images.count;
	ii = MIN(self.images.count-1,ii);
	self.currentFrame = ii;
	self.image = self.images[ii];
	
	
}

- (void) playAnimationWithImages:(NSArray*)images duration:(NSTimeInterval)duration repeatCount:(NSUInteger)repeatCount withCompletionBlock:(void (^)(BOOL finished))finished{
	
	
	if(self.playingAnimation) {
		[self.timer invalidate];
		self.timer = nil;
		[self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		self.playingAnimation = NO;
		self.currentFrame = 0;
		self.images = nil;
		if(self.completionBlock)
			self.completionBlock(NO);
		self.completionBlock = nil;
	}
	
	if(images.count < 1 || duration <= 0) return;
	
	self.playingAnimation = YES;
	self.duration = duration;
	self.loops = repeatCount;
	self.images = images;
	self.image = images.firstObject;
	self.completionBlock = finished;
	self.startTime = -1;
	[self.displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
	
}

- (UIImage*) currentImage{
	return self.images[self.currentFrame];
}

- (void) stopAnimating{
	[super stopAnimating];
	
	if(self.playingAnimation){
		[self.displayLink removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSDefaultRunLoopMode];
		self.playingAnimation = NO;
		if(self.completionBlock)
			self.completionBlock(NO);
		self.images = nil;
	}
	
}

- (CADisplayLink*) displayLink{
	if(_displayLink) return _displayLink;
	_displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
	_displayLink.frameInterval = 1;
	return _displayLink;
}


@end
