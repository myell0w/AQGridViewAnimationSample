//
//  ASCGridViewController.m
//  ArtStarsCars
//
//  Created by Matthias Tretter on 14.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "ASCGridViewController.h"

// we can use Retina-Images for iPad in Grid
#define kIPadAppendix                   @"@2x"

#define kGridViewPaddingLeft            (isIPad() ? 84.f : 5.f)
#define kGridViewPaddingRight           (isIPad() ? 84.f : 5.f)
#define kGridViewPaddingLeftLandscape   (isIPad() ? 60.f : 5.f)
#define kGridViewPaddingRightLandscape  (isIPad() ? 60.f : 5.f)
#define kGridViewPaddingTop             (isIPad() ? 78.f : 25.f)
#define kGridViewPaddingBottom          (isIPad() ? 78.f : 25.f)


@interface ASCGridViewController ()

@property (nonatomic, copy) NSArray *gridItemsPortrait;
@property (nonatomic, copy) NSArray *gridItemsLandscape;
@property (nonatomic, copy) NSIndexSet *indicesPortrait;
@property (nonatomic, copy) NSIndexSet *indicesLandscape;
@property (nonatomic, assign) ASCOrientation usedOrientation;


@property (nonatomic, readonly) NSArray *itemsToMove;
@property (nonatomic, readonly) NSIndexSet *indicesToInsertWhenRotatingToLandscape;
@property (nonatomic, readonly) NSIndexSet *indicesToInsertWhenRotatingToPortrait;
@property (nonatomic, readonly) NSIndexSet *indicesToDeleteWhenRotatingToLandscape;
@property (nonatomic, readonly) NSIndexSet *indicesToDeleteWhenRotatingToPortrait;

- (NSArray *)itemsForOrientation:(ASCOrientation)orientation;
- (ASCGridItem *)itemForIndex:(NSUInteger)index;

@end

@implementation ASCGridViewController

@synthesize gridView = gridView_;
@synthesize gridItems = gridItems_;
@synthesize gridItemsPortrait = gridItemsPortrait_;
@synthesize gridItemsLandscape = gridItemsLandscape_;
@synthesize indicesPortrait = indicesPortrait_;
@synthesize indicesLandscape = indicesLandscape_;
@synthesize usedOrientation = usedOrientation_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        usedOrientation_ = ASCOrientationPortrait;
    }
    
    return self;
}

