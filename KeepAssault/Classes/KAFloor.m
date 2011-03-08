//
//  KAFloor.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAFloor.h"


@implementation KAFloor

@synthesize playerSpawns;

-(id)initWithFile:(NSString*)filename {
	if ( (self = [super init]) ) {
		tileMap = [CCTMXTiledMap tiledMapWithTMXFile:filename];
		tileMap.scale = 2;
		[self addChild:tileMap];
		
		[tileMap layerNamed:@"spawn"].visible = NO;
		[self loadPlayerSpawns];
	}
	return self;
}


+(id)floorWithTilemapFile:(NSString*)filename {
	KAFloor* floor = [[KAFloor alloc] initWithFile:filename];
	return [floor autorelease];
}


-(void)loadPlayerSpawns {
	CCTMXLayer* spawnLayer = [tileMap layerNamed:@"spawn"];
	
	NSMutableArray* spawns = [[NSMutableArray alloc] init];
	
	for (int x = 0; x < spawnLayer.layerSize.width; x++) {
		for (int y = 0; y < spawnLayer.layerSize.height; y++) {
			if	([spawnLayer tileGIDAt:ccp(x, y)] != 0) {
				[spawns addObject:[NSValue valueWithCGPoint:ccp(x, y)]];
			}
		}
	}
	
	playerSpawns = spawns;
	
	NSLog(@"Loaded playerSpawns: %@", playerSpawns);
}

-(CGSize)size {
	return tileMap.mapSize;
}


-(void)onExit {
	[super onExit];
	[tileMap release];
}

@end
