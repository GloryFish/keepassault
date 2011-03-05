//
//  KAFloor.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAFloor.h"


@implementation KAFloor


-(id)initWithFile:(NSString*)filename {
	if ( (self = [super init]) ) {
		CCTMXTiledMap* tileMap = [CCTMXTiledMap tiledMapWithTMXFile:filename];
		tileMap.scale = 2;
		[self addChild:tileMap];
		
		[tileMap layerNamed:@"Objects"].visible = NO;
	}
	return self;
}


+(id)floorWithTilemapFile:(NSString*)filename {
	KAFloor* floor = [[KAFloor alloc] initWithFile:filename];
	return [floor autorelease];
}

@end
