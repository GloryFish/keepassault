//
//  KAPlayer.m
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAPlayer.h"


@implementation KAPlayer

@synthesize velocity;

-(id)init {
	if ( (self = [super init]) ) {
		sprite = [CCSprite spriteWithFile:@"player_one.png"];
		[self addChild:sprite];
		
		target = ccp(0, 0);
		speed = ccp(64, 64);
		movement = ccp(0, 0);
		
		[self scheduleUpdate];
	}
	return self;
}

-(void)setPosition:(CGPoint)pos {
	super.position = pos;
	sprite.position = pos;
}

-(void)update:(ccTime)dt {
}


@end
