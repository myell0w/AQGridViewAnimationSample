//
//  ASCGridItem.h
//  ArtStarsCars
//
//  Created by Matthias Tretter on 14.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kGridItemImageNameKey   @"imageName"
#define kGridItemTitleKey       @"title"


typedef enum {
    ASCOrientationPortrait =  1,
    ASCOrientationLandscape = 1 << 1,
} ASCOrientation;

#define ASCOrientationBoth  (ASCOrientationPortrait | ASCOrientationLandscape)
#define ASCOrientationFromInterfaceOrientation(interfaceOrientation) (UIInterfaceOrientationIsPortrait(interfaceOrientation) ? ASCOrientationPortrait : ASCOrientationLandscape)

#define kIndexNotVisible    -1


@interface ASCGridItem : NSObject {
    NSString *imageName_;
    NSString *title_;
    
    NSInteger indexPortrait_;
    NSInteger indexLandscape_;
    Class nextViewControllerClass_;
}

@property (nonatomic, copy) NSString *imageName;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) Class nextViewControllerClass;
@property (nonatomic, readonly) BOOL touchable;

@property (nonatomic) NSInteger indexPortrait;
@property (nonatomic) NSInteger indexLandscape;

@property (nonatomic, readonly, getter=isVisibleInPortrait) BOOL visibleInPortrait;
@property (nonatomic, readonly, getter=isVisibleInLandscape) BOOL visibleInLandscape;

+ (ASCGridItem *)gridItemWithImageName:(NSString *)imageName title:(NSString *)title indexPortrait:(NSInteger)indexPortrait indexLandscape:(NSInteger)indexLandscape;
+ (ASCGridItem *)gridItemWithImageName:(NSString *)imageName title:(NSString *)title indexPortrait:(NSInteger)indexPortrait indexLandscape:(NSInteger)indexLandscape nextViewControllerClass:(Class)nextViewControllerClass;

- (NSComparisonResult)comparePortrait:(ASCGridItem *)item;
- (NSComparisonResult)compareLandscape:(ASCGridItem *)item;

@end
