//
//  ASCNavigationController.m
//  ArtStarsCars
//
//  Created by Matthias Tretter on 27.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "ASCNavigationController.h"
#import "PSDefines.h"
#import <QuartzCore/QuartzCore.h>
#import "UIToolbar+WTCustomize.h"


#define kIPadFixedSpaceItemWidth    25.f
#define kToolBarHeight              44.f
#define kShadowHeight                3.f

@interface ASCNavigationController ()

@property (nonatomic, retain) UIToolbar *toolbarIPad;

@property (nonatomic, retain) UIBarButtonItem *homeButton;
@property (nonatomic, retain) UIBarButtonItem *menuButton;
@property (nonatomic, retain) UIBarButtonItem *favoriteButton;
@property (nonatomic, retain) UIBarButtonItem *flexibleSpaceItem;
@property (nonatomic, retain) UIBarButtonItem *fixedSpaceItem;


- (void)updateToolbarItems;
- (void)addShadowToBars;

- (void)backButtonPressed:(id)sender;
- (void)homeButtonPressed:(id)sender;
- (void)menuButtonPressed:(id)sender;
- (void)favoriteButtonPressed:(id)sender;


@end


@implementation ASCNavigationController

@synthesize toolbarIPad = toolbarIPad_;
@synthesize headerLabel = headerLabel_;
@synthesize backButton = backButton_;
@synthesize homeButton = homeButton_;
@synthesize menuButton = menuButton_;
@synthesize favoriteButton = favoriteButton_;
@synthesize flexibleSpaceItem = flexibleSpaceItem_;
@synthesize fixedSpaceItem = fixedSpaceItem_;


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (void)dealloc {
    MCRelease(toolbarIPad_);
    MCRelease(headerLabel_);
    MCRelease(backButton_);
    MCRelease(homeButton_);
    MCRelease(menuButton_);
    MCRelease(favoriteButton_);
    MCRelease(flexibleSpaceItem_);
    MCRelease(fixedSpaceItem_);
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView Handling
////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create a custom back button
    UIImage *buttonImage = [UIImage imageNamed:@"NavigationBarBack.png"];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    // Make the button as high as the passed in image
    button.frame = CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height);
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    
    // Add an action for going back
    [button addTarget:self action:@selector(backButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    self.backButton = [[[UIBarButtonItem alloc] initWithCustomView:button] autorelease];
    
    // Create toolbar items
    self.homeButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ToolBarHome.png"] 
                                                        style:UIBarButtonItemStylePlain
                                                       target:self
                                                       action:@selector(homeButtonPressed:)] autorelease];
    self.menuButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ToolBarMenu.png"] 
                                                        style:UIBarButtonItemStylePlain
                                                       target:self
                                                       action:@selector(menuButtonPressed:)] autorelease];
    self.favoriteButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"ToolBarFavorite.png"] 
                                                            style:UIBarButtonItemStylePlain
                                                           target:self
                                                           action:@selector(favoriteButtonPressed:)] autorelease];
    
    self.flexibleSpaceItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil] autorelease];
    self.fixedSpaceItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil] autorelease];
    self.fixedSpaceItem.width = kIPadFixedSpaceItemWidth;
    
    // iPad has only toolbar bar that also acts as a navigation bar
    if (isIPad()) {
        self.navigationBarHidden = YES;
        
        self.toolbarIPad = [[[UIToolbar alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.bounds.size.width, kToolBarHeight)] autorelease];
        self.toolbarIPad.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
        
        // Header item
        self.headerLabel = [[[NGLabel alloc] initWithFrame:CGRectInset(self.toolbarIPad.frame, 140.f, 5.f)] autorelease];
        self.headerLabel.frameTop += 5.f;
        self.headerLabel.backgroundColor = [UIColor clearColor];
        self.headerLabel.textAlignment = UITextAlignmentCenter;
        self.headerLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.headerLabel.textColor = [UIColor whiteColor];
        [self.toolbarIPad addSubview:self.headerLabel];
        
        [self updateToolbarItems];
        
        [self.view addSubview:self.toolbarIPad];
    } 
    // iPhone has navigationBar & toolbar
    else {
        [self setToolbarHidden:NO];
    }
    
    [self.toolbar customize];
    [self addShadowToBars];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    self.backButton = nil;
    self.homeButton = nil;
    self.menuButton = nil;
    self.favoriteButton = nil;
    self.flexibleSpaceItem = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    
    [super viewWillAppear:animated];
}


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter/Getter
////////////////////////////////////////////////////////////////////////

