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
	NSLog(@"handleNode - %@", node.lid);

	[open removeObjectForKey:node.lid];
	[closed setObject:node.lid forKey:node.lid];
	
	NSDictionary* nodes = [self.mapHandler getAdjacentNodes:node goal:goal];
	
	NSLog(@"handleNode - Got %i adjacent nodes", [nodes count]);
	
	for (NSString* lid in nodes) {
		ASNode* n = [nodes objectForKey:lid];
		NSLog(@"handleNode - processing %@", n.lid);
		
		if ([mapHandler lid:n.lid isEqualToLocation:goal]) {
			NSLog(@"handleNode - node is goal %@, returning", n.lid);
			return n;
		} else if([closed objectForKey:n.lid] != nil) {
			NSLog(@"handleNode - already examined %@, skipping", n.lid);
			break;
		} else if ([open objectForKey:n.lid] != nil) {
			ASNode* on = [open objectForKey:n.lid];
			
			if (n.mCost < on.mCost) {
				[open removeObjectForKey:n.lid];
				[open setObject:n forKey:n.lid];
				NSLog(@"handleNode - Better mCost for %@, added node to open", n.lid);
			} else {
				NSLog(@"handleNode - mCost for N %@ is %f, mCost for ON %@ is %f skipping", n.lid, n.mCost, on.lid, on.mCost);

			}
		} else {
			[open setObject:n forKey:n.lid];
			NSLog(@"handleNode - Added node to open: %@", n.lid);
		}
	}

	return nil;
}


-(ASPath*)findPathFrom:(CGPoint)start To:(CGPoint)end {
	NSLog(@"findPath: %@ - %@", NSStringFromCGPoint(start), NSStringFromCGPoint(end));
	
	[open removeAllObjects];
	[closed removeAllObjects];
	
	CGPoint goal = end;
	ASNode* fnode = [mapHandler nodeForLocation:start];
	
	ASNode* nextNode = nil;
	
	if (fnode != nil) {
		NSLog(@"findPath - fnode is not nil");
		[open setObject:fnode forKey:fnode.lid];
		nextNode = fnode;
	}
		
	while (nextNode != nil) {
		NSLog(@"findPath - processing nextNode: %@", nextNode.lid);

		ASNode* finish = [self handleNode:nextNode goal:goal];
		
		if (finish != nil) {
			NSLog(@"findPath - reached goal: %@", finish.lid);
			return [self tracePath:finish];
		}
		
		nextNode = [self getBestOpenNode];
	}

	NSLog(@"returning nil at end of findPathFrom:To:");

	return nil;
}

-(ASPath*)tracePath:(ASNode*)node {
	NSLog(@"tracePath");

	NSMutableArray* nodes = [[NSMutableArray alloc] init];

	CGFloat totalCost = node.mCost;
	
	ASNode* p = node.parent;
	
	[nodes insertObject:node atIndex:0];
	
	
	while (YES) {
		if (p.parent == nil) {
			break;
		}
		[nodes insertObject:p atIndex:0];
		
		p = p.parent;
	}
	
	return [ASPath pathWithNodes:nodes totalCost:totalCost];
}

-(ASNode*)getBestOpenNode {
	NSLog(@"getBestOpenNode");

	ASNode* bestNode = nil;

	if ([open count] == 0) {
		NSLog(@"getBestOpenNode - No nodes in open set to examine!");
	}
	
	for (NSString* lid in open) {
		ASNode* n = [open objectForKey:lid];
		
		NSLog(@"getBestOpenNode - Examining: %@", n.lid);
		
		if (bestNode == nil) {
			bestNode = n;
		} else {
			if (n.score <= bestNode.score) {
				bestNode = n;
			}
		}
		
	}
	
	if (bestNode == nil) {
		NSLog(@"getBestOpenNode - bestNode is nil");
	}
	NSLog(@"getBestopenNode - bestNode is %@", bestNode.lid);
	
	return bestNode;
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
