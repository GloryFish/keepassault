//
//  KALayerHUD.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KALayerHUD : CCLayer {
	id delegate;
}

@property (nonatomic, retain) id delegate;

@end
