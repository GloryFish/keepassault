//
//  ASPath.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/6/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "ASPath.h"


@implementation ASPath

+(id)pathWithNodes:(NSArray*)nodes totalCost:(CGFloat)totalCost {
	ASPath* path = [[ASPath alloc] init];
	
	return [path autorelease];
}


@end
