//
//  KALayerTilemapTest.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALayerTilemapTest.h"


@implementation KALayerTilemapTest

-(id)init {
	if ( (self = [super init]) ) {
		CCTMXTiledMap* tileMap = [CCTMXTiledMap tiledMapWithTMXFile:@"test_tilemap.tmx"];
		tileMap.scale = 2;
		[self addChild:tileMap];
		
	}
	return self;
}


@end
