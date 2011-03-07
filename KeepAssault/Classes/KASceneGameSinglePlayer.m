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
		player = [KAPlayer node];
		player.position = ccp(100, 100);

		gameLayer = [KALayerGame node];
		[gameLayer setPlayer:player];
		[self addChild:gameLayer];
		
		hudLayer = [KALayerHUD HUDWithTarget:gameLayer];
		[self addChild:hudLayer];
		
		// Start
		[gameLayer spawnPlayer];
	}
	return self;
}


@end
