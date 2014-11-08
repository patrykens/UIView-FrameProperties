//
//  UIView+FrameProperties
//
//  Created by Patryk Adamkiewicz
//  Copyright (c) 2012 Patryk Adamkiewicz. All rights reserved.
//

@implementation UIView (FrameProperties)

#pragma mark - Frame properties

- (CGFloat)minX
{
    return CGRectGetMinX(self.frame);
}

- (void)setMinX:(CGFloat)x
{
    self.frame = CGRectMake(x, self.minY, self.width, self.height);
}

- (CGFloat)minY
{
    return CGRectGetMinY(self.frame);
}

- (void)setMinY:(CGFloat)y
{
    self.frame = CGRectMake(self.minX, y, self.width, self.height);
}

- (CGFloat)midX
{
    return CGRectGetMidX(self.frame);
}

- (void)setMidX:(CGFloat)midX
{
    self.frame = CGRectMake(midX - self.width/2, self.minY, self.width, self.height);
}

- (CGFloat)midY
{
    return CGRectGetMidY(self.frame);
}

- (void)setMidY:(CGFloat)midY
{
    self.frame = CGRectMake(self.minX, midY - self.height/2, self.width, self.height);
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)maxX
{
    self.frame = CGRectMake(maxX - self.width, self.minY, self.width, self.height);
}

- (CGFloat)maxY
{
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)maxY
{
    self.frame = CGRectMake(self.minX, maxY - self.height, self.width, self.height);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)origin
{
    self.frame = CGRectMake(origin.x, origin.y, self.width, self.height);
}

- (void)setOriginByTranslationX:(CGFloat)x Y:(CGFloat)y
{
    [self setFrame:CGRectMake(self.minX + x, self.minY + y, self.width, self.height)];
}

#pragma mark - Size

- (CGFloat)width
{
    return CGRectGetWidth(self.frame);
}

- (void)setWidth:(CGFloat)w
{
    self.frame = CGRectMake(self.minX, self.minY, w, self.height);
}

- (CGFloat)height
{
    return CGRectGetHeight(self.frame);
}

- (void)setHeight:(CGFloat)h
{
    self.frame = CGRectMake(self.minX, self.minY, self.width, h);
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setSize:(CGSize)size
{
    self.frame = CGRectMake(self.minX, self.minY, size.width, size.height);
}

- (void)setSizeByScalingWidth:(CGFloat)xScale height:(CGFloat)yScale
{
    [self setSize:CGSizeMake(self.width*xScale, self.height*yScale)];
}

#pragma mark - Centering in container

- (void)centerInSuperview
{
    [self centerVerticalyInSuperview];
    [self centerHorizontalyInSuperview];
}

- (void)centerVerticalyInRect:(CGRect)rect
{
    CGFloat marginLeft = rect.size.height - self.height;
    CGFloat topMargin = floor(marginLeft/2.0);
    [self setMinY:rect.origin.y + topMargin];
}

- (void)centerHorizontalyInRect:(CGRect)rect
{
    CGFloat marginLeft = rect.size.width - self.width;
    CGFloat sideMargin = floor(marginLeft/2.0);
    [self setMinX:rect.origin.x + sideMargin];
}

- (void)centerVerticalyInSuperview
{
    [self centerVerticalyInRect:CGRectMake(0, 0, self.superview.width, self.superview.height)];
}

- (void)centerHorizontalyInSuperview
{
    [self centerHorizontalyInRect:CGRectMake(0, 0, self.superview.width, self.superview.height)];
}

#pragma mark - Centering subviews

- (void)centerSubviews:(NSArray *)subviews
{
    [self centerSubviews:subviews inRect:self.frame];
}

- (void)centerSubviews:(NSArray *)subviews inRect:(CGRect)rect
{
    CGRect baseRect = [self rectContainingViews:subviews];
    CGFloat minX = floor((rect.size.width - baseRect.size.width)/2.0);
    CGFloat minY = floor((rect.size.height - baseRect.size.height)/2.0);
    CGFloat offsetX = minX - baseRect.origin.x;
    CGFloat offsetY = minY - baseRect.origin.y;
    
    for (UIView *view in subviews) {
        [view setOrigin:CGPointMake(view.frame.origin.x+offsetX, view.frame.origin.y+offsetY)];
    }
}

- (void)centerSubviewsHorizontally:(NSArray *)subviews
{
    [self centerSubviewsHorizontally:subviews inRect:self.frame];
}

- (void)centerSubviewsHorizontally:(NSArray *)subviews inRect:(CGRect)rect
{
    CGRect baseRect = [self rectContainingViews:subviews];
    CGFloat sideMargin = floor((rect.size.width - baseRect.size.width)/2.0);
    CGFloat offsetX = sideMargin - baseRect.origin.x;
    
    for (UIView *view in subviews) {
        [view setOriginByTranslationX:offsetX Y:0];
    }
}

- (void)centerSubviewsVertically:(NSArray *)subviews
{
    [self centerSubviewsVertically:subviews inRect:self.frame];
}

- (void)centerSubviewsVertically:(NSArray *)subviews inRect:(CGRect)rect
{
    CGRect baseRect = [self rectContainingViews:subviews];
    CGFloat topMargin = floor((rect.size.height - baseRect.size.height)/2.0);
    CGFloat offsetY = topMargin - baseRect.origin.y;
    
    for (UIView *view in subviews) {
        [view setOriginByTranslationX:0 Y:offsetY];
    }
}

#pragma mark - Alignment

- (void)placeAboveView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered
{
    [self setMinY:baseView.minY - (self.height + margin)];
    if (centered) {
        CGFloat offset = baseView.midX - self.midX;
        [self setOriginByTranslationX:offset Y:0];
    }
}

- (void)placeBelowView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered
{
    [self setMinY:baseView.minY + baseView.height + margin];
    if (centered) {
        CGFloat offset = baseView.midX - self.midX;
        [self setOriginByTranslationX:offset Y:0];
    }
}

- (void)placeLeftOfView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered
{
    [self setMinX:baseView.minX - (self.width + margin)];
    if (centered) {
        CGFloat offset = baseView.midY - self.midY;
        [self setOriginByTranslationX:0 Y:offset];
    }
}

- (void)placeRightOfView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered
{
    [self setMinX:baseView.minX + baseView.width + margin];
    if (centered) {
        CGFloat offset = baseView.midY - self.midY;
        [self setOriginByTranslationX:0 Y:offset];
    }
}

- (void)alignToTopWithMargin:(CGFloat)margin centered:(BOOL)centered
{
    [self setMinY:margin];
    if (centered) {
        [self centerHorizontalyInSuperview];
    }
}

- (void)alignToBottomWithMargin:(CGFloat)margin centered:(BOOL)centered
{
    [self setMinY:self.superview.height-self.height-margin];
    if (centered) {
        [self centerHorizontalyInSuperview];
    }
}

- (void)alignToLeftWithMargin:(CGFloat)margin centered:(BOOL)centered
{
    [self setMinX:margin];
    if (centered) {
        [self centerVerticalyInSuperview];
    }
}

- (void)alignToRightWithMargin:(CGFloat)margin centered:(BOOL)centered
{
    [self setMinX:self.superview.width-self.width-margin];
    if (centered) {
        [self centerVerticalyInSuperview];
    }
}

- (void)alignToBottomOfScrollViewWithMargin:(CGFloat)margin centered:(BOOL)centered
{
    UIScrollView *scrollview = (UIScrollView *)self.superview;
    [self setMinY:scrollview.contentSize.height-self.height];
    if (centered) {
        [self centerHorizontalyInSuperview];
    }
}

#pragma mark - Even subviews aligning

- (void)alignSubviewsHorizontally:(NSArray *)subviews type:(AlignmentType)type
{
    if (type == AlignmentTypeEqualCenters) {
        CGFloat viewSpace = self.width/(subviews.count);
        [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view centerHorizontalyInRect:CGRectMake(viewSpace*idx, 1, viewSpace, 1)];
        }];
    }
    else if (type == AlignmentTypeEqualSpace) {
        CGFloat space = (self.width - [self addedWidthOfViews:subviews])/(subviews.count+1);
        CGFloat __block sum=0;
        [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view setMinX:space*(idx+1)+sum];
            sum+=view.frame.size.width;
        }];
    }
}

