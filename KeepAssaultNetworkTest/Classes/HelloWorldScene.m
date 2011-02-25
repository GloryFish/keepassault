//
//  HelloWorldLayer.m
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright GloryFish.org 2011. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import <GameKit/GameKit.h>
#import "KALayerMovementTest.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		// create and initialize a Label
		CCLabelTTF *label = [CCLabelTTF labelWithString:@"Keep Assault" fontName:@"Helvetica" fontSize:64];
		CGSize size = [[CCDirector sharedDirector] winSize];
		label.position =  ccp(size.width /2 , size.height - 100);
		[self addChild: label];
		
		
		CCMenuItem* createSession = [CCMenuItemFont itemFromString:@"Create Session" 
															target:self 
														  selector:@selector(onCreateSession)];

		CCMenuItem* joinSession = [CCMenuItemFont itemFromString:@"Join Session"
														  target:self 
														selector:@selector(onJoinSession)];

		CCMenuItem* movementTest = [CCMenuItemFont itemFromString:@"Movement Test"
														  target:self 
														selector:@selector(onMovementTest)];
		
		CCMenu* menu = [CCMenu menuWithItems:createSession,
											 joinSession,
											 movementTest,
											 nil];
		
		[menu alignItemsVerticallyWithPadding:30.0f];
		[self addChild:menu];		
	}
	return self;
}


-(void)onCreateSession {
	NSLog(@"Create session");
//	session = [GKSession nitWithSessionID:nil displayName:nil sessionMode:GKSessionModeServer];

}

-(void)onJoinSession {
	NSLog(@"Join session");
//	session = [GKSession nitWithSessionID:nil displayName:nil sessionMode:GKSessionModeServer];
}

-(void)onMovementTest {
	CCScene* newScene = [KALayerMovementTest scene];
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:newScene withColor:ccWHITE]];
	
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
