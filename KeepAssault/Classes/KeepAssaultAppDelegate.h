//
//  KeepAssaultAppDelegate.h
//  KeepAssault
//
//  Created by Jay Roberts on 3/2/11.
//  Copyright GloryFish.org 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface KeepAssaultAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
