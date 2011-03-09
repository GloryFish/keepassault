//
//  KALevel.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "KAFloor.h"
#import "AStar.h"

@interface KALevel : CCNode <AStarMapHandler> {
	NSDictionary* levelDescription;
	NSMutableArray* floors;
}

@property (nonatomic, retain) NSDictionary* levelDescription;
@property (nonatomic, retain) NSMutableArray* floors;

+(id)levelNamed:(NSString*)levelname;

-(void)loadLevelFile:(NSString*)levelname;
-(void)loadFloors;

-(KAFloor*)currentFloor;
-(void)setCurrentFloorNumber:(NSInteger)currentFloor;

-(CGPoint)worldToTile:(CGPoint)coords;
-(CGPoint)tileToWorldCorner:(CGPoint)coords;
-(CGPoint)tileToWorldCenter:(CGPoint)coords;

-(ASNode*)nodeForLocation:(CGPoint)loc;
-(ASNode*)nodeForLocation:(CGPoint)loc fromNode:(ASNode*)fromNode withGoal:(CGPoint)goal;
-(NSArray*)getAdjacentNodes:(ASNode*)node goal:(CGPoint)goal;
-(BOOL)location:(NSString*)lid isEqualToLocation:(CGPoint)location;

@end
