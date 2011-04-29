//
//  UIToolbar+WTCustomize.m
//  WhereTU
//
//  Created by Matthias Tretter on 26.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import "UIToolbar+WTCustomize.h"
#import "PSDefines.h"


@implementation UIToolbar (WTCustomize)

- (void)customize {
    self.tintColor = [UIColor blackColor];
    
    if (self.subviews.count == 0 || ![[self.subviews objectAtIndex:0] isKindOfClass:[UIImageView class]]) {
        UIImageView *imageView = [[[UIImageView alloc] initWithImage:[UIImage deviceSpecificImageNamed:@"ToolBar.png"]] autorelease];
        
        imageView.frame = self.bounds;
        imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        
        [self insertSubview:imageView atIndex:0];
    }
}

@end
