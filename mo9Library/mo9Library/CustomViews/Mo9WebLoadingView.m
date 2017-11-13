//
//  WebLoadingView.m
//  testJs
//
//  Created by mouh on 2017/5/16.
//  Copyright © 2017年 mouh. All rights reserved.
//

#import "Mo9WebLoadingView.h"

@interface Mo9WebLoadingView ()

@property (nonatomic, strong) UIImageView *loadingImgView;

@property (nonatomic, strong) NSMutableArray *animImages;

@property (nonatomic, strong) NSMutableArray *hudArray;

@end

@implementation Mo9WebLoadingView


#pragma mark - LifeCyle
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.loadingImgView];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self addSubview:self.loadingImgView];
    }
    return self;
}

- (void)_layoutSubViews
{
    UIView *parent = self.superview;
    if (parent) {
        self.frame = parent.bounds;
    }
    CGRect bounds = self.bounds;
    
    UIImage *firstImg = self.animImages.firstObject;
    CGSize loadingSize = firstImg.size;
    self.loadingImgView.frame = (CGRect){(bounds.size.width- loadingSize.width) *0.5, (bounds.size.height- loadingSize.height) *0.5, loadingSize};
}

- (void)dealloc {
    
    Log(@"%@--释放了", NSStringFromClass([self class]));
}



#pragma mark - Public Methods
+ (void)startLoadingWithView:(UIView *)view animate:(BOOL)animate
{
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return ;
        }
    }
    Mo9WebLoadingView *loadingView = [[self alloc] init];
    
    if (view) {
        [view addSubview:loadingView];
    } else {
        [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
    }
    
    [loadingView startAnimate:animate];
    
}

+ (void)finishLoadingWithView:(UIView *)view animate:(BOOL)animate
{
    if (view == nil) {
        view = [UIApplication sharedApplication].keyWindow;
    }
    
    Mo9WebLoadingView *loadingView = [self loadingForView:view];
    [loadingView finishAnimate:animate];
}

+ (void)startLoadingAnimate:(BOOL)animate
{
    NSEnumerator *subviewsEnum = [[UIApplication sharedApplication].keyWindow.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return ;
        }
    }
    Mo9WebLoadingView *loadingView = [[self alloc] init];
    [[UIApplication sharedApplication].keyWindow addSubview:loadingView];
    [loadingView startAnimate:animate];
}

+ (void)finishLoadingAnimate:(BOOL)animate
{
    Mo9WebLoadingView *loadingView = [self loadingForView:[UIApplication sharedApplication].keyWindow];
    [loadingView finishAnimate:animate];
}

#pragma mark - Target Methods

#pragma mark - Private Method
+ (Mo9WebLoadingView *)loadingForView:(UIView *)view {
    
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            return (Mo9WebLoadingView *)subview;
        }
    }
    return nil;
}

+ (NSArray *)loadingViewsForView:(UIView *)view
{
    NSMutableArray *arrM = [NSMutableArray array];
    NSEnumerator *subviewsEnum = [view.subviews reverseObjectEnumerator];
    for (UIView *subview in subviewsEnum) {
        if ([subview isKindOfClass:self]) {
            [arrM addObject:subview];
        }
    }
    return [arrM copy];
}

- (void)startAnimate:(BOOL)anim
{
    if (anim) {
        [UIView animateWithDuration:0.3f animations:^{
            self.loadingImgView.alpha = 1.0f;
        }];
    }
    
    self.loadingImgView.animationImages = self.animImages;
    CGFloat duration = self.animImages.count * 0.18;
    self.loadingImgView.animationDuration = duration;
    self.loadingImgView.animationRepeatCount = 0;
    [self.loadingImgView startAnimating];
    
    [self _layoutSubViews];
}

- (void)finishAnimate:(BOOL)anim
{
    if (self != nil) {
        if (anim) {
            
            [UIView animateWithDuration:0.3f animations:^{
                
                CGAffineTransform transForm = CGAffineTransformScale(self.loadingImgView.transform,0.1, 0.1);
                self.loadingImgView.transform = transForm ;
            } completion:^(BOOL finished) {
                [self.animImages removeAllObjects];
                [self removeFromSuperview];
            }];
        } else {
            self.loadingImgView.alpha = 0.0f;
            [self removeFromSuperview];
        }
        
    }
}

#pragma mark - observe Methods

#pragma mark - Setter Getter Methods

- (UIImageView *)loadingImgView
{
    if (!_loadingImgView) {
        _loadingImgView = [[UIImageView alloc] init];
        _loadingImgView.contentMode = UIViewContentModeCenter;
        _loadingImgView.alpha = 0;
    }
    
    return _loadingImgView;
}

- (NSMutableArray *)animImages
{
    if (!_animImages) {
        _animImages = [[NSMutableArray alloc] initWithCapacity:MaxPageCount];
        for (int i =1; i <= MaxPageCount; i ++) {
            NSBundle *bundle = [NSBundle bundleWithPath:[[Infrastructure getResManager] imagePath]];
            UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"web_loading%i",i]
                                      inBundle:bundle
                 compatibleWithTraitCollection:nil];
            if (img) {
                [_animImages addObject:img];
            }else {
                break;
            }
            Log(@"webLoadingImgArr:%@",_animImages);
        };
    }
    return _animImages;
}


#pragma mark - External Delegate


@end