- (void)alignSubviewsVertically:(NSArray *)subviews type:(AlignmentType)type
{
    if (type == AlignmentTypeEqualCenters) {
        CGFloat viewSpace = self.height/(subviews.count);
        [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view centerVerticalyInRect:CGRectMake(viewSpace*idx, 1, viewSpace, 1)];
        }];
    }
    else if (type == AlignmentTypeEqualSpace) {
        CGFloat space = (self.height - [self addedHeightOfViews:subviews])/(subviews.count+1);
        CGFloat __block sum=0;
        [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view setMinY:space*(idx+1)+sum];
            sum+=view.frame.size.height;
        }];
    }
}

#pragma mark - Adding subviews

- (void)addSubviews:(NSArray *)subviews
{
    for (UIView *view in subviews) {
        [self addSubview:view];
    }
}

- (void)addSubviewCentered:(UIView *)view
{
    [self addSubview:view];
    [view centerInSuperview];
}

- (void)addSubviewCenteredHorizontally:(UIView *)view
{
    [self addSubview:view];
    [view centerHorizontalyInSuperview];
}

- (void)addSubviewCenteredVertically:(UIView *)view
{
    [self addSubview:view];
    [view centerVerticalyInSuperview];
}

#pragma mark - Helpers

- (CGRect)rectContainingViews:(NSArray *)views
{
    CGFloat __block xMin, xMax, yMin, yMax;
    [views enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            xMin = obj.minX;
            yMin = obj.minY;
            xMax = obj.maxX;
            yMax = obj.maxY;
        }
        else {
            xMin = obj.minX < xMin ? obj.minX : xMin;
            yMin = obj.minY < yMin ? obj.minY : yMin;
            xMax = obj.maxX > xMax ? obj.maxX : xMax;
            yMax = obj.maxY > yMax ? obj.maxY : yMax;
        }
    }];
    return CGRectMake(xMin, yMin, xMax-xMin, yMax-yMin);
}

- (CGSize)addedSizeOfViews:(NSArray *)views
{
    CGFloat width=0, height=0;
    for (UIView *view in views) {
        width += view.frame.size.width;
        height += view.frame.size.height;
    }
    return CGSizeMake(width, height);
}

- (CGFloat)addedWidthOfViews:(NSArray *)views
{
    CGFloat width = 0;
    for (UIView *view in views) {
        width += view.frame.size.width;
    }
    return width;
}

- (CGFloat)addedHeightOfViews:(NSArray *)views
{
    CGFloat height = 0;
    for (UIView *view in views) {
        height += view.frame.size.height;
    }
    return height;
}

@end
