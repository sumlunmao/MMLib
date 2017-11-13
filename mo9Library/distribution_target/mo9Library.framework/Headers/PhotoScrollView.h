//
//  PhotoScrollView.h
//  MasterPu
//
//  Created by ChenJian on 1/6/15.
//  Copyright (c) 2015 masterpu. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PhotoScrollViewDelegate <NSObject>

- (void)photosViewDidClickedAtIndex:(NSInteger)index;

@end

@interface PhotoScrollView : UIView

+ (PhotoScrollView *)view;
@property (nonatomic,strong) NSArray *tittles;
@property (nonatomic, strong) NSArray *imageUrls;
@property (nonatomic, weak) id <PhotoScrollViewDelegate> delegate;
@property (nonatomic, assign) BOOL needAutoScroll;

- (UIImage *)firstImg;

@end
 
