//
//  AStar.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/6/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASPath.h"
#import "ASNode.h"

@protocol AStarMapHandler <NSObject>

-(ASNode*)nodeForLocation:(CGPoint)loc;
-(NSDictionary*)getAdjacentNodes:(ASNode*)node goal:(CGPoint)goal;
-(BOOL)lid:(NSString*)lid isEqualToLocation:(CGPoint)location;
  
@end


@interface AStar : NSObject {
	NSMutableDictionary* open;
	NSMutableDictionary* closed;
	id <AStarMapHandler> mapHandler;
}

@property (nonatomic, retain) NSMutableDictionary* open;
@property (nonatomic, retain) NSMutableDictionary* closed;
@property (nonatomic, retain) id <AStarMapHandler> mapHandler;


+(AStar*)sharedPathfinder;

-(NSMutableArray*)findPathFrom:(CGPoint)start To:(CGPoint)end;
-(ASNode*)handleNode:(ASNode*)node goal:(CGPoint)goal;
-(NSMutableArray*)tracePath:(ASNode*)node;
-(ASNode*)getBestOpenNode;

@end
