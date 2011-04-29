//
//  CustomNavigationBar.m
//  CustomBackButton
//
//  Created by Peter Boctor on 1/11/11.
//
//  Copyright (c) 2011 Peter Boctor
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE

#import "ASCNavigationBar.h"
#import <QuartzCore/QuartzCore.h>

#define MAX_BACK_BUTTON_WIDTH 160.0

@implementation ASCNavigationBar

@synthesize navigationBarBackgroundImage, navigationController;

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.layer.shadowColor = [UIColor redColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.f, 3.f);
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if ((self = [super initWithCoder:aDecoder])) {
        self.layer.shadowColor = [UIColor redColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(0.f, 3.f);
    }
    
    return self;
}

// If we have a custom background image, then draw it, othwerwise call super and draw the standard nav bar
- (void)drawRect:(CGRect)rect {
	if (navigationBarBackgroundImage) {
        CGContextRef currentContext = UIGraphicsGetCurrentContext();
        CGContextSaveGState(currentContext);
        CGContextSetShadowWithColor(currentContext, CGSizeMake(-15, 20), 5, [UIColor redColor].CGColor);
        
		[navigationBarBackgroundImage.image drawInRect:rect];
        
        CGContextRestoreGState(currentContext);
	}
	else {
		[super drawRect:rect];
	}
}

// Save the background image and call setNeedsDisplay to force a redraw
-(void) setBackgroundImage:(UIImage*)backgroundImage {
	self.navigationBarBackgroundImage = [[[UIImageView alloc] initWithFrame:self.frame] autorelease];
	navigationBarBackgroundImage.image = backgroundImage;

	[self setNeedsDisplay];
}

// clear the background image and call setNeedsDisplay to force a redraw
-(void) clearBackground {
	self.navigationBarBackgroundImage = nil;
	[self setNeedsDisplay];
}

- (void)dealloc {
	[navigationBarBackgroundImage release];
	[navigationController release];

	[super dealloc];
}

@end
