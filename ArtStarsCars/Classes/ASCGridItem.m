//
//  ASCGridItem.m
//  ArtStarsCars
//
//  Created by Matthias Tretter on 14.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "ASCGridItem.h"
#import "PSDefines.h"


@implementation ASCGridItem

@synthesize imageName = imageName_;
@synthesize title = title_;
@synthesize indexPortrait = indexPortrait_;
@synthesize indexLandscape = indexLandscape_;
@synthesize nextViewControllerClass = nextViewControllerClass_;


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

+ (ASCGridItem *)gridItemWithImageName:(NSString *)imageName title:(NSString *)title indexPortrait:(NSInteger)indexPortrait indexLandscape:(NSInteger)indexLandscape {
    return [self gridItemWithImageName:imageName title:title indexPortrait:indexPortrait indexLandscape:indexLandscape nextViewControllerClass:nil];
}

+ (ASCGridItem *)gridItemWithImageName:(NSString *)imageName title:(NSString *)title indexPortrait:(NSInteger)indexPortrait indexLandscape:(NSInteger)indexLandscape nextViewControllerClass:(Class)nextViewControllerClass {
    ASCGridItem *gridItem = [[[ASCGridItem alloc] init] autorelease];
    
    gridItem.imageName = imageName;
    gridItem.title = title;
    gridItem.indexPortrait = indexPortrait;
    gridItem.indexLandscape = indexLandscape;
    gridItem.nextViewControllerClass = nextViewControllerClass;
    
    return gridItem;
}

- (void)dealloc {
    MCRelease(imageName_);
    MCRelease(title_);
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter/Getter
////////////////////////////////////////////////////////////////////////

- (NSString *)description {
    return [NSString stringWithFormat:@"(GridItem '%@': %d (Portrait) - %d (Landscape)", self.imageName, self.indexPortrait, self.indexLandscape];
}

- (BOOL)touchable {
    return self.nextViewControllerClass != nil;
}

- (BOOL)isVisibleInPortrait {
    return self.indexPortrait != kIndexNotVisible;
}

- (BOOL)isVisibleInLandscape {
    return self.indexLandscape != kIndexNotVisible;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Compare
////////////////////////////////////////////////////////////////////////

- (NSComparisonResult)comparePortrait:(ASCGridItem *)item {
    return [$I(self.indexPortrait) compare:$I(item.indexPortrait)];
}

- (NSComparisonResult)compareLandscape:(ASCGridItem *)item {
    return [$I(self.indexLandscape) compare:$I(item.indexLandscape)];
}

@end
