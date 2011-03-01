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
@synthesize index;

-(id)initWithIndex:(NSInteger)i {
	if ( (self = [super init]) ) {
		index = i;
		sprite = [[KAAssetManager sharedManager] spriteForPlayerAtIndex:index];
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
