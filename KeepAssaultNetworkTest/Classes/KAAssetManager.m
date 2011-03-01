//
//  KAAssetManager.m
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 3/1/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAAssetManager.h"
#import "cocos2d.h"

@implementation KAAssetManager

static KAAssetManager *sharedManager = nil;


-(CCSprite*)spriteForPlayerAtIndex:(NSInteger)index {
	if (index == 0) {
		return [CCSprite spriteWithFile:@"player_one.png"];
	} else {
		return [CCSprite spriteWithFile:@"player_two.png"];
	}
}



#pragma mark -
#pragma mark Singleton

+(KAAssetManager*)sharedManager {
	@synchronized(self)
	{
		if (sharedManager == nil)
			sharedManager = [[KAAssetManager alloc] init];
	}
	return sharedManager;
}

+(id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedManager == nil) {
			sharedManager = [super allocWithZone:zone];
			return sharedManager;  // assignment and return on first allocation
		}
	}
	return nil; // on subsequent allocation attempts return nil
}

-(id)copyWithZone:(NSZone *)zone {
	return self;
}

-(id)retain {
	return self;
}

-(unsigned)retainCount {
	return UINT_MAX;  // denotes an object that cannot be released
}

-(void)release {
	//do nothing
}

-(id)autorelease {
	return self;
}


@end
