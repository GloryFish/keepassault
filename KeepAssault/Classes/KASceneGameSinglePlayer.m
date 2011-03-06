//
//  KASceneGameSinglePlayer.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KASceneGameSinglePlayer.h"
#import "KALayerGame.h";
#import "KALayerHUD.h"
#import "KAPlayer.h"

@implementation KASceneGameSinglePlayer

-(id)init {
	if ( (self = [super init]) ) {
		KAPlayer* player = [KAPlayer node];
		player.position = ccp(100, 100);

		KALayerGame* gameLayer = [KALayerGame node];
		[gameLayer setPlayer:player];
		[self addChild:gameLayer];
		
		KALayerHUD* hudLayer = [KALayerHUD HUDWithTarget:gameLayer];
		[self addChild:hudLayer];
		
		
	}
	return self;
}

// Causes the player to be spawned at a spawn point on the current floor
-(void)spawnPlayer {
	
	
	
	
}

@end
