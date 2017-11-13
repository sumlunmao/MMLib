//
//  PortraitImageView.h
//  Mo9Client
//
//  Created by ChenJian on 15/6/9.
//  Copyright (c) 2015年 mo9. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    PortraitTypeNormal,
    PortraitTypeDiamond
}PortraitType;

@interface PortraitImageView : UIImageView

@property (nonatomic, assign) PortraitType type;

@end
