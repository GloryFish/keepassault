//
//  KAPlayerStates.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/12/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "cocos2d.h"
#import "KAPlayerStates.h"
#import "FSM.h"
#import "KAActor.h"

@implementation KAStatePlayerIdle

-(void)enter:(FSMState*)prevState {
	[super enter:prevState];

    [fsm.actor playAnimation:@"stand_down"];
    
    NSLog(@"entered state: KAStatePlayerIdle");
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


@implementation KAStatePlayerFollowPath
    
-(void)enter:(FSMState*)prevState {
    [super enter:prevState];
    NSLog(@"entered state: KAStatePlayerFollowPath");

    CGPoint nextTile = [[fsm.actor.path objectAtIndex:0] CGPointValue];		
    CGPoint nextWorld = [fsm.actor.level tileToWorldCenter:nextTile];
    fsm.actor.target = nextWorld;
    
    NSLog(@"target is %@", NSStringFromCGPoint(fsm.actor.target));
}
    
-(void)update:(float)dt {
    NSMutableArray* path = fsm.actor.path;
    KALevel* level = fsm.actor.level;

    
    // Get target from path
    if (ccpFuzzyEqual(fsm.actor.position, fsm.actor.target, 2.0f)) {
        // Actor has reached the target, pop that target and get the next one
        [path removeObjectAtIndex:0];
        if ([path count] > 0) {
            CGPoint nextTile = [[path objectAtIndex:0] CGPointValue];		
            CGPoint nextWorld = [level tileToWorldCenter:nextTile];
            fsm.actor.target = nextWorld;
        }
    }

    CGPoint movementVector = ccpSub(fsm.actor.target, fsm.actor.position);
    movementVector = ccpNormalize(movementVector);
    movementVector = ccpMult(movementVector, 128.0f * dt);
    fsm.actor.position = ccpAdd(fsm.actor.position, movementVector);
}
    
-(BOOL)updateTransitions:(float)dt {
    if ([fsm.actor.path count] == 0) { // Reached final path target
        [fsm changeStateWithClass:[KAStatePlayerIdle class]];
        return YES;
    }

    return [super updateTransitions:dt];
}

@end