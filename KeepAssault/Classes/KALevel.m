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
				[self addChild:[floors objectAtIndex:0] z:0 tag:kCurrentFloor]; // By default, begin with the first floor in the level
			}
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

-(void)onExit {
	[levelDescription release];
	[floors release];
}
									
@end
