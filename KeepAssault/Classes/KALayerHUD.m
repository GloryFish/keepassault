//
//  KALayerHUD.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALayerHUD.h"


@implementation KALayerHUD

@synthesize delegate;

-(id)init {
	if ( (self = [super init]) ) {
		CCMenuItem* spawnPlayer = [CCMenuItemFont itemFromString:@"Spawn player" target:delegate selector:@selector(spawnPlayer)];
		
		CCMenu* menu = [CCMenu menuWithItems:spawnPlayer, nil];
		[menu alignItemsVerticallyWithPadding:30.0f];
		[self addChild:menu];
		
	}
	return self;
}


@end
