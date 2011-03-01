//
//  KALayerMovementTest.m
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALayerMovementTest.h"
#import "KAPlayer.h"
#import "CCTouchDispatcher.h"

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


-(id) init {
	if( (self=[super init] )) {
		self.isTouchEnabled = YES;
		self.anchorPoint = ccp(0, 0);
		
		players = [[NSMutableArray alloc] initWithCapacity:2];
		
		KAPlayer* playerOne = [[KAPlayer alloc] initWithIndex:0];
		playerOne.position = ccp(0, 0);
		playerOne.target = playerOne.position;
		[self addChild:playerOne];
		[players addObject:playerOne];
		[playerOne release];
		
		KAPlayer* playerTwo = [[KAPlayer alloc] initWithIndex:1];
		playerTwo.position = ccp(512, 384);
		playerTwo.target = playerTwo.position;
		[self addChild:playerTwo];
		[players addObject:playerTwo];
		[playerTwo release];
	}
	return self;
}


#pragma mark -
#pragma mark CCTargetedTouchDelegate


-(void)registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace:touch];
	location = [self convertToWorldSpace:location];

	KAPlayer* playerOne = [players objectAtIndex:0];
	playerOne.target = location;
	
	return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace:touch];
	location = [self convertToWorldSpace:location];
	
	KAPlayer* playerOne = [players objectAtIndex:0];
	playerOne.target = location;
}

@end
