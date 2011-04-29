//
//  PSAppTemplateAppDelegate.h
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//  Template by Peter Steinberger
//

#import "ASCNavigationController.h"


// suspend/kill delegate
#define kAppplicationWillSuspend @"kAppplicationWillSuspend"

@interface AppDelegate : NSObject <UIApplicationDelegate> {

  UIImageView             *splashView_;
  UIWindow                *window_;
  ASCNavigationController *navigationController_;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) ASCNavigationController *navigationController;

@end

