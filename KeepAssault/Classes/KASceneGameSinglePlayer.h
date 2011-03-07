//
//  KASceneGameSinglePlayer.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "KAPlayer.h"
#import "KALayerGame.h"
#import "KALayerHUD.h"

@interface KASceneGameSinglePlayer : CCScene {
	KAPlayer* player;
	KALayerGame* gameLayer;
	KALayerHUD* hudLayer;
}

@end