// we use a custom toolbar on iPad on top
- (UIToolbar *)toolbar {
    if (isIPad()) {
        return self.toolbarIPad;
    } else {
        return [super toolbar];
    }
}

// these toolbarItems are provided to all viewControllers on iPhone
// and are set in [ASCBaseViewController viewDidLoad] so that our navigationController
// displays these items everywhere
- (NSArray *)toolbarItems {
    return XARRAY(self.homeButton, self.flexibleSpaceItem, self.menuButton, self.flexibleSpaceItem, self.favoriteButton);
}


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Push/Pop
////////////////////////////////////////////////////////////////////////

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [super pushViewController:viewController animated:animated];
    
    if (isIPad()) {
        [self updateToolbarItems];
    }
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *poppedViewController = [super popViewControllerAnimated:animated];
    
    if (isIPad()) {
        [self updateToolbarItems];
    }
    
    return poppedViewController;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods
////////////////////////////////////////////////////////////////////////

- (void)backButtonPressed:(id)sender {
    [self popViewControllerAnimated:YES];
}

- (void)homeButtonPressed:(id)sender {
    [self popToRootViewControllerAnimated:YES];
}

- (void)menuButtonPressed:(id)sender {
    
}

- (void)favoriteButtonPressed:(id)sender {
    
}

- (void)updateToolbarItems {
    if (self.viewControllers.count == 1) {
        [self.toolbarIPad setItems:XARRAY(self.flexibleSpaceItem, self.homeButton, self.fixedSpaceItem, self.menuButton, self.fixedSpaceItem, self.favoriteButton, self.fixedSpaceItem)
                          animated:YES];
    } else {
        [self.toolbarIPad setItems:XARRAY(self.backButton, self.flexibleSpaceItem, self.homeButton, self.fixedSpaceItem, self.menuButton, self.fixedSpaceItem, self.favoriteButton, self.fixedSpaceItem)
                          animated:YES];
    }
}

- (void)addShadowToBars {
    CGFloat navigationBarBottom;
    CGColorRef darkColor = [[UIColor blackColor] colorWithAlphaComponent:.5f].CGColor;
    CGColorRef lightColor = [[UIColor blackColor] colorWithAlphaComponent:.2f].CGColor;
    
    if (isIPad()) {
        navigationBarBottom = self.toolbarIPad.frame.origin.y + self.toolbarIPad.frame.size.height;
    } else {
        navigationBarBottom = self.navigationBar.frame.origin.y + self.navigationBar.frame.size.height;
        
        // Shadow for bottom toolbar
        CGFloat toolbarTop;
        toolbarTop = self.toolbar.frame.origin.y;
        
        CAGradientLayer *toolbarShadow = [[[CAGradientLayer alloc] init] autorelease];
        toolbarShadow.frame = CGRectMake(0,toolbarTop-kShadowHeight, self.view.frame.size.width, kShadowHeight);
        toolbarShadow.colors = [NSArray arrayWithObjects:(id)lightColor, (id)darkColor, nil];
        
        [self.view.layer addSublayer:toolbarShadow];
    }
    
    // Shadow for navigation bar/toolbar iPad
    CAGradientLayer *newShadow = [[[CAGradientLayer alloc] init] autorelease];
    newShadow.frame = CGRectMake(0,navigationBarBottom, MAX(self.view.frameWidth,self.view.frameHeight), kShadowHeight);
    newShadow.colors = [NSArray arrayWithObjects:(id)darkColor, (id)lightColor, nil];
    
    [self.view.layer addSublayer:newShadow];
}

@end
