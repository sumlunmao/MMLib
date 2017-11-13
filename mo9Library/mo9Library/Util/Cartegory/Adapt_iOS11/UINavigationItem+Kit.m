//
//  UINavigationItem+Kit.m
//  mo9Library
//
//  Created by sunlunmao on 2017/9/29.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import "UINavigationItem+Kit.h"
#import "NSObject+Kit.h"

typedef NS_ENUM(NSInteger, Mo9BarViewPosition) {
    Mo9BarViewPositionLeft,
    Mo9BarViewPositionRight
};

@interface BarView : UIView
@property (nonatomic, assign) Mo9BarViewPosition position;
@property (nonatomic, assign) BOOL applied;
@end

@implementation BarView

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.applied || [[[UIDevice currentDevice] systemVersion] floatValue]  < 11) return;
    UIView *view = self;
    while (![view isKindOfClass:UINavigationBar.class] && view.superview) {
        view = [view superview];
        if ([view isKindOfClass:UIStackView.class] && view.superview) {
            if (self.position == Mo9BarViewPositionLeft) {
                for (NSLayoutConstraint *constraint in view.superview.constraints) {
                    if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                         constraint.firstAttribute == NSLayoutAttributeTrailing)) {
                        [view.superview removeConstraint:constraint];
                    }
                }
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeLeading
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view.superview
                                                                           attribute:NSLayoutAttributeLeading
                                                                          multiplier:1.0
                                                                            constant:0]];
                self.applied = YES;
            } else if (self.position == Mo9BarViewPositionRight) {
                for (NSLayoutConstraint *constraint in view.superview.constraints) {
                    if (([constraint.firstItem isKindOfClass:UILayoutGuide.class] &&
                         constraint.firstAttribute == NSLayoutAttributeLeading)) {
                        [view.superview removeConstraint:constraint];
                    }
                }
                [view.superview addConstraint:[NSLayoutConstraint constraintWithItem:view
                                                                           attribute:NSLayoutAttributeTrailing
                                                                           relatedBy:NSLayoutRelationEqual
                                                                              toItem:view.superview
                                                                           attribute:NSLayoutAttributeTrailing
                                                                          multiplier:1.0
                                                                            constant:0]];
                self.applied = YES;
            }
            break;
        }
    }
}
@end

@implementation UINavigationItem (Kit)

+(void)load {
    [self swizzleInstanceMethodWithOriginSel:@selector(setLeftBarButtonItem:)
                                 swizzledSel:@selector(sx_setLeftBarButtonItem:)];
    [self swizzleInstanceMethodWithOriginSel:@selector(setRightBarButtonItem:)
                                 swizzledSel:@selector(sx_setRightBarButtonItem:)];
}

-(void)sx_setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem{
    if (leftBarButtonItem.customView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
            UIView *customView = leftBarButtonItem.customView;
            BarView *barView = [[BarView alloc]initWithFrame:customView.bounds];
            [barView addSubview:customView];
            customView.center = barView.center;
            [barView setPosition:Mo9BarViewPositionLeft];
            [self setLeftBarButtonItems:nil];
            [self sx_setLeftBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:barView]];
        }else {
            [self sx_setLeftBarButtonItem:nil];
            [self setLeftBarButtonItems:@[[self fixedSpaceWithWidth:-20], leftBarButtonItem]];
        }
    }else {
        [self setLeftBarButtonItems:nil];
        [self sx_setLeftBarButtonItem:leftBarButtonItem];
    }
}

-(void)sx_setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem{
    if (rightBarButtonItem.customView) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11) {
            UIView *customView = rightBarButtonItem.customView;
            BarView *barView = [[BarView alloc]initWithFrame:customView.bounds];
            [barView addSubview:customView];
            customView.center = barView.center;
            [barView setPosition:Mo9BarViewPositionRight];
            [self setRightBarButtonItems:nil];
            [self sx_setRightBarButtonItem:[[UIBarButtonItem alloc]initWithCustomView:barView]];
        } else {
            [self sx_setRightBarButtonItem:nil];
            [self setRightBarButtonItems:@[[self fixedSpaceWithWidth:-20], rightBarButtonItem]];
        }
    }else {
        [self setRightBarButtonItems:nil];
        [self sx_setRightBarButtonItem:rightBarButtonItem];
    }
}

-(UIBarButtonItem *)fixedSpaceWithWidth:(CGFloat)width {
    UIBarButtonItem *fixedSpace = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                                                               target:nil
                                                                               action:nil];
    fixedSpace.width = width;
    return fixedSpace;
}

@end
