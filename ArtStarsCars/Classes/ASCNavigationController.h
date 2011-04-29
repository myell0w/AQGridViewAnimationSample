//
//  ASCNavigationController.h
//  ArtStarsCars
//
//  Created by Matthias Tretter on 27.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NGLabel.h"


@interface ASCNavigationController : UINavigationController {
    UIToolbar *toolbarIPad_;
    
    // Toolbar
    UIBarButtonItem *backButton_;
    UIBarButtonItem *homeButton_;
    UIBarButtonItem *menuButton_;
    UIBarButtonItem *favoriteButton_;
    
    UIBarButtonItem *flexibleSpaceItem_;
    UIBarButtonItem *fixedSpaceItem_;
    
    
    NGLabel *headerLabel_;
}

// label to hold the title of the viewController
@property (nonatomic, retain) NGLabel *headerLabel;
// custom back button
@property (nonatomic, retain) UIBarButtonItem *backButton;
// provide the toolbar items for iPhone to each viewController
@property (nonatomic, readonly) NSArray *toolbarItems;

@end
