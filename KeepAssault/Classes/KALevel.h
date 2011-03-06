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

@interface KALevel : CCNode {
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

@end
