//
//  KAPlayer.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "KALevel.h"
#import "KAActor.h"
#import "FSM.h"

@interface KAPlayer : CCNode <KAActor> {
	NSMutableArray* path; // An array of locations to travel to
	KALevel* level;
	CGFloat speed;
	CGPoint target;
    CCAction* currentAnimationAction;
    
    CCSprite* playerSprite;
    NSMutableDictionary* animations;
    
    FSM* stateMachine;
    
}

@property (nonatomic, retain) KALevel* level;
@property (nonatomic, retain) NSMutableArray* path;
@property (nonatomic, assign) CGPoint target;
@property (nonatomic, retain) NSString* currentDirection;
@property (nonatomic, retain) CCAction* currentAnimationAction;
@property (nonatomic, retain) CCSprite* playerSprite;
@property (nonatomic, retain) NSMutableDictionary* animations;


-(void)buildAnimations;
-(void)playAnimation:(NSString *)animationName repeat:(BOOL)repeat;
-(void)update:(ccTime)dt;
-(void)respawnAtWorldPosition:(CGPoint)pos;
-(NSString*)directionNameFromVector:(CGPoint)vector;

@end
