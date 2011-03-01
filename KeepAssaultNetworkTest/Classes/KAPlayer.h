//
//  KAPlayer.h
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KAPlayer : CCNode {
	CGPoint movement;
	CGFloat baseSpeed;
	CGPoint target;
	CCSprite* sprite;
	NSInteger index;
}

@property (nonatomic, assign) CGPoint target; 
@property (nonatomic, assign) NSInteger index; 

-(void)update:(ccTime)dt;


@end
