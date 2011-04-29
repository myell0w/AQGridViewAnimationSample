//
//  ASCGridViewController.h
//  ArtStarsCars
//
//  Created by Matthias Tretter on 14.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ASCBaseViewController.h"
#import "AQGridView.h"
#import "ASCGridCell.h"
#import "ASCGridItem.h"


@interface ASCGridViewController : ASCBaseViewController <AQGridViewDelegate, AQGridViewDataSource> {
    AQGridView *gridView_;
    NSArray *gridItems_;
    NSArray *gridItemsLandscape_;
    NSArray *gridItemsPortrait_;
    
    NSIndexSet *indicesPortrait_;
    NSIndexSet *indicesLandscape_;
    
    ASCOrientation usedOrientation_;
}

@property (nonatomic, retain) AQGridView *gridView;
@property (nonatomic, retain) NSArray *gridItems;


@end
