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
}
    
-(void)update:(float)dt {
    NSMutableArray* path = fsm.actor.path;
    KALevel* level = fsm.actor.level;
    
    if (path != nil && [path count] > 0) {
		// Are we close enough to the next path location? If so, remove it
		CGPoint nextTile = [[path objectAtIndex:0] CGPointValue];		
		CGPoint nextWorld = [level tileToWorldCenter:nextTile];
		
		if (ccpFuzzyEqual(fsm.actor.position, nextWorld, 5.0f)) {
			[path removeObjectAtIndex:0];
			
			nextTile = [[path objectAtIndex:0] CGPointValue];
			nextWorld = [level tileToWorldCenter:nextTile];
		}
		
		fsm.actor.target = nextWorld;
	}	
}
    
-(BOOL)updateTransitions:(float)dt {
    return [super updateTransitions:dt];
}

@end