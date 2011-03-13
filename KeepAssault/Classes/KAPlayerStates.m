//
//  KAPlayerStates.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/12/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAPlayerStates.h"
#import "FSM.h"
#import "KAActor.h"

@implementation KAStatePlayerIdle

-(void)enter:(FSMState*)prevState {
	[super enter:prevState];
    
	[fsm.actor playAnimation:@"Idle"];
}

-(void)update:(float)dt {
	// for the sake of the example code:
	// check to see if jump input was received, and if so, set jumpPressed to YES
}

-(BOOL)updateTransitions:(float)dt {
	// see if we should jump, and change state.
	// note that we return YES to indicate the state was changed.
//	if( jumpPressed ) {
//		[fsm changeStateWithClass:[Jump class]];
//		return YES;
//	}
    
	return [super updateTransitions:dt];
}

@end