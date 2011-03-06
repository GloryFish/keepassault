//
//  KAFloor.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KAFloor : CCNode {
	CCTMXTiledMap* tileMap;
	NSArray* playerSpawns;
}

@property (nonatomic, retain) NSArray* playerSpawns;

+(id)floorWithTilemapFile:(NSString*)filename;

-(void)loadPlayerSpawns;

@end
