//
//  KAActor.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/12/11.
//  Copyright 2011 GloryFish.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KALevel.h"

@protocol KAActor <NSObject>
    
-(void)playAnimation:(NSString*)animationName repeat:(BOOL)repeat;
-(NSMutableArray*)path;
-(KALevel*)level;
-(CGPoint)position;
-(void)setPosition:(CGPoint)position;
-(CGPoint)target;
-(void)setTarget:(CGPoint)target;

@end
