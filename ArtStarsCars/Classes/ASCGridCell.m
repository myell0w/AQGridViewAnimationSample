/*
 * ImageDemoGridViewCell.m
 * Classes
 *
 * Created by Jim Dovey on 17/4/2010.
 *
 * Copyright (c) 2010 Jim Dovey
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 *
 * Redistributions of source code must retain the above copyright notice,
 * this list of conditions and the following disclaimer.
 *
 * Redistributions in binary form must reproduce the above copyright
 * notice, this list of conditions and the following disclaimer in the
 * documentation and/or other materials provided with the distribution.
 *
 * Neither the name of the project's author nor the names of its
 * contributors may be used to endorse or promote products derived from
 * this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
 * "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
 * LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
 * FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
 * HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
 * SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED
 * TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
 * PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 * LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 * NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
 * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 *
 */

#import "ASCGridCell.h"
#import "PSDefines.h"


#define kLabelHeight        (isIPad() ? 30.f : 16.f)
#define kLabelEdgeInsetLeft (isIPad() ? 8.f : 5.f)

@interface ASCGridCell ()

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) NGLabel *titleLabel;

@end

@implementation ASCGridCell

@synthesize imageView = imageView_;
@synthesize touchable = touchable_;
@synthesize titleLabel = titleLabel_;

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Lifecycle
////////////////////////////////////////////////////////////////////////

- (id) initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)aReuseIdentifier {
    if ((self = [super initWithFrame:frame reuseIdentifier:aReuseIdentifier])) {
		self.backgroundColor = [UIColor clearColor];
		self.contentView.backgroundColor = [UIColor clearColor];
		imageView_ = [[UIImageView alloc] initWithFrame:frame];
		imageView_.contentMode = UIViewContentModeScaleAspectFill;
		[self.contentView addCenteredSubview:imageView_];
        
        titleLabel_ = [[NGLabel alloc] initWithFrame:CGRectMake(0.f, CGRectGetHeight(frame) - kLabelHeight, CGRectGetWidth(frame), kLabelHeight)];
        titleLabel_.edgeInsets = UIEdgeInsetsMake(0.f, kLabelEdgeInsetLeft, 0.f, 0.f);
        titleLabel_.backgroundColor = [UIColor clearColor];
        titleLabel_.textColor = [UIColor blackColor];
        [self.contentView addSubview:titleLabel_];
	}
    
    return self;
}
- (void) dealloc {
    MCRelease(imageView_);
    MCRelease(titleLabel_);

    [super dealloc];
}

- (CALayer *)glowSelectionLayer {
    return self.imageView.layer;
}

////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark Setter/Getter
////////////////////////////////////////////////////////////////////////

- (UIImage *)image {
    return self.imageView.image;
}

- (void)setImage:(UIImage *)anImage {
    self.imageView.image = anImage;
    [self setNeedsLayout];
}

- (void)setTitle:(NSString *)title {
    self.titleLabel.text = title;
    
    if (!IsEmpty(title)) {
        self.titleLabel.backgroundColor = [UIColor whiteColor];
    } else {
        self.titleLabel.backgroundColor = [UIColor clearColor];
    }
}

- (NSString *)title {
    return self.titleLabel.text;
}

@end
