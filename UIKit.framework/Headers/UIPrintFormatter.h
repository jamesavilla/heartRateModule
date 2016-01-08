//
//  UIPrintFormatter.h
//  UIKit
//
//  Copyright 2010-2012 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIView.h>
#import <UIKit/UIStringDrawing.h>
#import <UIKit/UIGeometry.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

@class UIPrintPageRenderer;
@class UIView, UIFont, UIColor;

NS_CLASS_AVAILABLE_IOS(4_2) @interface UIPrintFormatter : NSObject <NSCopying>

@property(nullable,nonatomic,readonly,weak) UIPrintPageRenderer *printPageRenderer; // default is nil. set when formatter added to a print page renderer
- (void)removeFromPrintPageRenderer;

@property(nonatomic) CGFloat      maximumContentHeight;      // default is 0.0. limits content to width
@property(nonatomic) CGFloat      maximumContentWidth;       // default is 0.0. limits content to height
@property(nonatomic) UIEdgeInsets contentInsets;             // default is UIEdgeInsetsZero. from edge of printableRect. applies to whole content. bottom inset unused
@property(nonatomic) UIEdgeInsets perPageContentInsets;      // default is UIEdgeInsetsZero from edge of the page.  applies to content on each page (each edge applies to each page)

@property(nonatomic)          NSInteger startPage;           // default is NSNotFound
@property(nonatomic,readonly) NSInteger pageCount;           // calculated

- (CGRect)rectForPageAtIndex:(NSInteger)pageIndex;                     // returns empty rect if index out of range
- (void)drawInRect:(CGRect)rect forPageAtIndex:(NSInteger)pageIndex;   // override point to add custom drawing

@end

//______________________________

NS_CLASS_AVAILABLE_IOS(4_2) @interface UISimpleTextPrintFormatter : UIPrintFormatter {
}

- (instancetype)initWithText:(NSString *)text;
- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText NS_AVAILABLE_IOS(7_0);

@property(nullable,nonatomic,copy)     NSString       *text;                   // cannot change once drawing started
@property(nullable,nonatomic,copy)     NSAttributedString *attributedText NS_AVAILABLE_IOS(7_0);
@property(nullable,nonatomic,strong)   UIFont         *font;
@property(nullable,nonatomic,strong)   UIColor        *color;
@property(nonatomic)          NSTextAlignment textAlignment;

@end

//______________________________

NS_CLASS_AVAILABLE_IOS(4_2) @interface UIMarkupTextPrintFormatter : UIPrintFormatter {
}

- (instancetype)initWithMarkupText:(NSString *)markupText;
@property(nullable,nonatomic,copy) NSString *markupText;                    // cannot change once drawing started

@end

//______________________________

NS_CLASS_AVAILABLE_IOS(4_2) @interface UIViewPrintFormatter : UIPrintFormatter 

@property(nonatomic,readonly) UIView *view;

@end

//______________________________

@interface UIView(UIPrintFormatter)

- (UIViewPrintFormatter *)viewPrintFormatter;                                          // returns a new print formatter each time
- (void)drawRect:(CGRect)rect forViewPrintFormatter:(UIViewPrintFormatter *)formatter;     // default calls -drawRect:

@end

NS_ASSUME_NONNULL_END
