//
//  AZXTagTextField.h
//  AZX百思不得姐
//
//  Created by Azen.Xu on 15/8/8.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AZXTagTextFieldBlock)();

@interface AZXTagTextField : UITextField

/** block*/
@property(strong,nonatomic) AZXTagTextFieldBlock block;


@end
