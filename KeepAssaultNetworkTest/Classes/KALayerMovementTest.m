//
//  KALayerMovementTest.m
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALayerMovementTest.h"
#import "KAPlayer.h"

@implementation KALayerMovementTest

+(id) scene {
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	KALayerMovementTest *layer = [KALayerMovementTest node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}


// on "init" you need to initialize your instance
-(id) init {
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		players = [[NSMutableDictionary alloc] initWithCapacity:2];
		
		KAPlayer* playerOne = [[KAPlayer alloc] init];
		playerOne.position = ccp(100, 300);
		playerOne.velocity = ccp(0, 0);
		[self addChild:playerOne];
		[players setObject:playerOne forKey:@"playerOne"];
		[playerOne release];
		
		KAPlayer* playerTwo = [[KAPlayer alloc] init];
		playerTwo.position = ccp(400, 200);
		playerTwo.velocity = ccp(0, 0);
		[self addChild:playerTwo];
		[players setObject:playerTwo forKey:@"playerTwo"];
		[playerTwo release];
		

	}
	return self;
}

@end
