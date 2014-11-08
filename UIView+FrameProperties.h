//
//  UIView+FrameProperties
//
//  Created by Patryk Adamkiewicz
//  Copyright (c) 2012 Patryk Adamkiewicz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, AlignmentType) {
    AlignmentTypeEqualCenters = 0,
    AlignmentTypeEqualSpace
};

/**
 * This category was designed with purpose of 
 * making it easier to position views in relation
 * to other views, when designing view layout
 * without AutoLayout.
 *
 * Warning! 
 * This category should be used with caution 
 * when dealing with transformed views
 * as it accesses and writes to frame of a view.
 */
@interface UIView (FrameProperties)

@property (nonatomic, assign) CGFloat minX;
@property (nonatomic, assign) CGFloat minY;
@property (nonatomic, assign) CGFloat midX;
@property (nonatomic, assign) CGFloat midY;
@property (nonatomic, assign) CGFloat maxX;
@property (nonatomic, assign) CGFloat maxY;
@property (nonatomic, assign) CGPoint origin;

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;


/**
 * @brief Moves the view by x and y
 * @param x Value that will be added to the x coordinate
 * @param y Value that will be added to the y coordinate
 */
- (void)setOriginByTranslationX:(CGFloat)x Y:(CGFloat)y;

/**
 * @brief Scales size of the view by given values
 * @param xScale Width scale factor
 * @param yScale Height scale factor
 */
- (void)setSizeByScalingWidth:(CGFloat)xScale height:(CGFloat)yScale;


#pragma mark - Centering in container

/**
 * @brief Centers view in it's superview
 * @discussion If reciever does not have a superview the rect is (0,0;0,0)
 */
- (void)centerInSuperview;

/**
 * @brief Centers view verticaly in specified rect
 * @param rect Rect in which bounds the reciever should be centered
 * @discussion Reciever do not have to be a subview of the passed rect.
 */
- (void)centerVerticalyInRect:(CGRect)rect;

/**
 * @brief Centers view in horizontaly specified rect
 * @param rect Rect in which bounds the reciever should be centered
 * @discussion Reciever do not have to be a subview of the passed rect.
 */
- (void)centerHorizontalyInRect:(CGRect)rect;

/**
 * @brief Centers view verticaly in it's superview
 * @param rect Rect in which bounds the reciever should be centered
 * @discussion If reciever does not have a superview the rect is (0,0;0,0)
 */
- (void)centerVerticalyInSuperview;

/**
 * @brief Centers view horizontaly in it's superview
 * @param rect Rect in which bounds the reciever should be centered
 * @discussion If reciever does not have a superview the rect is (0,0;0,0)
 */
- (void)centerHorizontalyInSuperview;

#pragma mark - Centering subviews

- (void)centerSubviews:(NSArray *)subviews;

- (void)centerSubviews:(NSArray *)subviews inRect:(CGRect)rect;

- (void)centerSubviewsHorizontally:(NSArray *)subviews;

- (void)centerSubviewsHorizontally:(NSArray *)subviews inRect:(CGRect)rect;

- (void)centerSubviewsVertically:(NSArray *)subviews;

- (void)centerSubviewsVertically:(NSArray *)subviews inRect:(CGRect)rect;


#pragma mark - Alignment in respect to other views

/**
 * @brief Places receiver above another view
 * @param baseView - view around which receiver is placed
 * @discussion placement on X-axis is not changed
 */
- (void)placeAboveView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered;

/**
 * @brief Places receiver below another view
 * @param baseView - view around which receiver is placed
 * @discussion placement on X-axis is not changed
 */
- (void)placeBelowView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered;

/**
 * @brief Places receiver on the left side of another view
 * @param baseView - view around which receiver is placed
 * @discussion placement on Y-axis is not changed
 */
- (void)placeLeftOfView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered;

/**
 * @brief Places receiver on the right side of another view
 * @param baseView - view around which receiver is placed
 * @discussion placement on Y-axis is not changed
 */
- (void)placeRightOfView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered;

/**
 * @brief Aligns receiver to the top of superview
 * @discussion placement on X-axis is not changed
 */
- (void)alignToTopWithMargin:(CGFloat)margin centered:(BOOL)centered;

/**
 * @brief Aligns receiver to the bottom of superview
 * @discussion placement on X-axis is not changed
 */
- (void)alignToBottomWithMargin:(CGFloat)margin centered:(BOOL)centered;

/**
 * @brief Aligns receiver to the left of superview
 * @discussion placement on Y-axis is not changed
 */
- (void)alignToLeftWithMargin:(CGFloat)margin centered:(BOOL)centered;

/**
 * @brief Aligns receiver to the right of superview
 * @discussion placement on Y-axis is not changed
 */
- (void)alignToRightWithMargin:(CGFloat)margin centered:(BOOL)centered;

/**
 * @brief Aligns receiver to the bottom of scrollView
 * @discussion placement on X-axis is not changed, if the view is not subview of scrollview, the view is aligned to the bottom of a view
 */
- (void)alignToBottomOfScrollViewWithMargin:(CGFloat)margin centered:(BOOL)centered;

#pragma mark - Even subviews aligning

/**
 * @brief Aligns subviews horizontally
 * @discussion placement on Y-axis is not changed
 */
- (void)alignSubviewsHorizontally:(NSArray *)subviews type:(AlignmentType)type;

/**
 * @brief Aligns subviews vertically
 * @discussion placement on X-axis is not changed
 */
- (void)alignSubviewsVertically:(NSArray *)subviews type:(AlignmentType)type;


#pragma mark - Adding subviews

- (void)addSubviews:(NSArray *)subviews;

- (void)addSubviewCentered:(UIView *)view;

- (void)addSubviewCenteredHorizontally:(UIView *)view;

- (void)addSubviewCenteredVertically:(UIView *)view;

#pragma mark - Helpers

- (CGRect)rectContainingViews:(NSArray *)views;

- (CGSize)addedSizeOfViews:(NSArray *)views;

- (CGFloat)addedWidthOfViews:(NSArray *)views;

- (CGFloat)addedHeightOfViews:(NSArray *)views;

@end
