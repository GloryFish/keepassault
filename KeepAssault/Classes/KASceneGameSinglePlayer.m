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

@implementation KASceneGameSinglePlayer

-(id)init {
	if ( (self = [super init]) ) {
		KALayerGame* gameLayer = [KALayerGame node];
		[self addChild:gameLayer];
		
		KALayerHUD* hudLayer = [KALayerHUD node];
		[self addChild:hudLayer];
	}
	return self;
}


@end
