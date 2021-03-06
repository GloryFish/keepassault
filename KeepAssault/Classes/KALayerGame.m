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

#define kInfoLabelTag 44

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
		
		infoLabel = [CCLabelTTF labelWithString:@"..." fontName:@"Helvetica" fontSize:24];
		infoLabel.position = ccp(200, 700);
		[self addChild:infoLabel];
		infoLabel.color = ccBLACK;
		
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
    
    if ([spawns count] == 0) {
        return;
    }
	
	NSUInteger randomIndex = arc4random() % [spawns count];
	
	CGPoint spawnLocation = [[spawns objectAtIndex:randomIndex] CGPointValue];

	NSLog(@"Spawning player at: %@", NSStringFromCGPoint(spawnLocation));

	[player respawnAtWorldPosition:[currentLevel tileToWorldCenter:spawnLocation]];
	
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

    CGPoint tileCoordsReticle = [currentLevel worldToTile:location];
	CGPoint tileCoordsPlayer = [currentLevel worldToTile:player.position];

    BOOL walkable = [[currentLevel currentFloor] tileIsWalkableAtLocation:tileCoordsReticle];
    
    if (walkable) {
        // Display reticle
        reticle.visible = YES;
        reticle.position = [currentLevel tileToWorldCenter:tileCoordsReticle];

        // Get path
        NSMutableArray* nodes = [[AStar sharedPathfinder] findPathFrom:tileCoordsPlayer To:tileCoordsReticle];
        player.path = nodes;
    }
	
	
	return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
	CGPoint location = [self convertTouchToNodeSpace:touch];
	location = [self convertToWorldSpace:location];
}

@end
