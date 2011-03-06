//
//  KAPlayer.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAPlayer.h"


@implementation KAPlayer

-(id)init {
	if ( (self = [super init]) ) {
		CCSprite* sprite = [CCSprite spriteWithFile:@"player.png"];
		[self addChild:sprite];
	}
	return self;
}

@end
