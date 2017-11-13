//
//  SectionView.m
//  Mo9Mokredit
//
//  Created by ChenJian on 1/24/15.
//  Copyright (c) 2015 Mo9. All rights reserved.
//

#import "SectionView.h"

@implementation SectionView


+ (SectionView *)view {
    return [[NSBundle mainBundle] loadNibNamed:@"SectionView" owner:nil options:nil][0];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
