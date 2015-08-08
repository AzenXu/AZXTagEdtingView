//
//  AZXTagEdtingView.m
//  AZX百思不得姐
//
//  Created by Azen.Xu on 15/8/8.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "AZXTagEdtingView.h"
#import "AZXTagTextField.h"

@interface AZXTagEdtingView ()<UITextFieldDelegate>

@end

@implementation AZXTagEdtingView

static CGFloat AZXTagBarMinLength = 100;
static CGFloat AZXMarginInCell = 10;
static CGFloat maxTagCount = 5;

#pragma mark --懒加载
- (NSMutableArray *)btnArray
{
    if (_btnArray == nil) {
        _btnArray = [NSMutableArray array];
    }
    return _btnArray;
}
- (AZXTagTextField *)textField
{
    if (_textField == nil) {
        _textField = [[AZXTagTextField alloc] initWithFrame:[self updateTextFrame]];
        _textField.placeholder = @"请输入标签";
        _textField.backgroundColor = [UIColor yellowColor];
        _textField.delegate = self;
        
        //  通过block监听删除按钮点击
        __weak typeof(self) weakSelf = self;
        _textField.block = ^{
            if (![weakSelf.textField hasText]) {
                UIButton *btn = weakSelf.btnArray.lastObject;
                btn.state != UIControlStateSelected ? [btn setSelected:YES] : [weakSelf tagBtnClick:btn];
            }
        };
    }
    return _textField;
}

- (UIButton *)assBtn
{
    if (_assBtn == nil) {
        _assBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_assBtn addTarget:self action:@selector(assBtnClick) forControlEvents:UIControlEventTouchUpInside];
        _assBtn.backgroundColor = [UIColor redColor];
        _assBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    }
    return _assBtn;
}

- (void)layoutSubviews
{
    [self setupUI];
}
#pragma mark --初始化UI
- (void)setupUI
{
    [self addSubview:self.textField];
}

#pragma mark --计算TextField位置
- (CGRect)updateTextFrame
{
    //  X与Y固定
    
    CGFloat height = 30;
    
    //  计算width和height
    //  取出按钮数组最后一个元素
    UIButton *btn = self.btnArray.lastObject;
    //  没有按钮则直接定位
    if (btn == nil) {
        return CGRectMake(AZXMarginInCell, AZXMarginInCell, self.bounds.size.width - 2 * AZXMarginInCell, height);
    }
    //  有按钮则判断textField是否需要换行,并计算x与y
    CGFloat widthPart = btn.frame.size.width + btn.frame.origin.x + AZXMarginInCell;
    CGFloat x = self.bounds.size.width - widthPart > AZXTagBarMinLength ? widthPart : AZXMarginInCell;
    CGFloat y = self.bounds.size.width - widthPart > AZXTagBarMinLength ? btn.frame.origin.y : btn.frame.origin.y + AZXMarginInCell + btn.frame.size.height;
    CGFloat width = x == AZXMarginInCell ? self.bounds.size.width - 2 * AZXMarginInCell : self.bounds.size.width - widthPart - AZXMarginInCell;
    //  返回frame
    CGRect frame = CGRectMake(x, y, width, height);
    return frame;
}
#pragma mark --创建按钮
- (void)creatBtnWithString :(NSString *)string
{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:string forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor greenColor];
    [btn setTitle:@"准备删除" forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    //  设置btn宽度和高度
    [btn sizeToFit];
    if (btn.frame.size.width > self.bounds.size.width - 2 * AZXMarginInCell) {
        CGRect frame = btn.frame;
        frame.size.width = self.bounds.size.width - 2 * AZXMarginInCell;
        btn.frame = frame;
    }
    //  计算Btn的frame
    UIButton *lastBtn = self.btnArray.lastObject;
    if (lastBtn == nil) {
        CGRect frame = btn.frame;
        frame.origin.x = AZXMarginInCell;
        frame.origin.y = AZXMarginInCell;
        btn.frame = frame;
    }
    else
    {
        CGFloat widthPart = lastBtn.frame.origin.x + lastBtn.frame.size.width + AZXMarginInCell;
        CGRect frame = btn.frame;
        frame.origin.x = self.bounds.size.width - widthPart > btn.frame.size.width ? widthPart : AZXMarginInCell;
        frame.origin.y = self.bounds.size.width - widthPart > btn.frame.size.width ? lastBtn.frame.origin.y : lastBtn.frame.origin.y + lastBtn.frame.size.height + AZXMarginInCell;
        btn.frame = frame;
    }
    
    //  添加Btn
    [self.btnArray addObject:btn];
    [self addSubview:btn];
    
    //  更新文本框frame
    self.textField.frame = [self updateTextFrame];
}

