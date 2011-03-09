//
//  ASNode.m
//  KeepAssault
//
//  Created by Jay Roberts on 3/6/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import "ASNode.h"


@implementation ASNode

@synthesize lid;
@synthesize location;
@synthesize mCost;
@synthesize score;
@synthesize parent;


+(id)nodeWithLocation:(CGPoint)loc cost:(NSInteger)cost lid:(NSString*)lid {
	ASNode* node = [[ASNode alloc] init];
	
	node.location = loc;
	node.mCost = cost;
	node.lid = lid;
	
	return [node autorelease];
}


@end
