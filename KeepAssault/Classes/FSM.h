//
//  FSM.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/12/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAActor.h"

@class FSMState;

@interface FSM : NSObject {
	id <KAActor> actor;
	FSMState*	state;
}

@property(nonatomic, readonly) id <KAActor> actor;
@property(nonatomic, readonly) FSMState* state;

-(id)initWithActor:(id<KAActor>)actor stateClass:(Class)stateClass;

-(void)changeStateWithClass:(Class)stateClass;

-(void)update:(float)dt;
-(void)updateTransitions:(float)dt;

@end