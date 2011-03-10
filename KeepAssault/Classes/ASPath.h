//
//  ASPath.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/6/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ASPath : CCNode {
	NSArray* nodes;
	CGFloat totalCost;
}

@property (nonatomic, retain) NSArray* nodes;
@property (nonatomic, assign) CGFloat totalCost;

+(id)pathWithNodes:(NSArray*)nodes totalCost:(CGFloat)totalCost;

@end
