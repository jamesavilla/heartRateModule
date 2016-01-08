//
//  UIPasteboard.h
//  UIKit
//
//  Copyright (c) 2008-2014 Apple Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKitDefines.h>

NS_ASSUME_NONNULL_BEGIN

UIKIT_EXTERN NSString *const UIPasteboardNameGeneral;
UIKIT_EXTERN NSString *const UIPasteboardNameFind;

@class UIColor, UIImage;

NS_CLASS_AVAILABLE_IOS(3_0) @interface UIPasteboard : NSObject
{
  @private
    NSString * __nullable _name;
}

+ (UIPasteboard *)generalPasteboard;
+ (nullable UIPasteboard *)pasteboardWithName:(NSString *)pasteboardName create:(BOOL)create;
+ (UIPasteboard *)pasteboardWithUniqueName;

@property(readonly,nonatomic) NSString *name;

+ (void)removePasteboardWithName:(NSString *)pasteboardName;

@property(getter=isPersistent,nonatomic) BOOL persistent;
@property(readonly,nonatomic) NSInteger changeCount;

// First item

- (NSArray<NSString *> *)pasteboardTypes;
- (BOOL)containsPasteboardTypes:(NSArray<NSString *> *)pasteboardTypes;
- (nullable NSData *)dataForPasteboardType:(NSString *)pasteboardType;

- (nullable id)valueForPasteboardType:(NSString *)pasteboardType;

- (void)setValue:(id)value forPasteboardType:(NSString *)pasteboardType;
- (void)setData:(NSData *)data forPasteboardType:(NSString *)pasteboardType;

// Multiple items

@property(readonly,nonatomic) NSInteger numberOfItems;
// The next two property generics update is waiting on clang front end fix. See <rdar://problem/20824785>
// - (nullable NSArray<NSString *> *)pasteboardTypesForItemSet:(nullable NSIndexSet*)itemSet;
- (nullable NSArray *)pasteboardTypesForItemSet:(nullable NSIndexSet*)itemSet;

- (BOOL)containsPasteboardTypes:(NSArray<NSString *> *)pasteboardTypes inItemSet:(nullable NSIndexSet *)itemSet;
- (nullable NSIndexSet *)itemSetWithPasteboardTypes:(NSArray *)pasteboardTypes;
- (nullable NSArray *)valuesForPasteboardType:(NSString *)pasteboardType inItemSet:(nullable NSIndexSet *)itemSet;
- (nullable NSArray *)dataForPasteboardType:(NSString *)pasteboardType inItemSet:(nullable NSIndexSet *)itemSet;

// Direct access

@property(nonatomic,copy) NSArray *items;
- (void)addItems:(NSArray<NSDictionary<NSString *, id> *> *)items;

@end

// Notification

UIKIT_EXTERN NSString *const UIPasteboardChangedNotification;
UIKIT_EXTERN NSString *const UIPasteboardChangedTypesAddedKey;
UIKIT_EXTERN NSString *const UIPasteboardChangedTypesRemovedKey;

UIKIT_EXTERN NSString *const UIPasteboardRemovedNotification;

// Extensions

UIKIT_EXTERN NSArray<NSString *> *UIPasteboardTypeListString;
UIKIT_EXTERN NSArray<NSString *> *UIPasteboardTypeListURL;
UIKIT_EXTERN NSArray<NSString *> *UIPasteboardTypeListImage;
UIKIT_EXTERN NSArray<NSString *> *UIPasteboardTypeListColor;

@interface UIPasteboard(UIPasteboardDataExtensions)

@property(nullable,nonatomic,copy) NSString *string;
@property(nullable,nonatomic,copy) NSArray<NSString *> *strings;

@property(nullable,nonatomic,copy) NSURL *URL;
@property(nullable,nonatomic,copy) NSArray<NSURL *> *URLs;

@property(nullable,nonatomic,copy) UIImage *image;
@property(nullable,nonatomic,copy) NSArray<UIImage *> *images;

@property(nullable,nonatomic,copy) UIColor *color;
@property(nullable,nonatomic,copy) NSArray<UIColor *> *colors;

@end

NS_ASSUME_NONNULL_END
    
