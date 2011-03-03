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
@synthesize playerID;
@synthesize name;

-(id)initWithID:(NSString*)pID {
	if ( (self = [super init]) ) {
		playerID = pID;
		sprite = [[KAAssetManager sharedManager] spriteForPlayerAtIndex:0];
		[self addChild:sprite];
		
		name = @"Default";
		
		playerName = [CCLabelTTF labelWithString:name fontName:@"Helvetica" fontSize:24];
		playerName.position = ccp(0, -70);
		[self addChild:playerName];
		
		target = ccp(0, 0);
		movement = ccp(0, 0);

		baseSpeed = 128.0f;

		[self scheduleUpdate];
	}
	return self;
}

-(void)setName:(NSString*)n {
	[name autorelease];
	name = [n retain];
	
	playerName.string = name;
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
