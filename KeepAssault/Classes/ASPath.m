//
//  ASPath.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/6/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "ASPath.h"
#import "cocos2d.h"


@implementation ASPath

@synthesize nodes;
@synthesize totalCost;

+(id)pathWithNodes:(NSArray*)nodes totalCost:(CGFloat)totalCost {
	ASPath* path = [[ASPath alloc] init];
	path.nodes = nodes;
	path.totalCost = totalCost;
	
	return [path autorelease];
}


@end
