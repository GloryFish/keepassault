//
//  KAAssetManager.h
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 3/1/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KAAssetManager : NSObject {

}

-(CCSprite*)spriteForPlayerAtIndex:(NSInteger)index;

+(KAAssetManager*)sharedManager;

@end
