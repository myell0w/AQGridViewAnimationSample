//
//  PSAppTemplateAppDelegate.m
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//  Template by Peter Steinberger
//

#import "PSFoundation.h"
#import "PSDefines.h"
#import "AppDelegate.h"
#import "ASCMainMenuViewController.h"
#import "ASCNavigationBar.h"


@interface AppDelegate ()

- (void)configureLogger;
- (void)appplicationPrepareForBackgroundOrTermination:(UIApplication *)application;

- (UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)rootViewController;

@end


@implementation AppDelegate

@synthesize window = window_;
@synthesize navigationController = navigationController_;



///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIApplicationDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self configureLogger];
        
    // check for NSZombie (memory leak if enabled, but very useful!)
    if(getenv("NSZombieEnabled") || getenv("NSAutoreleaseFreedObjectCheckEnabled")) {
        DDLogWarn(@"NSZombieEnabled / NSAutoreleaseFreedObjectCheckEnabled enabled! Disable for release.");
    }
    
    // Add the navigation controller's view to the window and display.
    ASCMainMenuViewController *rootController = [[[ASCMainMenuViewController alloc] initWithNibName:nil bundle:nil] autorelease];
    navigationController_ = [[self navigationControllerWithRootViewController:rootController] retain];
    window_ = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [window_ addSubview:navigationController_.view];
    [window_ makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    [self appplicationPrepareForBackgroundOrTermination:application];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
    [self appplicationPrepareForBackgroundOrTermination:application];
}

///////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark private Methods
///////////////////////////////////////////////////////////////////////////////////////

- (void)configureLogger {
    PSDDFormatter *psLogger = [[[PSDDFormatter alloc] init] autorelease];
    [[DDTTYLogger sharedInstance] setLogFormatter:psLogger];
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
}

- (void)appplicationPrepareForBackgroundOrTermination:(UIApplication *)application {
    DDLogInfo(@"detected application termination.");
    
    // post notification to all listeners
    [[NSNotificationCenter defaultCenter] postNotificationName:kAppplicationWillSuspend object:application];
}

// launched via post selector to speed up launch time
- (void)postFinishLaunch {

}

///////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Memory management
///////////////////////////////////////////////////////////////////////////////////////

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
}

- (void)dealloc {
    MCRelease(splashView_);
    MCRelease(window_);
    MCRelease(navigationController_);
    
    [super dealloc];
}


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods
////////////////////////////////////////////////////////////////////////

- (UINavigationController *)navigationControllerWithRootViewController:(UIViewController *)rootViewController {
    // load Navigation Controller from NIB to customize Navigation Bar
	UINavigationController *navigationController = [[[NSBundle mainBundle] loadNibNamed:@"ASCNavigationController" owner:self options:nil] lastObject];
	navigationController.navigationBar.tintColor = [UIColor blackColor];
    
	ASCNavigationBar *customNavigationBar = (ASCNavigationBar *)navigationController.navigationBar;
    
	// set rootViewController
	navigationController.viewControllers = [NSArray arrayWithObject:rootViewController];
	// customize navigation bar background
	[customNavigationBar setBackgroundImage:[UIImage imageNamed:@"NavigationBar.png"]];
    
	return navigationController;
}

@end

