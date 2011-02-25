//
//  KeepAssaultNetworkTestAppDelegate.h
//  KeepAssaultNetworkTest
//
//  Created by Jay Roberts on 2/24/11.
//  Copyright GloryFish.org 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface KeepAssaultNetworkTestAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

-(void)authenticateLocalPlayer;

@end
