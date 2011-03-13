//
//  FSMState.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/12/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

@class FSM;

@interface FSMState : NSObject {
	FSM* fsm;
}

@property(nonatomic, readonly) FSM* fsm;

-(id)initWithFSM:(FSM*)fsm;

-(void)enter:(FSMState*)prevState;
-(void)exit:(FSMState*)nextState;

-(void)update:(float)dt;
-(BOOL)updateTransitions:(float)dt;

@end