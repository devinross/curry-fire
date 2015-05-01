//
//  TKAnimatedCounterLabel.m
//  Created by Devin Ross on 1/14/15.
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

#import "TKAnimatedCounterLabel.h"
#import "UIView+Positioning.h"
@import UIKit;
@import curry;

@interface TKAnimatedCounterLabel ()

@property (nonatomic,strong) NSNumber *startNumber;
@property (nonatomic,strong) NSNumber *endNumber;
@property (nonatomic,assign) CGFloat counter;
@property (assign) BOOL timerIsLooping;

@property (nonatomic,strong) NSMutableArray *labels;
@property (nonatomic,strong) NSMutableArray *dequeuedLabels;
@property (nonatomic,strong) UILabel *baseLabel;

@property (nonatomic,assign) CGFloat duration;

@property (nonatomic,copy) void (^completeBlock)(BOOL finished);



@end

@implementation TKAnimatedCounterLabel

#define FRAME_RATE 20.0f

- (instancetype) initWithFrame:(CGRect)frame{
	if(!(self=[super initWithFrame:frame])) return nil;
	
	self.numberFormatter = [[NSNumberFormatter alloc] init];
    self.textAlignment = NSTextAlignmentCenter;
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.textAlignment = NSTextAlignmentCenter;
    self.baseLabel = label;
    self.dequeuedLabels = [NSMutableArray arrayWithObject:label];
    self.labels = [NSMutableArray array];
    
    self.modelCharacter = @"9";
	
	return self;
}

- (UILabel*) dequeueLabel{
    
    if(self.dequeuedLabels.count == 0){
        UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
        label.font = self.baseLabel.font;
        label.textAlignment = NSTextAlignmentCenter;
        return label;
    }
    
    UILabel *label = [self.dequeuedLabels lastObject];
    [self.dequeuedLabels removeLastObject];
    return label;
}
- (void) _setupLabelsWithText:(NSString*)text{
    [self.dequeuedLabels addObjectsFromArray:self.labels];
    [self.labels makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.labels removeAllObjects];
    
    NSInteger length = text.length;
    self.baseLabel.text = self.modelCharacter;
    [self.baseLabel sizeToFit];
    
    CGSize size = self.baseLabel.frame.size;
    size.width += self.characterPadding;
    NSInteger width = (size.width + self.kerning) * length;
    NSInteger minX = self.textAlignment == NSTextAlignmentCenter ? (self.width - width) / 2 : 0;
    NSInteger minY = (self.height - size.height) / 2;
    
    for(NSInteger i=0;i<length;i++){
        UILabel *label = [self dequeueLabel];
        label.font = self.baseLabel.font;
        label.text = [text substringWithRange:NSMakeRange(i, 1)];
        label.frame = CGRectMakeWithSize(minX, minY, size);
        label.textColor = self.baseLabel.textColor;
        [self addSubview:label];
        [self.labels addObject:label];
        minX = (label.maxX + self.kerning);
    }
    
    _text = text;
    
    
}
- (NSNumber*) numberAtProgressAtTime:(CGFloat)time duration:(CGFloat)duration startValue:(NSNumber*)startValue endValue:(NSNumber*)endValue{
	
	if(time >= duration){
		time = duration;
	}
	
	double start = startValue.doubleValue;
	double end = endValue.doubleValue;
	double diff = end - start;
	double change = diff * ( -pow(2, -10 * time/duration) + 1 );
	return @(start + change);

}
- (void) _updateProgress{
    if(!self.timerIsLooping) return;
	
	self.counter++;
	CGFloat duration = FRAME_RATE * self.duration;

	if(self.counter >= duration){
		self.counter = duration;
        self.timerIsLooping = NO;
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self _setupLabelsWithText:[self.numberFormatter stringFromNumber:self.endNumber]];

            if(self.completeBlock){
                self.completeBlock(YES);
                self.completeBlock = nil;
            }
        });
        
		return;
	}
    

    dispatch_async(dispatch_get_main_queue(), ^{
        NSNumber *num = [self numberAtProgressAtTime:self.counter duration:duration startValue:self.startNumber endValue:self.endNumber];
        [self _setupLabelsWithText:[self.numberFormatter stringFromNumber:num]];
    });
	
    if(!self.timerIsLooping) return;
    
    double delayInSeconds = 1.0 / FRAME_RATE;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_after(popTime, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^(void){
        [self _updateProgress];
    });
	
	
}

#pragma mark Properties
- (void) setNumber:(NSNumber *)number{
    [self setNumber:number animated:NO];
}
- (void) setNumber:(NSNumber *)number animated:(BOOL)animated{
    [self setNumber:number duration:animated ? 1.5 : 0];
}
- (void) setNumber:(NSNumber *)number duration:(CGFloat)duration{
    [self setNumber:number duration:duration completion:nil];
}
- (void) setNumber:(NSNumber *)number duration:(CGFloat)duration completion:(void (^)(BOOL finished))completion{
    if(duration == 0){
        self.timerIsLooping = NO;
        self.text = [self.numberFormatter stringFromNumber:number];
        if(completion) completion(YES);
        return;
    }
    
    NSNumber *startNumber = [self.numberFormatter numberFromString:self.text];
    if([startNumber isEqualToNumber:number]){
        if(completion) completion(NO);
        return;
    }
    
    self.completeBlock = completion;
    
    self.duration = duration;
    self.startNumber = startNumber;
    self.endNumber = number;
    self.counter = 0;
    self.timerIsLooping = YES;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [self _updateProgress];
    });
    
}
- (void) setTextColor:(UIColor *)textColor{
    _textColor = textColor;
    self.baseLabel.textColor = textColor;
    for(UILabel *label in self.labels)
        label.textColor = textColor;
}
- (void) setFont:(UIFont *)font{
    _font = font;
    self.baseLabel.font = font;
    for(UILabel *label in self.labels){
        label.font = font;
    }
    
}
- (void) setText:(NSString *)text{
    _text = text;
    [self _setupLabelsWithText:text];
}
- (void) setCharacterPadding:(CGFloat)characterPadding{
    _characterPadding = characterPadding;
    [self _setupLabelsWithText:self.text];
}

@end