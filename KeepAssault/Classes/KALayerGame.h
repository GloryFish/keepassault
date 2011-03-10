//
//  KALayerTilemapTest.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "KALevel.h"
#import "KAPlayer.h"
#import "KAReticle.h"

@interface KALayerGame : CCLayer <CCTargetedTouchDelegate> {
	KALevel* currentLevel;
	KAPlayer* player;
	KAReticle* reticle;
	CCLabelTTF* infoLabel;
}

@property (nonatomic, retain) KALevel* currentLevel;

-(void)setPlayer:(KAPlayer*)p;
-(void)spawnPlayer;

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event;
-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event;

@end
