//
//  SingleImageCell.h
//  Mo9Client
//
//  Created by ChenJian on 2017/3/28.
//  Copyright © 2017年 mo9. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kSingleCellIdentifier @"singleimagecellidentifier"
@interface SingleImageCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIImageView *imageView;

@end
