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
}
@end
