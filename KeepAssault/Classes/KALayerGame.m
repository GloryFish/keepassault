//
//  KALayerTilemapTest.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALayerGame.h"
#import "KALevel.h"
#import "KAPlayer.h"

@implementation KALayerGame

@synthesize currentLevel;

-(id)init {
	if ( (self = [super init]) ) {
		currentLevel = [KALevel levelNamed:@"test"];
		[self addChild:currentLevel];
	}
	return self;
}

-(void)setPlayer:(KAPlayer*)p {
	if (player != nil) {
		NSAssert(NO, @"player can only be set once");
	}
	
	player = p;
	[self addChild:player];
}


-(void)spawnPlayer {
	NSArray* spawns = [[currentLevel currentFloor] playerSpawns];
	
	NSUInteger randomIndex = arc4random() % [spawns count];
	
	CGPoint spawnLocation = [[spawns objectAtIndex:randomIndex] CGPointValue];

	NSLog(@"Spawning player at: %@", NSStringFromCGPoint(spawnLocation));

	player.position = [currentLevel tileToWorldCenter:spawnLocation];
	
	NSLog(@"World: %@", NSStringFromCGPoint(player.position));
}

@end
