//
//  PhotoScrollView.m
//  MasterPu
//
//  Created by ChenJian on 1/6/15.
//  Copyright (c) 2015 masterpu. All rights reserved.
//

#import "PhotoScrollView.h"
#import "UIImage+Kit.h"
#import <SDWebImage/SDWebImage.h>

@interface PhotoScrollView()<UIScrollViewDelegate>
@property (nonatomic, assign) NSInteger pageIndex;
@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic, weak) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *tittleLbl;

@end

@implementation PhotoScrollView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.pageControl.pageIndicatorTintColor = [UIColor colorWithRed:203/255.0 green:203/255.0 blue:203/255.0 alpha:1];
    self.pageControl.currentPageIndicatorTintColor = [UIColor colorWithRed:127/255.0 green:127/255.0 blue:127/255.0 alpha:1];
    self.pageControl.hidesForSinglePage = YES;
    self.pageControl.userInteractionEnabled = NO;
}

+ (PhotoScrollView *)view {
    return [[NSBundle mainBundle] loadNibNamed:@"PhotoScrollView" owner:nil options:nil][0];
}

- (void)setImageUrls:(NSArray *)imageUrls {
    _imageUrls = [NSArray arrayWithArray:imageUrls];
    self.pageControl.numberOfPages = _imageUrls.count;
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(_scrollView.frame)*_imageUrls.count, CGRectGetHeight(self.bounds));
    
    [self resetData];
   
   CGFloat h = self.bounds.size.height;
   CGFloat y = 0;
    for (int i=0;i<_imageUrls.count;i++) {
        NSString *url = _imageUrls[i];
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(i*CGRectGetWidth(_scrollView.frame), y, CGRectGetWidth(_scrollView.frame), h)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:url]];

        imgView.userInteractionEnabled = YES;
        imgView.tag = i+100;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClicked:)];
        [imgView addGestureRecognizer:tap];
        [self.scrollView addSubview:imgView];
    }
    
    [self bringSubviewToFront:self.pageControl];
    
    [self checkAndBeginAutoScroll];
}
-(void)setTittles:(NSArray *)tittles {
    CGFloat y = self.pageControl.frame.origin.y - 10;
    for (int i = 0 ; i < tittles.count; i ++) {
        NSString *tittle = tittles[i];
        if (tittle.length > 0) {
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(i * CGRectGetWidth(_scrollView.frame), y, CGRectGetWidth(_scrollView.frame), 20)];
            label.font = [UIFont systemFontOfSize:14];
            label.textColor = [UIColor colorWithRed:255/255.0f green:255/255.0f blue:255/255.0f alpha:1];
            label.textAlignment = NSTextAlignmentCenter;
            label.text = tittle;
            [_scrollView addSubview:label];
        }
    }
}
- (void)resetData {
    self.pageIndex = 0;
    for (UIView *v in self.scrollView.subviews) {
        if ([v isKindOfClass:[UIImageView class]]&&v.tag>=100) {
            [v removeFromSuperview];
        }
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    self.pageIndex = scrollView.contentOffset.x/CGRectGetWidth(_scrollView.frame);
}

- (IBAction)imgClicked:(UIGestureRecognizer *)gesture {
    if (_delegate&&[_delegate respondsToSelector:@selector(photosViewDidClickedAtIndex:)]) {
        [self.delegate photosViewDidClickedAtIndex:gesture.view.tag - 100];
    }
}

- (void)setPageIndex:(NSInteger)pageIndex {
    _pageIndex = pageIndex;
    self.pageControl.currentPage = pageIndex;
    [self.scrollView setContentOffset:CGPointMake(kWinSize.width*pageIndex, 0) animated:YES];
}


- (UIImage *)firstImg {
    if (_imageUrls.count>0) {
        UIImageView *imgView = (UIImageView *)[self.scrollView viewWithTag:100];
        return imgView.image;
    }
    return nil;
}

- (void)checkAndBeginAutoScroll {
    [self stopAutoScroll];
    
    if (_imageUrls.count>1&&_needAutoScroll) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(scrollToNext) userInfo:nil repeats:YES];
    }
}

- (void)stopAutoScroll {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)scrollToNext {
    if (_pageIndex==_imageUrls.count-1) {
        self.pageIndex = 0;
    }else {
        self.pageIndex+=1;
    }
}

- (void)setNeedAutoScroll:(BOOL)needAutoScroll {
    _needAutoScroll = needAutoScroll;
    if (!needAutoScroll) {
        [self stopAutoScroll];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
