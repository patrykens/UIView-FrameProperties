//
//  UIView+FrameProperties
//
//  Created by Patryk Adamkiewicz
//  Copyright (c) 2012 Patryk Adamkiewicz. All rights reserved.
//

@implementation UIView (FrameProperties)

#pragma mark - Custom getters

- (CGFloat)originX {
    return self.frame.origin.x;
}
- (CGFloat)originY {
    return self.frame.origin.y;
}
- (CGFloat)width {
    return self.frame.size.width;
}
- (CGFloat)height {
    return self.frame.size.height;
}
- (CGFloat)minX {
    return CGRectGetMinX(self.frame);
}
- (CGFloat)minY {
    return CGRectGetMinY(self.frame);
}
- (CGFloat)midX {
    return CGRectGetMidX(self.frame);
}
- (CGFloat)midY {
    return CGRectGetMidY(self.frame);
}
- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}
- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

#pragma mark - Origin

- (void)setOrigin:(CGPoint)origin {
    self.frame = CGRectMake(origin.x, origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setOriginX:(CGFloat)x {
    self.frame = CGRectMake(x, self.frame.origin.y, self.frame.size.width, self.frame.size.height);
}
- (void)setOriginY:(CGFloat)y {
    self.frame = CGRectMake(self.frame.origin.x, y, self.frame.size.width, self.frame.size.height);
}
- (void)setOriginByTranslationX:(CGFloat)x Y:(CGFloat)y {
    [self setFrame:CGRectMake(self.frame.origin.x + x, self.frame.origin.y + y, self.frame.size.width, self.frame.size.height)];
}

#pragma mark - Resizing

- (void)setSize:(CGSize)size {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, size.width, size.height);
}

- (void)setSizeByScalingWidth:(CGFloat)xScale height:(CGFloat)yScale {
    [self setSize:CGSizeMake(self.frame.size.width*xScale, self.frame.size.height*yScale)];
}

- (void)setWidth:(CGFloat)w {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, w, self.frame.size.height);
}

- (void)setHeight:(CGFloat)h {
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, h);
}

#pragma mark - Centering in container

- (void)centerInSuperview {
    [self centerVerticalyInSuperview];
    [self centerHorizontalyInSuperview];
}

- (void)centerVerticalyInRect:(CGRect)rect {
    CGFloat marginLeft = rect.size.height - self.frame.size.height;
    CGFloat topMargin = floor(marginLeft/2.0);
    [self setOriginY:rect.origin.y + topMargin];
}

- (void)centerHorizontalyInRect:(CGRect)rect {
    CGFloat marginLeft = rect.size.width - self.frame.size.width;
    CGFloat sideMargin = floor(marginLeft/2.0);
    [self setOriginX:rect.origin.x + sideMargin];
}

- (void)centerVerticalyInSuperview {
    [self centerVerticalyInRect:CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height)];
}

- (void)centerHorizontalyInSuperview {
    [self centerHorizontalyInRect:CGRectMake(0, 0, self.superview.frame.size.width, self.superview.frame.size.height)];
}

#pragma mark - Centering subviews

- (void)centerSubviews:(NSArray *)subviews {
    [self centerSubviews:subviews inRect:self.frame];
}

- (void)centerSubviews:(NSArray *)subviews inRect:(CGRect)rect {
    CGRect baseRect = [self rectContainingViews:subviews];
    CGFloat originX = floor((rect.size.width - baseRect.size.width)/2.0);
    CGFloat originY = floor((rect.size.height - baseRect.size.height)/2.0);
    CGFloat offsetX = originX - baseRect.origin.x;
    CGFloat offsetY = originY - baseRect.origin.y;
    
    for (UIView *view in subviews) {
        [view setOrigin:CGPointMake(view.frame.origin.x+offsetX, view.frame.origin.y+offsetY)];
    }
}

- (void)centerSubviewsHorizontally:(NSArray *)subviews {
    [self centerSubviewsHorizontally:subviews inRect:self.frame];
}

- (void)centerSubviewsHorizontally:(NSArray *)subviews inRect:(CGRect)rect {
    CGRect baseRect = [self rectContainingViews:subviews];
    CGFloat sideMargin = floor((rect.size.width - baseRect.size.width)/2.0);
    CGFloat offsetX = sideMargin - baseRect.origin.x;
    
    for (UIView *view in subviews) {
        [view setOriginByTranslationX:offsetX Y:0];
    }
}

- (void)centerSubviewsVertically:(NSArray *)subviews {
    [self centerSubviewsVertically:subviews inRect:self.frame];
}

- (void)centerSubviewsVertically:(NSArray *)subviews inRect:(CGRect)rect {
    CGRect baseRect = [self rectContainingViews:subviews];
    CGFloat topMargin = floor((rect.size.height - baseRect.size.height)/2.0);
    CGFloat offsetY = topMargin - baseRect.origin.y;
    
    for (UIView *view in subviews) {
        [view setOriginByTranslationX:0 Y:offsetY];
    }
}

#pragma mark - Alignment

