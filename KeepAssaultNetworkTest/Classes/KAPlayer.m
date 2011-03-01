//
//  KAPlayer.m
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAPlayer.h"
#import "KAAssetManager.h"

@implementation KAPlayer

@synthesize target;
@synthesize index;

-(id)initWithIndex:(NSInteger)i {
	if ( (self = [super init]) ) {
		index = i;
		sprite = [[KAAssetManager sharedManager] spriteForPlayerAtIndex:index];
		[self addChild:sprite];
		
		target = ccp(0, 0);
		movement = ccp(0, 0);

		baseSpeed = 128.0f;

		[self scheduleUpdate];
	}
	return self;
}

-(void)update:(ccTime)dt {
	CGPoint direction = CGPointZero;
	
	if (ccpFuzzyEqual(target, self.position, 0.8)) {
		// Close enough
		self.position = target;
	} else {
		direction = ccpSub(target, self.position);
		direction = ccpNormalize(direction);
	}
	
	CGPoint velocity = ccpMult(direction, baseSpeed);
	velocity = ccpMult(velocity, dt);
	
	self.position = ccpAdd(self.position, velocity);
}



@end
