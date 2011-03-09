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
#import "KAReticle.h"
#import "AStar.h"

@implementation KALayerGame

@synthesize currentLevel;

-(id)init {
	if ( (self = [super init]) ) {
		self.isTouchEnabled = YES;
		
		currentLevel = [KALevel levelNamed:@"test"];
		[self addChild:currentLevel];
		
		reticle = [KAReticle spriteWithFile:@"reticle.png"];
		reticle.visible = NO;
		reticle.color = ccRED;
		[self addChild:reticle];
		
		[AStar sharedPathfinder].mapHandler = currentLevel;
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

#pragma mark -
#pragma mark CCTargetedTouchDelegate


-(void)registerWithTouchDispatcher {
	[[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace:touch];
	location = [self convertToWorldSpace:location];

	reticle.visible = YES;
	
	CGPoint tileCoordsReticle = [currentLevel worldToTile:location];
	NSLog(@"tile: %@", NSStringFromCGPoint(tileCoordsReticle));
	
	reticle.position = [currentLevel tileToWorldCenter:tileCoordsReticle];
	
	NSLog(@"reticle: %@", NSStringFromCGPoint(reticle.position));
	
	CGPoint tileCoordsPlayer = [currentLevel worldToTile:player.position];
	
	// Get path
	ASPath* path = [[AStar sharedPathfinder] findPathFrom:tileCoordsPlayer To:tileCoordsReticle];
		
	
	return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace:touch];
	location = [self convertToWorldSpace:location];
}

@end
