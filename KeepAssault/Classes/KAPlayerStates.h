//
//  KAPlayerStates.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/12/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "FSMState.h"

@interface KAStatePlayerIdle : FSMState {
    BOOL targetSet;
}
@end

@interface KAStatePlayerFollowPath : FSMState {
    NSString* direction;
}

@property (nonatomic, retain) NSString* direction;

-(NSString*)directionNameFromVector:(CGPoint)vector;

@end


@interface KAStatePlayerSpawn : FSMState {
    ccTime elapsed;
}
@end