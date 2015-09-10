//
//  TKProgressRingView.m
//  Created by Devin Ross on 1/12/15.
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

#import "TKProgressRingView.h"
@import curry;
@import pop;

@interface TKProgressRingView ()

@property (nonatomic,assign) CGFloat startProgress;
@property (nonatomic,assign) CGFloat counter;
@property (nonatomic,assign) NSTimeInterval animationDuration;
@property (assign) BOOL timerIsLooping;

@property (nonatomic,strong) POPAnimatableProperty *pop;

@end

@implementation TKProgressRingView

#define START_ANGLE (-M_PI/2.0f+0.04)
#define END_ANGLE M_PI * 1.5
#define FRAME_RATE 60.0f

- (instancetype) initWithFrame:(CGRect)frame{
	self = [self initWithFrame:frame radius:80 strokeWidth:20];
	return self;
}
- (instancetype) initWithFrame:(CGRect)frame radius:(CGFloat)radius strokeWidth:(CGFloat)strokeWidth{
	if(!(self=[super initWithFrame:frame])) return nil;

	self.userInteractionEnabled = NO;
	_strokeWidth = strokeWidth;
	_radius = radius;
	_curve = TKProgressRingAnimationCurveLinear;
	
	CGFloat x = CGRectGetWidth(frame) / 2;
    CGFloat y = CGRectGetHeight(frame) / 2;

	
	UIBezierPath *circlePath = [UIBezierPath bezierPath];
	[circlePath addArcWithCenter:CGPointMake(x, y) radius:_radius startAngle:0 endAngle:M_PI*2 clockwise:YES];
	
	self.fullCircleLayer = [CAShapeLayer layer];
	self.fullCircleLayer.path = circlePath.CGPath;
	self.fullCircleLayer.strokeColor = [UIColor whiteColor].CGColor;
	self.fullCircleLayer.fillColor = [UIColor clearColor].CGColor;
	self.fullCircleLayer.opacity = 1;
	self.fullCircleLayer.lineCap = kCALineCapRound;
	
	self.baseGradientView = [[UIImageView alloc] initWithFrame:self.bounds];
	self.baseGradientView.alpha = 0.2;
	self.baseGradientView.contentMode = UIViewContentModeScaleAspectFill;
	self.baseGradientView.layer.mask = self.fullCircleLayer;
	self.baseGradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addSubview:self.baseGradientView];

	
	UIBezierPath* aPath = [UIBezierPath bezierPath];
	[aPath addArcWithCenter:CGPointMake(x, y) radius:_radius startAngle:START_ANGLE endAngle:START_ANGLE clockwise:YES];
	self.circleLayer = [CAShapeLayer layer];
	self.circleLayer.path = aPath.CGPath;
	self.circleLayer.strokeColor = [UIColor redColor].CGColor;
	self.circleLayer.fillColor = [UIColor clearColor].CGColor;
	self.circleLayer.backgroundColor = [UIColor blueColor].CGColor;
	self.circleLayer.opacity = 1;
	self.circleLayer.lineCap = kCALineCapRound;
	self.circleLayer.lineWidth = self.fullCircleLayer.lineWidth = _strokeWidth;
	
	self.progressGradientView = [[UIImageView alloc] initWithFrame:self.bounds];
	self.progressGradientView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.progressGradientView.contentMode = UIViewContentModeScaleAspectFill;
	[self addSubview:self.progressGradientView];
	self.progressGradientView.layer.mask = self.circleLayer;
    
	_progress = 0;
	
	return self;
}



- (void) _updateProgress{
    if(!self.timerIsLooping) return;

    self.counter++;
    CGFloat duration = FRAME_RATE * 1.5;
    if(self.counter > duration){
        self.timerIsLooping = NO;
    }
    
    dispatch_async(dispatch_get_main_queue(), ^{
        CGFloat x = self.progressGradientView.width / 2;
        CGFloat y = self.progressGradientView.height / 2;

        UIBezierPath *aPath = [UIBezierPath bezierPath];
		CGFloat p;
		if(self.curve == TKProgressRingAnimationCurveQuadratic)
			p = [self quadraticProgressAtTime:self.counter duration:duration startValue:self.startProgress change:self.progress-self.startProgress];
		else
			p = [self linearProgressAtTime:self.counter duration:duration startValue:self.startProgress change:self.progress-self.startProgress];
		
		[aPath addArcWithCenter:CGPointMake(x, y) radius:_radius startAngle:START_ANGLE endAngle:(END_ANGLE-START_ANGLE) * p + START_ANGLE clockwise:YES];
		dispatch_async(dispatch_get_main_queue(), ^{

			self.circleLayer.path = aPath.CGPath;
		});
		
    });
    
    
    if(!self.timerIsLooping) return;
    
    double delayInSeconds = 1.0 / FRAME_RATE;
    dispatch_queue_t gqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, gqueue, ^(void){
        [self _updateProgress];
    });
}


