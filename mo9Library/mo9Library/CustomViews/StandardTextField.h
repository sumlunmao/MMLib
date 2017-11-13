//
//  StandardTextField.h
//  Mo9Client
//
//  Created by ChenJian on 16/11/7.
//  Copyright © 2016年 mo9. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum  {
    FieldTypeDefault,
    FieldTypePhoneNum,
    FieldTypeCardId
}FieldType;

@interface StandardTextField : UITextField

@property (nonatomic, assign) FieldType type;
@property (nonatomic, copy)   NSString *standardText;

@end
