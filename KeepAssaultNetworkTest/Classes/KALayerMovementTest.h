//
//  KALayerMovementTest.h
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KALayerMovementTest : CCLayer <CCTargetedTouchDelegate> {
	NSMutableArray* players;
}

+(id)scene;

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;

@end
