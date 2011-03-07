//
//  KAReticle.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/6/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "KAReticle.h"


@implementation KAReticle

-(void)setPosition:(CGPoint)pos {
	[super setPosition:pos];
	
	self.scale = 2.0f;
	[self runAction: [CCScaleTo actionWithDuration:0.2f scale:1.2f]]; 
}


@end
