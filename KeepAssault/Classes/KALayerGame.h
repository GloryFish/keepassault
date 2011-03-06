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

@interface KALayerGame : CCLayer {
	KALevel* currentLevel;
	KAPlayer* player;
}

@property (nonatomic, retain) KALevel* currentLevel;

-(void)setPlayer:(KAPlayer*)p;
-(void)spawnPlayer;


@end
