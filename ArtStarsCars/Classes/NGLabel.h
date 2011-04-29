//
//  NGLabel.h
//
//  Created by Jürgen Falb.
//
#import <CoreText/CoreText.h>

@interface NGLabel : UILabel  {
	CTFontRef customFont;
    UIEdgeInsets edgeInsets_;
}

@property(nonatomic, readonly) CTFontRef customFont;
@property(nonatomic, readonly) CGFloat lineHeight;
@property (nonatomic, assign) UIEdgeInsets edgeInsets;

+ (CTFontRef)createCustomFontFromFile:(NSString *)fontPath size:(float)size;

- (void)setCustomFont:(CTFontRef)font;
- (void)setCustomFontFromNameOrFile:(NSString *)filename size:(float)size;

@end