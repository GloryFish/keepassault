//
//  KALayerTilemapTest.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALayerGame.h"
#import "KALevel.h"

@implementation KALayerGame

-(id)init {
	if ( (self = [super init]) ) {
		KALevel* level = [KALevel levelNamed:@"test"];
		[self addChild:level];
	}
	return self;
}


@end