//  按钮的点击删除
- (void)tagBtnClick :(UIButton *)btn
{
    [btn removeFromSuperview];
    [self.btnArray removeObject:btn];
    
    //  更新textField和tagBtn
    [UIView animateWithDuration:0.5 animations:^{
        [self updateTagsFrame];
        self.textField.frame = [self updateTextFrame];
        self.assBtn.frame = CGRectMake(self.textField.frame.origin.x, self.textField.frame.origin.y + self.textField.frame.size.height, self.textField.frame.size.width, self.textField.frame.size.height);
        
    }];
}

//  更新所有TagBtn的frame
- (void)updateTagsFrame
{
    UIButton *lastBtn = nil;
    for (int i = 0; i < self.btnArray.count; i++) {
        UIButton *btn = self.btnArray[i];
        CGRect frame = btn.frame;
        if (lastBtn == nil) {
            frame.origin.x = AZXMarginInCell;
            frame.origin.y = AZXMarginInCell;
        }
        else
        {
            CGFloat widthPart = lastBtn.frame.origin.x + lastBtn.frame.size.width + AZXMarginInCell;
            frame.origin.x = self.bounds.size.width - widthPart > btn.frame.size.width ? widthPart : AZXMarginInCell;
            frame.origin.y = self.bounds.size.width - widthPart > btn.frame.size.width ? lastBtn.frame.origin.y : lastBtn.frame.origin.y + lastBtn.frame.size.height + AZXMarginInCell;
        }
        btn.frame = frame;
        lastBtn = btn;
    }
}

//  点击辅助按钮添加TagBtn功能
- (void)assBtnClick
{
    [self textFieldShouldReturn:self.textField];
}

#pragma mark --UITextField代理方法
//  Return创建TagBtn
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.btnArray.count >= maxTagCount) {
#warning 超出最大标签数量处理
        return NO;
    }
    [self creatBtnWithString:textField.text];
    self.textField.text = nil;
    [self.assBtn removeFromSuperview];
    return YES;
}

//  监听文字录入,实时计算文字长度 - 如果超过text的宽度，则换行
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    //  开始录入文字时，创建辅助按钮
    if ([NSStringFromRange(range) isEqualToString:@"{0, 0}"]) {
        self.assBtn.frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y + textField.frame.size.height, textField.frame.size.width, textField.frame.size.height);
        [self addSubview:self.assBtn];
    }
    NSString *assBtnString = [@"点击添加标签：" stringByAppendingString:textField.text];
    [self.assBtn setTitle:[assBtnString stringByAppendingString:string] forState:UIControlStateNormal];
    
    //  超长换行展示功能
    CGFloat stringWidth = [self.assBtn.titleLabel.text sizeWithFont:self.assBtn.titleLabel.font constrainedToSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)].width;
    if (stringWidth > self.assBtn.frame.size.width && self.assBtn.frame.origin.x != AZXMarginInCell) {
        UIButton *btn = self.btnArray.lastObject;
        [UIView animateWithDuration:0.5 animations:^{
            CGRect frame = self.textField.frame;
            frame.origin.x = AZXMarginInCell;
            frame.origin.y = btn.frame.size.height + btn.frame.origin.y + AZXMarginInCell;
            frame.size.width = self.bounds.size.width - 2 * AZXMarginInCell;
            self.textField.frame = frame;
            self.assBtn.frame = CGRectMake(textField.frame.origin.x, textField.frame.origin.y + textField.frame.size.height, textField.frame.size.width, textField.frame.size.height);
        }];
    }
    
    //  逗号创建tag功能
    if ([string isEqualToString:@","] && range.location != 0) {
        [self textFieldShouldReturn:self.textField];
        return NO;
    }
    
    
    return YES;
}


@end
