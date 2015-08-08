//
//  AZXTagEdtingView.h
//  AZX百思不得姐
//
//  Created by Azen.Xu on 15/8/8.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AZXTagTextField;

@interface AZXTagEdtingView : UIView

/** 文本行*/
@property(strong,nonatomic) AZXTagTextField *textField;
/** 按钮数组*/
@property(strong,nonatomic) NSMutableArray *btnArray;
/** 辅助按钮*/
@property(strong,nonatomic) UIButton *assBtn;

@end
