//
//  KALayerHUD.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/5/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KALayerHUD.h"


@implementation KALayerHUD

-(id)init {
	if ( (self = [super init]) ) {
		
		CCLabelTTF* label = [CCLabelTTF labelWithString:@"test label" fontName:@"Helvetica" fontSize:30];
		label.position = ccp(100, 100);
		label.color = ccBLACK;
		[self addChild:label];
		
	}
	return self;
}


@end
