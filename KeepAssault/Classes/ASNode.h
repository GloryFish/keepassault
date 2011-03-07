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
}

@property (nonatomic, retain) NSString* lid;
@property (nonatomic, assign) CGPoint location;
@property (nonatomic, assign) CGFloat mCost;

@end
