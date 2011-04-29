//
//  ASCBackgroundView.m
//  ArtStarsCars
//
//  Created by Matthias Tretter on 27.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "ASCBackgroundView.h"
#import "PSDefines.h"
#import <QuartzCore/QuartzCore.h>

@interface ASCBackgroundView ()

@property (nonatomic, retain) IBOutlet UIImageView *imageView;

@end


@implementation ASCBackgroundView

@synthesize imageView = imageView_;

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        ((CAGradientLayer*)self.layer).colors = [NSArray arrayWithObjects:(id)[kBackgroundColorLight CGColor], (id)[kBackgroundColorDark CGColor], nil];
    }
    
    return self;
}

- (void)dealloc {
    MCRelease(imageView_);
    
    [super dealloc];
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark CALayer
////////////////////////////////////////////////////////////////////////

+(Class) layerClass {
    return [CAGradientLayer class];
}


////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter/Getter
////////////////////////////////////////////////////////////////////////

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image {
    if (self.imageView == nil) {
        self.imageView = [[[UIImageView alloc] initWithFrame:self.bounds] autorelease];
        self.imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:self.imageView];
    }
    
    self.imageView.image = image;
}

@end
