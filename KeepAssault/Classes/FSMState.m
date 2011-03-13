//
//  FSMState.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/12/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "FSMState.h"
#import "FSM.h"
#import "KAActor.h"

@implementation FSMState

@synthesize fsm = mFSM;

-(id)initWithFSM:(FSM*)anFSM {
	if( ![super init] )
		return nil;
    
	fsm = anFSM;
    
	return self;
}

-(void)enter:(FSMState*)prevState {
}

-(void)exit:(FSMState*)nextState {
}

-(void)update:(float)dt {
}

-(BOOL)updateTransitions:(float)dt {
	return NO;
}

@end