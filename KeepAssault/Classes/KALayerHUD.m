//
//  KALayerHUD.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALayerHUD.h"


@implementation KALayerHUD

+(id)HUDWithTarget:(id)target {
	KALayerHUD* hud = [[KALayerHUD alloc] initWithTarget:target];
	return [hud autorelease];
}

-(id)initWithTarget:(id)target {
	if ( (self = [super init]) ) {
		CCMenuItem* spawnPlayer = [CCMenuItemFont itemFromString:@"Spawn player" target:target selector:@selector(spawnPlayer)];
		CCMenu* menu = [CCMenu menuWithItems:spawnPlayer, nil];
		[menu alignItemsVerticallyWithPadding:30.0f];
		menu.position = ccp(200, 650);
		
		[self addChild:menu];
		
	}
	return self;
}


@end
