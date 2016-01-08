//
//  UIMenuController.h
//  UIKit
//
//  Copyright (c) 2009-2014 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSInteger, UIMenuControllerArrowDirection) {
    UIMenuControllerArrowDefault, // up or down based on screen location
    UIMenuControllerArrowUp NS_ENUM_AVAILABLE_IOS(3_2),
    UIMenuControllerArrowDown NS_ENUM_AVAILABLE_IOS(3_2),
    UIMenuControllerArrowLeft NS_ENUM_AVAILABLE_IOS(3_2),
    UIMenuControllerArrowRight NS_ENUM_AVAILABLE_IOS(3_2),
};

@class UIView, UIMenuItem;

NS_CLASS_AVAILABLE_IOS(3_0) @interface UIMenuController : NSObject

+ (UIMenuController *)sharedMenuController;

@property(nonatomic,getter=isMenuVisible) BOOL menuVisible;	    // default is NO
- (void)setMenuVisible:(BOOL)menuVisible animated:(BOOL)animated;

- (void)setTargetRect:(CGRect)targetRect inView:(UIView *)targetView;
@property(nonatomic) UIMenuControllerArrowDirection arrowDirection NS_AVAILABLE_IOS(3_2); // default is UIMenuControllerArrowDefault
		
@property(nullable, nonatomic,copy) NSArray<UIMenuItem *> *menuItems NS_AVAILABLE_IOS(3_2); // default is nil. these are in addition to the standard items

- (void)update;	

@property(nonatomic,readonly) CGRect menuFrame;

@end

UIKIT_EXTERN NSString *const UIMenuControllerWillShowMenuNotification;
UIKIT_EXTERN NSString *const UIMenuControllerDidShowMenuNotification;
UIKIT_EXTERN NSString *const UIMenuControllerWillHideMenuNotification;
UIKIT_EXTERN NSString *const UIMenuControllerDidHideMenuNotification;
UIKIT_EXTERN NSString *const UIMenuControllerMenuFrameDidChangeNotification;

NS_CLASS_AVAILABLE_IOS(3_2) @interface UIMenuItem : NSObject 

- (instancetype)initWithTitle:(NSString *)title action:(SEL)action NS_DESIGNATED_INITIALIZER;

@property(nonatomic,copy) NSString *title;
@property(nonatomic)      SEL       action;

@end

NS_ASSUME_NONNULL_END
