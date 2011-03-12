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

@interface KAPlayer : CCNode {
	NSMutableArray* path; // An array of locations to travel to
	KALevel* level;
	CGFloat speed;
	CGPoint target;
    
    CCSprite* playerSprite;
    NSMutableDictionary* animations;
    
}

@property (nonatomic, retain) KALevel* level;
@property (nonatomic, retain) NSMutableArray* path;
@property (nonatomic, retain) CCSprite* playerSprite;
@property (nonatomic, retain) NSMutableDictionary* animations;

-(void)buildAnimations;
-(void)update:(ccTime)dt;
-(void)followPath;
-(void)respawnAtWorldPosition:(CGPoint)pos;

@end
