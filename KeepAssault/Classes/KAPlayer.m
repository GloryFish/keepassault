//
//  KAPlayer.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAPlayer.h"
#import "KAPlayerStates.h"

@implementation KAPlayer

@synthesize level;
@synthesize path;
@synthesize target;
@synthesize currentDirection;
@synthesize currentAnimationAction;
@synthesize playerSprite;
@synthesize animations;

-(id)init {
	if ( (self = [super init]) ) {
		speed = 256.0f;
        
        stateMachine = [[FSM alloc] initWithActor:self stateClass:[KAStatePlayerIdle class]];
        
        [self buildAnimations];
        
        // Set inital player state
//        currentDirection = @"down";

        
		[self scheduleUpdate];
	}
	return self;
}

- (void) setPath: (NSMutableArray *) newValue {
    [path autorelease];
    path = [newValue retain];
    
    [stateMachine changeStateWithClass:[KAStatePlayerFollowPath class]];
    
}

// Called by init to prepare all of the animations needed by the Player
-(void)buildAnimations {
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"player_zwoptex.plist"];
    
    CCSpriteBatchNode* spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"player_zwoptex.png"];
    [self addChild:spriteSheet];
    
    animations = [NSMutableDictionary dictionaryWithCapacity:4];
    
    
    NSArray* directions = [NSArray arrayWithObjects:@"up", @"down", @"left", @"right", nil];
    
    // Prepare walk animations
    for (NSString* dir in directions) {
        NSMutableArray *walkFrames = [[NSMutableArray alloc] init];
        for(int i = 1; i <= 2; ++i) {
            [walkFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"player_walk_%@_%d.png", dir, i]]];
        }
        
        CCAnimation* walkAnimation = [CCAnimation animationWithFrames:walkFrames delay:0.2];
        [animations setObject:walkAnimation forKey:[NSString stringWithFormat:@"walk_%@", dir]];
        [walkFrames release];
    }
    
    // Prepare standing animations
    for (NSString* dir in directions) {
        CCSpriteFrame* standFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"player_stand_%@.png", dir]];
        CCAnimation* standAnimation = [CCAnimation animationWithFrames:[NSArray arrayWithObject:standFrame] delay:0.2];
        [animations setObject:standAnimation forKey:[NSString stringWithFormat:@"stand_%@", dir]];
    }
    
    // Set an initial player state
    playerSprite = [CCSprite spriteWithSpriteFrameName:@"player_stand_down.png"];
    [spriteSheet addChild:playerSprite];
}

-(void)playAnimation:(NSString *)animationName {
    // Set animation here
}

-(void)update:(ccTime)dt {
    [stateMachine update:dt];
    
	if (ccpFuzzyEqual(self.position, target, 5.0f)) {
		self.position = target;
	} else {
		// Move towards target
		CGPoint movementVector = ccpSub(target, self.position);
		if (!CGPointEqualToPoint(movementVector, CGPointZero)) {
			movementVector = ccpNormalize(movementVector);
		}
		movementVector = ccpMult(movementVector, speed);
		movementVector = ccpMult(movementVector, dt);
		
		NSLog(@"target: %@", NSStringFromCGPoint(target));
		
		NSLog(@"position: %@", NSStringFromCGPoint(self.position));
		
		NSLog(@"movement: %@", NSStringFromCGPoint(movementVector));
		
		self.position = ccpAdd(self.position, movementVector);
        
        // Handle direction changes
        NSString* newDirection = [self directionNameFromVector:movementVector];
        
        if (![currentDirection isEqualToString:newDirection]) {
            // Change direction
            
        }
        
        
	}
}

-(NSString*)directionNameFromVector:(CGPoint)vector {
    if (CGPointEqualToPoint(vector, CGPointZero)) {
        return @"down";
    }
    
    if (fabs(vector.y) > fabs(vector.x)) {
        if (vector.y > 0) {
            return @"up";
        } else {
            return @"down";
        }
    } else {
        if (vector.x > 0) {
            return @"right";
        } else {
            return @"left";
        }
    }
}


-(void)respawnAtWorldPosition:(CGPoint)pos {
	NSLog(@"setting pos: %@", NSStringFromCGPoint(pos));

	self.position = pos;
	target = pos;
}

-(void)onExit {
    self.animations = nil;
    self.playerSprite = nil;
}

@end
