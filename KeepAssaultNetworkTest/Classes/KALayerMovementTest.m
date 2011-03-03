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

@synthesize gameSession;
@synthesize localPlayerID;
@synthesize localPlayerName;

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
		
		players = [[NSMutableDictionary alloc] initWithCapacity:2];

		localPlayerID = @"localplayer";
		localPlayerName = @"default";
		
		gamePacketNumber = 0;
		
		[self scheduleUpdate];
	}
	return self;
}

-(void)setupSingleplayer {
	KAPlayer* localPlayer = [[KAPlayer alloc] initWithID:localPlayerID];
	localPlayer.position = ccp(512, 384);
	localPlayer.target = localPlayer.position;
	localPlayer.name = localPlayerName;
	
	[self addChild:localPlayer];
	[players setObject:localPlayer forKey:localPlayerID];
	[localPlayer release];
}


-(void)setupMultiplayer {
	if (gameSession == nil) {
		return;
	}

	localPlayerID = gameSession.peerID;
	localPlayerName = gameSession.displayName;
	
	KAPlayer* localPlayer = [[KAPlayer alloc] initWithID:localPlayerID];
	localPlayer.position = ccp(512, 384);
	localPlayer.target = localPlayer.position;
	localPlayer.name = localPlayerName;
	
	[self addChild:localPlayer];
	[players setObject:localPlayer forKey:gameSession.peerID];
	[localPlayer release];
	
	for (NSString* peerID in [gameSession peersWithConnectionState:GKPeerStateConnected]) {
		KAPlayer* player = [[KAPlayer alloc] initWithID:peerID];
		player.position = ccp(512, 384);
		player.target = player.position;
		player.name = [gameSession displayNameForPeer:peerID];
		
		[self addChild:player];
		[players setObject:player forKey:peerID];
		[player release];
	}
}


-(void)update:(ccTime)dt {
}


#pragma mark -
#pragma mark CCTargetedTouchDelegate


-(void)registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace:touch];
	location = [self convertToWorldSpace:location];

	KAPlayer* playerOne = [players objectForKey:localPlayerID];
	playerOne.target = location;
	
	return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace:touch];
	location = [self convertToWorldSpace:location];
	
	KAPlayer* playerOne = [players objectForKey:localPlayerID];
	playerOne.target = location;
}

@end
