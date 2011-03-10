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
	
	// Follow path
	if (path != nil && [path count] > 0) {
		// Are we close enough to the next path location? If so, remove it
		CGPoint nextTile = [[path objectAtIndex:0] CGPointValue];		
		CGPoint nextWorld = [level tileToWorldCenter:nextTile];

		NSLog(@"tile: %@ world: %@", NSStringFromCGPoint(nextTile), NSStringFromCGPoint(nextWorld));
		
		if (ccpFuzzyEqual(self.position, nextWorld, 5.0f)) {
			[path removeObjectAtIndex:0];
			nextTile = [[path objectAtIndex:0] CGPointValue];
			nextWorld = [level tileToWorldCenter:nextTile];
		}

		NSLog(@"tile: %@ world: %@", NSStringFromCGPoint(nextTile), NSStringFromCGPoint(nextWorld));

		
		
		CGPoint movementVector = ccpSub(nextWorld, self.position);
		movementVector = ccpNormalize(movementVector);
		movementVector = ccpMult(movementVector, speed);
		movementVector = ccpMult(movementVector, dt);
		self.position = ccpAdd(self.position, movementVector);
	}
	
	
}

@end
