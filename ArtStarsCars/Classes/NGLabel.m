//
//  NGLabel.m
//

#import "NGLabel.h"
#import <UIKit/UIKit.h>

@implementation NGLabel


@synthesize customFont;
@synthesize edgeInsets = edgeInsets_;


+ (CTFontRef)createCustomFontFromFile:(NSString *)fontPath size:(float)size {
    if (fontPath == nil) return nil;
    
	CGDataProviderRef fontDataProvider = CGDataProviderCreateWithFilename([fontPath UTF8String]);
	CGFontRef cgFont = CGFontCreateWithDataProvider(fontDataProvider);
    CTFontRef ctFont = NULL;
    if (cgFont != NULL) {
        ctFont = CTFontCreateWithGraphicsFont(cgFont, size, NULL, NULL);
        CFRelease(cgFont);
    }
	CGDataProviderRelease(fontDataProvider);
	return ctFont;
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        edgeInsets_ = UIEdgeInsetsMake(0.f, 0.f, 0.f, 0.f);
    }
    
    return self;
}

- (void)setCustomFontFromNameOrFile:(NSString *)filename size:(float)size {
	[self setCustomFont:nil];
    
    UIFont *uiFont = [UIFont fontWithName:filename size:size];
    if (uiFont != nil) {
        self.font = uiFont;
        return;
    }
    
    // check if core text is available
    if (CTFontCreateWithGraphicsFont == NULL) {
		self.font = [UIFont systemFontOfSize:size];
		return;
	}
    
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"odt"];
	CTFontRef font = [NGLabel createCustomFontFromFile:path size:size];
	if (font == NULL) {
		self.font = [UIFont systemFontOfSize:size];
		return;
    }

	[self setCustomFont:font];
	CFRelease(font);
}


- (void)setCustomFont:(CTFontRef)font {
	if (customFont != NULL) {
		CFRelease(customFont);
        customFont = NULL;
    }
    
	if (font != nil) {
        customFont = CFRetain(font);
    }
	[self setNeedsDisplay];
}


- (CGFloat)lineHeight {
    if (customFont == NULL || CTFontGetAscent == NULL) {
        if (self.font == nil) return 0.0f;
		if ([self.font respondsToSelector:@selector(lineHeight)]) {
			return self.font.lineHeight;
		}
		
		CGSize ts = [@"ABCDEFGHIJKLMOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789?!" sizeWithFont:self.font];
		return ts.height;
    }
    
    CGFloat lineHeight = 0.0; 
    // Get the ascent from the font, already scaled for the font's size 
    lineHeight += CTFontGetAscent(customFont);
    // Get the descent from the font, already scaled for the font's size 
    lineHeight += CTFontGetDescent(customFont);
    // Get the leading from the font, already scaled for the font's size 
    lineHeight += CTFontGetLeading(customFont);
    return lineHeight;
}


- (void)drawTextInRect:(CGRect)rect {
    // apply edge insets
    rect = UIEdgeInsetsInsetRect(rect, self.edgeInsets);
    
    if (customFont == NULL || self.text == nil) {
		[super drawTextInRect:rect];
		return;
	}

	// pack it into attributes dictionary
	NSDictionary *attributesDict = [NSDictionary dictionaryWithObjectsAndKeys:
                                    (id)customFont, (id)kCTFontAttributeName,
                                    self.textColor.CGColor, (id)kCTForegroundColorAttributeName,
                                    nil];
    
	// make the attributed string
	NSAttributedString *stringToDraw = [[NSAttributedString alloc] initWithString:self.text
                                                                       attributes:attributesDict];
    
	// now for the actual drawing
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSaveGState(context);
    {
        // flip the coordinate system
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, self.bounds.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        
        // draw
        CTLineRef line = CTLineCreateWithAttributedString((CFAttributedStringRef)stringToDraw);
        CGRect lineBounds = CTLineGetImageBounds(line, context);
		CGPoint p = CGPointMake((self.bounds.size.width - lineBounds.size.width) / 2, 
                                (self.bounds.size.height - lineBounds.size.height) / 2);
        if (self.textAlignment == UITextAlignmentLeft) {
            p.x = 0.0f;
        }
        else if (self.textAlignment == UITextAlignmentRight) {
            p.x = self.bounds.size.width - lineBounds.size.width;
        }
        CGContextSetTextPosition(context, p.x, p.y);
        CTLineDraw(line, context);

        // clean up
        CFRelease(line);
    }
    CGContextRestoreGState(context);
    
	[stringToDraw release];
}


- (void)dealloc {
	if (customFont != NULL) {
		CFRelease(customFont);
    }
	[super dealloc];
}


@end