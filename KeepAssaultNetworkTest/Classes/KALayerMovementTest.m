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
#import "GameKitHelper.h"
#import "KANetworkPackets.h"

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
	if (gameSession != nil) {
	}
	[self sendHeartbeat];
}

#pragma mark GameKitHelper delegate methods
-(void) onLocalPlayerAuthenticationChanged
{
	GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
	CCLOG(@"LocalPlayer isAuthenticated changed to: %@", localPlayer.authenticated ? @"YES" : @"NO");
	
	if (localPlayer.authenticated)
	{
		GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
		[gkHelper getLocalPlayerFriends];
		//[gkHelper resetAchievements];
	}	
}

-(void) onFriendListReceived:(NSArray*)friends
{
	CCLOG(@"onFriendListReceived: %@", [friends description]);
	GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
	[gkHelper getPlayerInfo:friends];
}

-(void) onPlayerInfoReceived:(NSArray*)p
{
	CCLOG(@"onPlayerInfoReceived: %@", [p description]);
	GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
	[gkHelper submitScore:1234 category:@"Playtime"];
	
	//[gkHelper showLeaderboard];
	
	GKMatchRequest* request = [[[GKMatchRequest alloc] init] autorelease];
	request.minPlayers = 2;
	request.maxPlayers = 4;
	
	//GameKitHelper* gkHelper = [GameKitHelper sharedGameKitHelper];
	[gkHelper showMatchmakerWithRequest:request];
	[gkHelper queryMatchmakingActivity];
}

-(void) onScoresSubmitted:(bool)success
{
	CCLOG(@"onScoresSubmitted: %@", success ? @"YES" : @"NO");
}

-(void) onScoresReceived:(NSArray*)scores
{
	CCLOG(@"onScoresReceived: %@", [scores description]);
}

-(void) onAchievementReported:(GKAchievement*)achievement
{
	CCLOG(@"onAchievementReported: %@", achievement);
}

-(void) onAchievementsLoaded:(NSDictionary*)achievements
{
	CCLOG(@"onLocalPlayerAchievementsLoaded: %@", [achievements description]);
}

-(void) onResetAchievements:(bool)success
{
	CCLOG(@"onResetAchievements: %@", success ? @"YES" : @"NO");
}

-(void) onLeaderboardViewDismissed
{
	CCLOG(@"onLeaderboardViewDismissed");
}

-(void) onAchievementsViewDismissed
{
	CCLOG(@"onAchievementsViewDismissed");
}

-(void) onReceivedMatchmakingActivity:(NSInteger)activity
{
	CCLOG(@"receivedMatchmakingActivity: %i", activity);
}

-(void) onMatchFound:(GKMatch*)match
{
	CCLOG(@"onMatchFound: %@", match);
}

-(void) onPlayersAddedToMatch:(bool)success
{
	CCLOG(@"onPlayersAddedToMatch: %@", success ? @"YES" : @"NO");
}

-(void) onMatchmakingViewDismissed
{
	CCLOG(@"onMatchmakingViewDismissed");
}
-(void) onMatchmakingViewError
{
	CCLOG(@"onMatchmakingViewError");
}

-(void) onPlayerConnected:(NSString*)playerID
{
	CCLOG(@"onPlayerConnected: %@", playerID);
}

-(void) onPlayerDisconnected:(NSString*)playerID
{
	CCLOG(@"onPlayerDisconnected: %@", playerID);
}

-(void) onStartMatch
{
	CCLOG(@"onStartMatch");
}

-(void) onReceivedData:(NSData*)data fromPlayer:(NSString*)playerID
{
	SBasePacket* basePacket = (SBasePacket*)[data bytes];
	CCLOG(@"onReceivedData: %@ fromPlayer: %@ - Packet type: %i", data, playerID, basePacket->type);
	
	switch (basePacket->type)
	{
		case kPacketTypeTarget:
		{
			STargetPacket* targetPacket = (STargetPacket*)basePacket;
			CCLOG(@"\tposition = (%.1f, %.1f)", targetPacket->target.x, targetPacket->target.y);
			
			break;
		}
		default:
			CCLOG(@"unknown packet type %i", basePacket->type);
			break;
	}
}


-(void)sendHeartbeat:(CGPoint)tilePos {
	if ([GameKitHelper sharedGameKitHelper].currentMatch != nil) {
		KAPlayer* localPlayer = [players objectForKey:localPlayerID];
		
		
		STargetPacket packet;
		packet.type = kPacketTypeTarget;
		packet.target = localPlayer.target;
		
		[[GameKitHelper sharedGameKitHelper] sendDataToAllPlayers:&packet length:sizeof(packet)];
	}
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
