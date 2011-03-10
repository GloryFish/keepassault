//
//  KAPlayer.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAPlayer.h"


@implementation KAPlayer

@synthesize level;
@synthesize path;

-(id)init {
	if ( (self = [super init]) ) {
		speed = 256.0f;
		
		CCSprite* sprite = [CCSprite spriteWithFile:@"player.png"];
		[self addChild:sprite];
		
		[self scheduleUpdate];
	}
	return self;
}

-(void)update:(ccTime)dt {
	[self followPath];

	if (ccpFuzzyEqual(self.position, target, 5.0f)) {
		self.position = target;
	} else {
		// Move towards target
		CGPoint movementVector = ccpSub(target, self.position);
		if (!CGPointEqualToPoint(movementVector, CGPointZero)) {
			movementVector = ccpNormalize(movementVector);
		}
		movementVector = ccpMult(movementVector, speed);
		movementVector = ccpMult(movementVector, dt);
		
		NSLog(@"target: %@", NSStringFromCGPoint(target));
		
		NSLog(@"position: %@", NSStringFromCGPoint(self.position));
		
		NSLog(@"movement: %@", NSStringFromCGPoint(movementVector));
		
		self.position = ccpAdd(self.position, movementVector);
	}
}

-(void)followPath {
	if (path != nil && [path count] > 0) {
		// Are we close enough to the next path location? If so, remove it
		CGPoint nextTile = [[path objectAtIndex:0] CGPointValue];		
		CGPoint nextWorld = [level tileToWorldCenter:nextTile];
		
		if (ccpFuzzyEqual(self.position, nextWorld, 5.0f)) {
			[path removeObjectAtIndex:0];
			
			nextTile = [[path objectAtIndex:0] CGPointValue];
			nextWorld = [level tileToWorldCenter:nextTile];
		}
		
		target = nextWorld;
	}		
}

-(void)respawnAtWorldPosition:(CGPoint)pos {
	NSLog(@"setting pos: %@", NSStringFromCGPoint(pos));

	self.position = pos;
	target = pos;
}

@end
