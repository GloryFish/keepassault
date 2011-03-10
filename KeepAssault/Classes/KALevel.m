//
//  KALevel.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALevel.h"
#import "KAFloor.h"

#define kCurrentFloor 0

@implementation KALevel

@synthesize levelDescription;
@synthesize floors;

-(id)initWithLevelName:(NSString*)levelname {
	if ( (self = [super init]) ) {
		[self loadLevelFile:levelname];

		floors = [[NSMutableArray alloc] init];
		
		if (levelDescription != nil) {
			[self loadFloors];
			
			if ([floors count] != 0) {
				[self setCurrentFloorNumber:0];
			} else {
				NSLog(@"No floors specified in levelDesciption.");
			}
		} else {
			NSLog(@"Can't load floors. Level description is nil.");
		}
	}
	return self;
}


+(id)levelNamed:(NSString*)levelname {
	KALevel* lvl = [[KALevel alloc] initWithLevelName:levelname];
	return [lvl autorelease];
}


#pragma mark -
#pragma mark Loading

// Loads a level description plist file and sets the dictionary to levelDescription
-(void)loadLevelFile:(NSString*)levelname {
	NSString *finalPath = [[NSBundle mainBundle] pathForResource:levelname ofType:@"plist"];
	NSDictionary* temp = [NSDictionary dictionaryWithContentsOfFile:finalPath];
	
	if (!temp) {
		NSLog(@"Error reading plist: %@", finalPath);
		self.levelDescription = nil;
	} else {
		NSLog(@"Loaded file: %@", finalPath);
		levelDescription = temp;
	}
}


// Loads the tilemaps for each of the floors specified in 
-(void)loadFloors {
	if (levelDescription == nil) {
		return;
	}
	
	if ([levelDescription objectForKey:@"floors"] == nil) {
		NSLog(@"No floors specified in levelDescription");
	}
	
	for (NSString* floorFile in [levelDescription objectForKey:@"floors"]) {
		KAFloor* floor = [KAFloor floorWithTilemapFile:floorFile];
		[floors addObject:floor];
	}
}


#pragma mark -
#pragma mark Floor management

-(KAFloor*)currentFloor {
	return (KAFloor*)[self getChildByTag:kCurrentFloor];
}

-(void)setCurrentFloorNumber:(NSInteger)currentFloor {
	KAFloor* newFloor = [floors objectAtIndex:currentFloor];
	
	if (newFloor == nil) {
		return;
	}
	
	[self removeChildByTag:kCurrentFloor cleanup:YES];
	[self addChild:newFloor z:0 tag:kCurrentFloor];
}


-(void)onExit {
	[super onExit];
	[levelDescription release];
	[floors release];
}

#pragma mark -
#pragma mark Coordinates


-(CGPoint)worldToTile:(CGPoint)coords {
	return ccp(floor(coords.x / 32), floor((-coords.y + 768) / 32));
}

-(CGPoint)tileToWorldCorner:(CGPoint)coords {
	return ccp(coords.x * 32, ((-coords.y - 1) * 32) + 768);
}

-(CGPoint)tileToWorldCenter:(CGPoint)coords {
	CGPoint corner = [self tileToWorldCorner:coords];
	CGPoint world = ccpAdd(corner, ccp(16, 16));
	NSLog(@"world: %@", NSStringFromCGPoint(world));
	return world;
}

#pragma mark -
#pragma mark AStarMapHandler

// Returns an ASNode representing a specific location in the map. Sets a unique location id
// which will be the same for any two nodes with the same location.
-(ASNode*)nodeForLocation:(CGPoint)loc {
	if (loc.x < 0 || loc.y < 0) {
		return nil;
	}
	
	if (loc.x > self.currentFloor.size.width - 1 || loc.y > self.currentFloor.size.height - 1) {
		return nil;
	}

	if (![[self currentFloor] tileIsWalkableAtLocation:loc]) {
		return nil;
	}

	ASNode* node = [ASNode nodeWithLocation:loc cost:10 lid:NSStringFromCGPoint(loc)];
	return node;
}

-(ASNode*)nodeForLocation:(CGPoint)loc fromNode:(ASNode*)fromNode withGoal:(CGPoint)goal {
	ASNode* node = [self nodeForLocation:loc];
	
	if (node == nil) {
		return nil;
	}
	
	CGFloat dx = MAX(loc.x, goal.x) - MIN(loc.x, goal.x); 
	CGFloat dy = MAX(loc.y, goal.y) - MIN(loc.y, goal.y); 
	
	CGFloat emCost = dx + dy;
		
	node.mCost = node.mCost + fromNode.mCost;
	node.score = node.mCost + emCost;
	node.parent = fromNode;
		
	return node;
}


// Given a node, return an NSArray containing all adjacent nodes
// Goal is the goal-location for the whole path, used to calculate costs
-(NSDictionary*)getAdjacentNodes:(ASNode*)node goal:(CGPoint)goal {
	NSMutableDictionary* result = [[[NSMutableDictionary alloc] init] autorelease];
	
	ASNode* n;
	
	n = [self nodeForLocation:ccp(node.location.x + 1, node.location.y)
					 fromNode:node
					 withGoal:goal];
	if (n != nil) {
		[result setObject:n forKey:n.lid];
	}	
	
	n = [self nodeForLocation:ccp(node.location.x - 1, node.location.y)
					 fromNode:node
					 withGoal:goal];
	if (n != nil) {
		[result setObject:n forKey:n.lid];
	}

	n = [self nodeForLocation:ccp(node.location.x, node.location.y + 1)
					 fromNode:node
					 withGoal:goal];
	if (n != nil) {
		[result setObject:n forKey:n.lid];
	}

	n = [self nodeForLocation:ccp(node.location.x, node.location.y - 1)
					 fromNode:node
					 withGoal:goal];
	if (n != nil) {
		[result setObject:n forKey:n.lid];
	}

	return result;	
}


-(BOOL)lid:(NSString*)lid isEqualToLocation:(CGPoint)location {
	return [lid isEqualToString:NSStringFromCGPoint(location)];
}

@end