- (void)placeAboveView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered {
    [self setOriginY:baseView.originY - (self.height + margin)];
    if (centered) {
        CGFloat offset = baseView.midX - self.midX;
        [self setOriginByTranslationX:offset Y:0];
    }
}

- (void)placeBelowView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered {
    [self setOriginY:baseView.originY + baseView.height + margin];
    if (centered) {
        CGFloat offset = baseView.midX - self.midX;
        [self setOriginByTranslationX:offset Y:0];
    }
}

- (void)placeLeftOfView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered {
    [self setOriginX:baseView.originX - (self.width + margin)];
    if (centered) {
        CGFloat offset = baseView.midY - self.midY;
        [self setOriginByTranslationX:0 Y:offset];
    }
}

- (void)placeRightOfView:(UIView *)baseView withMargin:(CGFloat)margin centered:(BOOL)centered {
    [self setOriginX:baseView.originX + baseView.width + margin];
    if (centered) {
        CGFloat offset = baseView.midY - self.midY;
        [self setOriginByTranslationX:0 Y:offset];
    }
}

- (void)alignToTopWithMargin:(CGFloat)margin centered:(BOOL)centered {
    [self setOriginY:margin];
    if (centered) {
        [self centerHorizontalyInSuperview];
    }
}

- (void)alignToBottomWithMargin:(CGFloat)margin centered:(BOOL)centered {
    [self setOriginY:self.superview.height-self.height-margin];
    if (centered) {
        [self centerHorizontalyInSuperview];
    }
}

- (void)alignToLeftWithMargin:(CGFloat)margin centered:(BOOL)centered {
    [self setOriginX:margin];
    if (centered) {
        [self centerVerticalyInSuperview];
    }
}

- (void)alignToRightWithMargin:(CGFloat)margin centered:(BOOL)centered {
    [self setOriginX:self.superview.width-self.width-margin];
    if (centered) {
        [self centerVerticalyInSuperview];
    }
}

- (void)alignToBottomOfScrollViewWithMargin:(CGFloat)margin centered:(BOOL)centered {
    UIScrollView *scrollview = (UIScrollView*)self.superview;
    [self setOriginY:scrollview.contentSize.height-self.height];
    if (centered) {
        [self centerHorizontalyInSuperview];
    }
}

#pragma mark - Even subviews aligning

- (void)alignSubviewsHorizontally:(NSArray*)subviews type:(AlignmentType)type {
    if (type == AlignmentTypeEqualCenters) {
        CGFloat viewSpace = self.frame.size.width/(subviews.count);
        [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view centerHorizontalyInRect:CGRectMake(viewSpace*idx, 1, viewSpace, 1)];
        }];
    }
    else if (type == AlignmentTypeEqualSpace) {
        CGFloat space = (self.frame.size.width - [self addedWidthOfViews:subviews])/(subviews.count+1);
        CGFloat __block sum=0;
        [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view setOriginX:space*(idx+1)+sum];
            sum+=view.frame.size.width;
        }];
    }
}

- (void)alignSubviewsVertically:(NSArray*)subviews type:(AlignmentType)type {
    if (type == AlignmentTypeEqualCenters) {
        CGFloat viewSpace = self.frame.size.height/(subviews.count);
        [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view centerVerticalyInRect:CGRectMake(viewSpace*idx, 1, viewSpace, 1)];
        }];
    }
    else if (type == AlignmentTypeEqualSpace) {
        CGFloat space = (self.frame.size.height - [self addedHeightOfViews:subviews])/(subviews.count+1);
        CGFloat __block sum=0;
        [subviews enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
            [view setOriginY:space*(idx+1)+sum];
            sum+=view.frame.size.height;
        }];
    }
}

#pragma mark - Adding subviews

- (void)addSubviews:(NSArray*)subviews {
    for (UIView *view in subviews) {
        [self addSubview:view];
    }
}

- (void)addSubviewCentered:(UIView *)view {
    [self addSubview:view];
    [view centerInSuperview];
}

- (void)addSubviewCenteredHorizontally:(UIView *)view {
    [self addSubview:view];
    [view centerHorizontalyInSuperview];
}

- (void)addSubviewCenteredVertically:(UIView *)view {
    [self addSubview:view];
    [view centerVerticalyInSuperview];
}

#pragma mark - Helpers

- (CGRect)rectContainingViews:(NSArray*)views
{
    CGFloat __block xMin, xMax, yMin, yMax;
    [views enumerateObjectsUsingBlock:^(UIView *obj, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            xMin = obj.minX;   yMin = obj.minY;
            xMax = obj.maxX;   yMax = obj.maxY;
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

- (CGSize)addedSizeOfViews:(NSArray*)views {
    CGFloat width=0, height=0;
    for (UIView *view in views) {
        width += view.frame.size.width;
        height += view.frame.size.height;
    }
    return CGSizeMake(width, height);
}

- (CGFloat)addedWidthOfViews:(NSArray*)views {
    CGFloat width=0;
    for (UIView *view in views) {
        width += view.frame.size.width;
    }
    return width;
}

- (CGFloat)addedHeightOfViews:(NSArray*)views {
    CGFloat height=0;
    for (UIView *view in views) {
        height += view.frame.size.height;
    }
    return height;
}

@end