- (CGFloat) linearProgressAtTime:(NSTimeInterval)time duration:(NSTimeInterval)duration startValue:(CGFloat)startValue change:(CGFloat)change{
	return change * time/duration + startValue;
}


- (CGFloat) quadraticProgressAtTime:(NSTimeInterval)time duration:(NSTimeInterval)duration startValue:(CGFloat)startValue change:(CGFloat)change{
	return change * ( -pow(2, -10 * time/duration) + 1 ) + startValue;
}


#pragma mark Properties
- (void) setProgress:(CGFloat)progress{
	[self setProgress:progress animated:NO];
}
- (void) setProgress:(CGFloat)progress animated:(BOOL)animated{
    [self setProgress:progress duration:animated ? 1.5 : 0];
}
- (void) setProgress:(CGFloat)progress duration:(NSTimeInterval)duration{
    CGFloat x = self.progressGradientView.width / 2;
    CGFloat y = self.progressGradientView.height / 2;
	
	if(duration == 0.0){
		self.timerIsLooping = NO;
		_startProgress = 0;
		_progress = progress;
		UIBezierPath *aPath = [UIBezierPath bezierPath];
		[aPath addArcWithCenter:CGPointMake(x, y) radius:_radius startAngle:START_ANGLE endAngle:(END_ANGLE-START_ANGLE) * _progress + START_ANGLE clockwise:YES];
		self.circleLayer.path = aPath.CGPath;
		return;
	}
	
	
	if(self.curve == TKProgressRingAnimationCurveSpring){
		
		self.startProgress = _progress;
		_progress = progress;
		
		self.pop = [POPAnimatableProperty propertyWithName:@"timeOffset" initializer:^(POPMutableAnimatableProperty *prop) {
			// read value
			prop.readBlock = ^(CAShapeLayer *obj, CGFloat values[]) {
				values[0] = obj.timeOffset;
			};
			// write value
			prop.writeBlock = ^(CAShapeLayer *obj, const CGFloat values[]) {
				obj.timeOffset = values[0];
				CGFloat progress = values[0];
				UIBezierPath *aPath = [UIBezierPath bezierPath];
				[aPath addArcWithCenter:CGPointMake(x, y) radius:_radius startAngle:START_ANGLE endAngle:(END_ANGLE-START_ANGLE) * progress + START_ANGLE clockwise:YES];
				
				dispatch_async(dispatch_get_main_queue(), ^{
					self.circleLayer.path = aPath.CGPath;

				});
				
				
			};
			// dynamics threshold
			prop.threshold = 0.1;
		}];
		
		self.springAnimation.fromValue = @(self.startProgress);
		self.springAnimation.toValue =  @(self.progress);
		self.springAnimation.property = self.pop;
		[self.layer pop_addAnimation:self.springAnimation forKey:nil];
	}else{
        self.animationDuration = duration;
        CGFloat startProgress = _progress;

        _progress = progress;
        
        if(!self.timerIsLooping){
            self.startProgress = startProgress;
            self.counter = 0;
            self.timerIsLooping = YES;
            dispatch_queue_t gqueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
            dispatch_async(gqueue, ^{
                [self _updateProgress];
            });
        }
        

    }
}
- (void) setStrokeWidth:(CGFloat)strokeWidth{
	self.circleLayer.lineWidth = self.fullCircleLayer.lineWidth = _strokeWidth;
}
- (void) setProgressImage:(UIImage *)progressImage{
    self.baseGradientView.image = self.progressGradientView.image = progressImage;
}
- (void) setProgressColor:(UIColor *)progressColor{
    self.baseGradientView.backgroundColor = self.progressGradientView.backgroundColor = progressColor;
}


- (POPSpringAnimation*) springAnimation{
	if(_springAnimation) return _springAnimation;
	_springAnimation = [POPSpringAnimation animation];
	_springAnimation.springBounciness = 4;
	_springAnimation.springSpeed = 1;
//	_springAnimation.dynamicsMass = 1;
//	_springAnimation.dynamicsFriction = 2;
	return _springAnimation;
}

@end