//
//  TKBounceBehavior.m
//  Created by Devin Ross on 7/23/15.
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

#import "TKBounceBehavior.h"

@implementation TKBounceBehavior

- (id) initWithItems:(NSArray*)items{
	if(!(self=[super init])) return nil;
	
	self.gravityBehavior = [[UIGravityBehavior alloc] initWithItems:items];
	
	self.collisionBehavior = [[UICollisionBehavior alloc] initWithItems:items];
	self.collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
	
	self.pushBehavior = [[UIPushBehavior alloc] initWithItems:items mode:UIPushBehaviorModeInstantaneous];
	self.pushBehavior.pushDirection = CGVectorMake(0, 2.0);
	self.pushBehavior.active = NO;
	
	self.itemBehavior = [[UIDynamicItemBehavior alloc] initWithItems:items];
	self.itemBehavior.elasticity = 0.45;

	[self addChildBehavior:self.gravityBehavior];
	[self addChildBehavior:self.pushBehavior];
	[self addChildBehavior:self.itemBehavior];
	[self addChildBehavior:self.collisionBehavior];

	return self;
}

- (void) setBounceDirection:(CGVector)vector{
	_bounceDirection = vector;
	self.pushBehavior.pushDirection = vector;
	
	CGFloat dx = 0, dy = 0;
	if(vector.dx > 0)
		dx = -1;
	else if(vector.dx < 0)
		dx = 1;
	
	if(vector.dy > 0)
		dy = -1;
	else if(vector.dy < 0)
		dy = 1;
	
	self.gravityBehavior.gravityDirection = CGVectorMake(dx, dy);
}




- (void) bounce{
	self.pushBehavior.active = true;
}

@end