- (void)dealloc
{
    MCRelease(gridView_);
    MCRelease(gridItems_);
    MCRelease(gridItemsPortrait_);
    MCRelease(gridItemsLandscape_);
    MCRelease(indicesPortrait_);
    MCRelease(indicesLandscape_);
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UIView Handling
/////////////////////////////////////////////////////////////////////////*

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *headerView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frameWidth, kGridViewPaddingTop)] autorelease];
    UIView *footerView = [[[UIView alloc] initWithFrame:CGRectMake(0.f, 0.f, self.view.frameWidth, kGridViewPaddingBottom)] autorelease];
    
    headerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    footerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    
    self.gridView = [[[AQGridView alloc] initWithFrame:self.view.frame] autorelease];
    self.gridView.gridHeaderView = headerView;
    self.gridView.gridFooterView = footerView;
    self.gridView.leftContentInset = kGridViewPaddingLeft;
    self.gridView.rightContentInset = kGridViewPaddingRight;
	self.gridView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	self.gridView.delegate = self;
	self.gridView.dataSource = self;
    
	[self.view addSubview:self.gridView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.gridView = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        self.usedOrientation = ASCOrientationPortrait;
        self.gridView.leftContentInset = kGridViewPaddingLeft;
        self.gridView.rightContentInset = kGridViewPaddingRight;
    } else {
        self.usedOrientation = ASCOrientationLandscape;
        self.gridView.leftContentInset = kGridViewPaddingLeftLandscape;
        self.gridView.rightContentInset = kGridViewPaddingRightLandscape;
    }
    
    self.gridView.delegate = self;
    self.gridView.dataSource = self;
    [self.gridView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.gridView.delegate = nil;
    self.gridView.dataSource = nil;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Rotation
////////////////////////////////////////////////////////////////////////

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    [super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
    
    if (UIInterfaceOrientationIsPortrait(toInterfaceOrientation)) {
        self.gridView.leftContentInset = kGridViewPaddingLeft;
        self.gridView.rightContentInset = kGridViewPaddingRight;
    } else {
        self.gridView.leftContentInset = kGridViewPaddingLeftLandscape;
        self.gridView.rightContentInset = kGridViewPaddingRightLandscape;
    }
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    
     [self.gridView beginUpdates];
    
    if (UIInterfaceOrientationIsPortrait([UIApplication sharedApplication].statusBarOrientation)) {
        // we now switch our datasource-array to self.gridItemsPortrait
        self.usedOrientation = ASCOrientationPortrait;
        
        // these logging statements look right
        DDLogInfo(@"Will delete items at indices: %@", self.indicesToDeleteWhenRotatingToPortrait);
        DDLogInfo(@"Will insert items at indices: %@", self.indicesToInsertWhenRotatingToPortrait);
        DDLogInfo(@"Will move items: %@", self.itemsToMove);
        
        for (ASCGridItem *itemToMove in self.itemsToMove) {
            [self.gridView moveItemAtIndex:itemToMove.indexLandscape 
                                   toIndex:itemToMove.indexPortrait 
                             withAnimation:AQGridViewItemAnimationFade];
        }
        
        [self.gridView deleteItemsAtIndices:self.indicesToDeleteWhenRotatingToPortrait withAnimation:AQGridViewItemAnimationFade];
        [self.gridView insertItemsAtIndices:self.indicesToInsertWhenRotatingToPortrait withAnimation:AQGridViewItemAnimationFade];
        
    } else {
        // we now switch our datasource-array to self.gridItemsLandscape
        self.usedOrientation = ASCOrientationLandscape;
        
        // these logging statements look right
        DDLogInfo(@"Will delete items at indices: %@", self.indicesToDeleteWhenRotatingToLandscape);
        DDLogInfo(@"Will insert items at indices: %@", self.indicesToInsertWhenRotatingToLandscape);
        DDLogInfo(@"Will move items: %@", self.itemsToMove);
        
        for (ASCGridItem *itemToMove in self.itemsToMove) {
            [self.gridView moveItemAtIndex:itemToMove.indexPortrait
                                   toIndex:itemToMove.indexLandscape 
                             withAnimation:AQGridViewItemAnimationFade];
        }
        
        [self.gridView deleteItemsAtIndices:self.indicesToDeleteWhenRotatingToLandscape withAnimation:AQGridViewItemAnimationFade];
        [self.gridView insertItemsAtIndices:self.indicesToInsertWhenRotatingToLandscape withAnimation:AQGridViewItemAnimationFade];
    }
    
    [self.gridView endUpdates];
    
    // this works ...
    //self.usedOrientation = ASCOrientationFromInterfaceOrientation([UIApplication sharedApplication].statusBarOrientation);
    //[self.gridView reloadData];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter/Getter
////////////////////////////////////////////////////////////////////////

- (void)setGridItems:(NSArray *)gridItems {
    // retain member variable when different
    if (gridItems != gridItems_) {
        [gridItems_ release];
        gridItems_ = [gridItems retain];
    }

    // determine indexes of objects visible in portrait
    self.indicesPortrait = [gridItems_ indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        ASCGridItem *gridItem = (ASCGridItem *)obj;
        return gridItem.visibleInPortrait;
    }];
    
    // determine indexes of objects visible in landscape
    self.indicesLandscape = [gridItems_ indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        ASCGridItem *gridItem = (ASCGridItem *)obj;
        return gridItem.visibleInLandscape;
    }];
    
    // save shortcuts to items for performance reasons
    // save sorted according to index in portrait/landscape for faster access to needed item
    // therefore item with index 3 e.g. is the object at index 3
    self.gridItemsPortrait = [[gridItems_ objectsAtIndexes:self.indicesPortrait] sortedArrayUsingSelector:@selector(comparePortrait:)];
    self.gridItemsLandscape = [[gridItems_ objectsAtIndexes:self.indicesLandscape] sortedArrayUsingSelector:@selector(compareLandscape:)];
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Grid View Data Source
///////////////////////////////////////////////////////////////////////////////////////////////////

- (NSUInteger)numberOfItemsInGridView:(AQGridView *)aGridView {
    return [self itemsForOrientation:self.usedOrientation].count;
}

- (AQGridViewCell *)gridView:(AQGridView *)aGridView cellForItemAtIndex:(NSUInteger)index {
	ASCGridCell * cell = (ASCGridCell *)[aGridView dequeueReusableCellWithIdentifier:kGridCellReuseID];
    ASCGridItem *item = [self itemForIndex:index];
    
	if (cell == nil) {
		cell = [[[ASCGridCell alloc] initWithFrame:CGRectMake(0.0,0.0,kGridCellWidth,kGridCellHeight) reuseIdentifier:kGridCellReuseID] autorelease];
	}
    
	cell.image = [UIImage deviceSpecificImageNamed:[item valueForKey:kGridItemImageNameKey] appendix:kIPadAppendix];
    cell.title = [item valueForKey:kGridItemTitleKey];
    
    return cell;
}

- (CGSize)portraitGridCellSizeForGridView:(AQGridView *)aGridView {
    return CGSizeMake(kGridCellWidth + 8.f, kGridCellHeight + 8.f);
}

///////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Grid View Delegate
///////////////////////////////////////////////////////////////////////////////////////////////////

- (void)gridView:(AQGridView *)gridView didSelectItemAtIndex:(NSUInteger)index {
    ASCGridItem *selectedItem = [self itemForIndex:index];
    
    if (selectedItem.touchable) {
        ASCBaseViewController *nextViewController = [[[selectedItem.nextViewControllerClass alloc] initWithNibName:nil bundle:nil] autorelease];
        [self.navigationController pushViewController:nextViewController animated:YES];
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Private Methods
////////////////////////////////////////////////////////////////////////

- (NSArray *)itemsForOrientation:(ASCOrientation)orientation {
    if (orientation == ASCOrientationPortrait) {
        return self.gridItemsPortrait;
    } else {
        return self.gridItemsLandscape;
    }
}

- (ASCGridItem *)itemForIndex:(NSUInteger)index {
    ASCGridItem *item = [[self itemsForOrientation:self.usedOrientation] objectAtIndex:index];
    
    if (self.usedOrientation == ASCOrientationPortrait) {
        NSAssert(item.indexPortrait == index, @"Item of sorted array gridItemsPortait should have index %d", index);
    } else {
        NSAssert(item.indexLandscape == index, @"Item of sorted array gridItemsLandscape should have index %d", index);
    }
    
    return item;
}

- (NSArray *)itemsToMove {
    // we move all items that are visible in portrait & landscape and have different item positions in landscape & portraits
    return [self.gridItems filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"visibleInPortrait = YES && visibleInLandscape == YES && indexPortrait != indexLandscape"]];
}

- (NSIndexSet *)indicesToInsertWhenRotatingToLandscape {
    // we insert all items when rotating to landscape that are just visible in landscape
    return [self.gridItemsLandscape indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        ASCGridItem *item = (ASCGridItem *)obj;
        return !item.visibleInPortrait;
    }];
}

- (NSIndexSet *)indicesToInsertWhenRotatingToPortrait {
    // we insert all items when rotating to portrait that are just visible in portrait
    return [self.gridItemsPortrait indexesOfObjectsPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
        ASCGridItem *item = (ASCGridItem *)obj;
        return !item.visibleInLandscape;
    }];
}

- (NSIndexSet *)indicesToDeleteWhenRotatingToLandscape {
    // we delete all items when rotating to landscape that got inserted when rotating to portrait
    return [self indicesToInsertWhenRotatingToPortrait];
}

- (NSIndexSet *)indicesToDeleteWhenRotatingToPortrait {
    return [self indicesToInsertWhenRotatingToLandscape];
}

@end
