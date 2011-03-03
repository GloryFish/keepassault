//
//  HelloWorldLayer.m
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright GloryFish.org 2011. All rights reserved.
//

// Import the interfaces
#import "KALayerMenu.h"
#import <GameKit/GameKit.h>
#import "KALayerMovementTest.h"

// HelloWorld implementation
@implementation KALayerMenu

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	KALayerMenu *layer = [KALayerMenu node];
	
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
		
		
		CCMenuItem* singlePlayer = [CCMenuItemFont itemFromString:@"Single Player" 
															target:self 
														  selector:@selector(onSinglePlayer)];

		CCMenuItem* multiPlayer = [CCMenuItemFont itemFromString:@"Join Session"
														  target:self 
														selector:@selector(onMultiplayer)];

		
		CCMenu* menu = [CCMenu menuWithItems:singlePlayer,
											 multiPlayer,
											 nil];
		
		[menu alignItemsVerticallyWithPadding:30.0f];
		[self addChild:menu];		
	}
	return self;
}

-(void)onSinglePlayer {
	KALayerMovementTest* layer = [KALayerMovementTest node];
	[layer setupSingleplayer];
	
	CCScene* newScene = [CCScene node];
	[newScene addChild:layer];
	
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:1.0f scene:newScene withColor:ccWHITE]];
}


-(void)onMultiplayer {
	NSLog(@"Create session");
}


#pragma mark -
#pragma mark Memory management

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
