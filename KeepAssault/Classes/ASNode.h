//
//  ASNode.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/6/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ASNode : NSObject {
	NSString* lid;
	CGPoint location;
	CGFloat mCost;
	CGFloat score;
	ASNode* parent;
}

@property (nonatomic, retain) NSString* lid;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) CGFloat mCost;
@property (nonatomic, assign) CGFloat score;
@property (nonatomic, retain) ASNode* parent;


+(id)nodeWithLocation:(CGPoint)loc cost:(NSInteger)cost lid:(NSString*)lid;

@end
