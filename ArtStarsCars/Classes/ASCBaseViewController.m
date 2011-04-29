//
//  ASCBaseViewController.m
//  ArtStarsCars
//
//  Created by Matthias Tretter on 14.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "ASCBaseViewController.h"
#import "ASCNavigationController.h"


@interface ASCBaseViewController ()

@property (nonatomic, retain) NGLabel *headerLabel;

@end


@implementation ASCBaseViewController

@synthesize backgroundView = backgroundView_;
@synthesize headerLabel = headerLabel_;

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc {
    MCRelease(backgroundView_);
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView Handling
////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create background view
    self.backgroundView = [[[ASCBackgroundView alloc] initWithFrame:self.view.bounds] autorelease];
    [self.view addSubview:self.backgroundView];
    
    if (isIPhone()) {
        // Add header label to navigation bar
        UIView *headerView = [[[UIView alloc] initWithFrame:CGRectInset(self.navigationController.navigationBar.frame, 60.f, 5.f)] autorelease];
        headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        self.headerLabel = [[[NGLabel alloc] initWithFrame:headerView.bounds] autorelease];
        self.headerLabel.textColor = [UIColor whiteColor];
        self.headerLabel.frameTop += 6.f;
        self.headerLabel.backgroundColor = [UIColor clearColor];
        self.headerLabel.textAlignment = UITextAlignmentCenter;
        self.headerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        
        [headerView addSubview:self.headerLabel];
        self.navigationItem.titleView = headerView;
        
        // Hack: on iPhone set the toolbar items of each viewController
        // to the items provided by the custom ASCNavigationController
        self.toolbarItems = [self.navigationController toolbarItems];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.backgroundView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ASCNavigationController *navController = (ASCNavigationController *)self.navigationController;
    
    if (self.navigationController.viewControllers.count > 1) {
        self.navigationItem.leftBarButtonItem = navController.backButton;
    }
    
    if (isIPad()) {
    navController.headerLabel.text = self.title;
    } else {
        self.headerLabel.text = self.title;
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Rotation
////////////////////////////////////////////////////////////////////////

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return RotateOnIPad(interfaceOrientation);
}

@end
