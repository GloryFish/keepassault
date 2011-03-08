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
-(BOOL)location:(NSString*)lid isEqualToLocation:(CGPoint)location;
  
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

-(ASPath*)findPathFrom:(CGPoint)start To:(CGPoint)end;
-(ASNode*)handleNode:(ASNode*)node goal:(CGPoint)goal;
-(ASPath*)tracePath:(ASNode*)node;
-(ASNode*)getBestOpenNode;

@end
