//
//  AStar.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/6/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "AStar.h"
#import "ASPath.h"
#import "ASNode.h"

@implementation AStar

static AStar* sharedPathfinder = nil;

@synthesize open;
@synthesize closed;
@synthesize mapHandler;

-(id)init {
	if ( (self = [super init]) ) {
		self.open = [[[NSMutableDictionary alloc] init] autorelease];
		self.closed = [[[NSMutableDictionary alloc] init] autorelease];
	}
	return self;
}

-(ASNode*)handleNode:(ASNode*)node goal:(CGPoint)goal {
	[open removeObjectForKey:node.lid];
	[closed setObject:node.lid forKey:node.lid];
	
	NSDictionary* nodes = [self.mapHandler getAdjacentNodes:node goal:goal];
	
	for (NSString* lid in nodes) {
		ASNode* n = [nodes objectForKey:lid];
		
		if ([mapHandler location:n.lid isEqualToLocation:goal]) {
			return n;
		} else if([closed objectForKey:n.lid] != nil) {
			break;
		} else if ([open objectForKey:n.lid] != nil) {
			ASNode* on = [open objectForKey:n.lid];
			
			if (n.mCost < on.mCost) {
				[open removeObjectForKey:n.lid];
				[open setObject:n forKey:n.lid];
			} else {
				[open setObject:n forKey:n.lid];
			}
			
		}
		
	}

	return nil;
}


-(ASPath*)findPathFrom:(CGPoint)start To:(CGPoint)end {
	[open removeAllObjects];
	[closed removeAllObjects];
	
	CGPoint goal = end;
	ASNode* fnode = [mapHandler nodeForLocation:start];
	
	ASNode* nextNode = nil;
	
	if (fnode != nil) {
		[open setObject:fnode forKey:fnode.lid];
		nextNode = fnode;
	}
		
	while (nextNode != nil) {
		ASNode* finish = [self handleNode:nextNode goal:goal];
		
		if (finish != nil) {
			return [self tracePath:finish];
		}
		
		nextNode = [self getBestOpenNode];
	}
			
	return nil;
}





#pragma mark -
#pragma mark Singleton

+(AStar*)sharedPathfinder {
	@synchronized(self)
	{
		if (sharedPathfinder == nil)
			sharedPathfinder = [[AStar alloc] init];
	}
	return sharedPathfinder;
}

+(id)allocWithZone:(NSZone *)zone {
	@synchronized(self) {
		if (sharedPathfinder == nil) {
			sharedPathfinder = [super allocWithZone:zone];
			return sharedPathfinder;  // assignment and return on first allocation
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
