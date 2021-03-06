//
//  HelloWorldLayer.h
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright GloryFish.org 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import <GameKit/GameKit.h>

// HelloWorld Layer
@interface KALayerMenu : CCLayer <GKMatchmakerViewControllerDelegate> {
	GKSession* gameSession;
	UIViewController* tempVC;
}

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end
