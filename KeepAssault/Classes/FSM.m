//
//  FSM.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/12/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "FSM.h"
#import "FSMState.h"
#import "KAActor.h"

@implementation FSM

@synthesize actor;
@synthesize state;

-(id)initWithActor:(id<KAActor>)anActor stateClass:(Class)stateClass {
	if( ![super init] )
		return nil;
    
	actor = anActor;	
    
	[self changeStateWithClass:stateClass];
    
	return self;
}

-(void)changeStateWithClass:(Class)stateClass {
	FSMState* prevState = state;
	FSMState* nextState = [[stateClass alloc] initWithFSM:self];
    
	[state exit:nextState];
	state = nextState;
	[state enter:prevState];
    
	[prevState release];
}

-(void)update:(float)dt {
	[state update:dt];
}

-(void)updateTransitions:(float)dt {
	[state updateTransitions:dt];
}

-(void)dealloc {
	// pass nil as the next state to indicate that the state machine is shutting down.
	[state exit:nil];
	[state release];
    
	[super dealloc];
}

@end
