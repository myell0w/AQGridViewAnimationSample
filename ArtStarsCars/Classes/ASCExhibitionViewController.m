//
//  ASCExhibitionViewController.m
//  ArtStarsCars
//
//  Created by Matthias Tretter on 29.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "ASCExhibitionViewController.h"


@implementation ASCExhibitionViewController

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        self.gridItems = XARRAY([ASCGridItem gridItemWithImageName:@"ExhibitionGrid0.png" title:nil indexPortrait:0 indexLandscape:0],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid1.png" title:nil indexPortrait:1 indexLandscape:1],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid2.png" title:_(@"ArtStarsCars") indexPortrait:3 indexLandscape:2],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid3.png" title:nil indexPortrait:2 indexLandscape:3],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid4.png" title:nil  indexPortrait:kIndexNotVisible indexLandscape:4],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid5.png" title:_(@"125YearsCars") indexPortrait:5 indexLandscape:5],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid6.png" title:nil indexPortrait:4 indexLandscape:6],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid7.png" title:nil indexPortrait:kIndexNotVisible indexLandscape:7],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid8.png" title:_(@"Events") indexPortrait:7 indexLandscape:8],
                                [ASCGridItem gridItemWithImageName:@"ExhibitionGrid9.png" title:nil indexPortrait:6 indexLandscape:kIndexNotVisible]);
        
        self.title = @"This doesn't work";
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
