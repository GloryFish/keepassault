//
//  KAPlayer.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAPlayer.h"


@implementation KAPlayer

@synthesize level;
@synthesize path;

@synthesize playerSprite;
@synthesize animations;

-(id)init {
	if ( (self = [super init]) ) {
		speed = 256.0f;
        
        [self buildAnimations];
        
		[self scheduleUpdate];
	}
	return self;
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
        NSMutableArray *walkFrames = [NSMutableArray array];
        for(int i = 1; i <= 2; ++i) {
            [walkFrames addObject:
             [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:
              [NSString stringWithFormat:@"player_walk_%@_%d.png", dir, i]]];
        }
        
        CCAnimation* walkAnimation = [CCAnimation animationWithFrames:walkFrames delay:0.2];
        [animations setObject:walkAnimation forKey:[NSString stringWithFormat:@"walk_%@", dir]];
    }
    
    
    // Set inital player state
    playerSprite = [CCSprite spriteWithSpriteFrameName:@"player_stand_down.png"];
    [spriteSheet addChild:playerSprite];
}

-(void)update:(ccTime)dt {
	[self followPath];

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
	}
}

-(void)followPath {
	if (path != nil && [path count] > 0) {
		// Are we close enough to the next path location? If so, remove it
		CGPoint nextTile = [[path objectAtIndex:0] CGPointValue];		
		CGPoint nextWorld = [level tileToWorldCenter:nextTile];
		
		if (ccpFuzzyEqual(self.position, nextWorld, 5.0f)) {
			[path removeObjectAtIndex:0];
			
			nextTile = [[path objectAtIndex:0] CGPointValue];
			nextWorld = [level tileToWorldCenter:nextTile];
		}
		
		target = nextWorld;
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
