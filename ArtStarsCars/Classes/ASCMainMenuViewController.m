//
//  RootViewController.m
//  PSAppTemplate
//
//  Created by Peter Steinberger on 12.12.10.
//  Template by Peter Steinberger
//

#import "ASCMainMenuViewController.h"
#import "PSDefines.h"
#import "NGLabel.h"

@interface ASCMainMenuViewController()
// private stuff
@end

@implementation ASCMainMenuViewController


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.gridItems = XARRAY([ASCGridItem gridItemWithImageName:@"MainMenuGrid0.png" title:nil  indexPortrait:0 indexLandscape:0],
                                [ASCGridItem gridItemWithImageName:@"MainMenuGridLandscape1.png" title:nil indexPortrait:kIndexNotVisible indexLandscape:1],
                                [ASCGridItem gridItemWithImageName:@"MainMenuGrid1.png" title:_(@"CLICK ME") indexPortrait:1 indexLandscape:2 nextViewControllerClass:NSClassFromString(@"ASCExhibitionViewController")],
                                [ASCGridItem gridItemWithImageName:@"MainMenuGrid2.png" title:nil  indexPortrait:2 indexLandscape:3],
                                [ASCGridItem gridItemWithImageName:@"MainMenuGrid3.png" title:_(@"Exhibits") indexPortrait:3 indexLandscape:4],
                                [ASCGridItem gridItemWithImageName:@"MainMenuGrid4.png" title:_(@"Events") indexPortrait:4 indexLandscape:5],
                                [ASCGridItem gridItemWithImageName:@"MainMenuGrid5.png" title:_(@"Service") indexPortrait:5 indexLandscape:6],
                                [ASCGridItem gridItemWithImageName:@"MainMenuGrid6.png" title:_(@"Museuminformation") indexPortrait:6 indexLandscape:7],
                                [ASCGridItem gridItemWithImageName:@"MainMenuGrid7.png" title:_(@"MBClassicStore") indexPortrait:7 indexLandscape:8]);
        
        self.title = @"This works, click on second item (Portrait)";
    }
    
    return self;
}

- (void)dealloc {
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView Handling
////////////////////////////////////////////////////////////////////////

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


@end

