//
//  KALayerMovementTest.h
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import <GameKit/GameKit.h>
#import "GameKitHelper.h"

@interface KALayerMovementTest : CCLayer <CCTargetedTouchDelegate, GameKitHelperProtocol> {
	NSMutableDictionary* players;

	NSString* localPlayerID;
	NSString* localPlayerName;

	// Networking
	GKSession* gameSession;
	NSInteger gamePacketNumber;
}

@property (nonatomic, retain) GKSession* gameSession;
@property (nonatomic, retain) NSString* localPlayerID;
@property (nonatomic, retain) NSString* localPlayerName;

+(id)scene;

-(void)setupSingleplayer;
-(void)setupMultiplayer;

-(void)update:(ccTime)dt;
-(void)sendHeartbeat;
  
-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;

@end
