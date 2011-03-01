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

@synthesize velocity;
@synthesize target;
@synthesize index;

-(id)initWithIndex:(NSInteger)i {
	if ( (self = [super init]) ) {
		index = i;
		sprite = [[KAAssetManager sharedManager] spriteForPlayerAtIndex:index];
		[self addChild:sprite];
		
		target = ccp(0, 0);
		movement = ccp(0, 0);
		velocity = ccp(0, 0);

		
		speed = 64.0f;

		[self scheduleUpdate];
	}
	return self;
}

-(void)update:(ccTime)dt {
//	CGPoint direction = ccpNormalize(ccpSub(target, self.position));
//	
//	velocity = ccpMult(direction, speed);
//	velocity = ccpMult(velocity, dt);
//	
//	self.position = ccpAdd(self.position, velocity);
}


@end
