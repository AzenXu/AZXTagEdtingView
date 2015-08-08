//
//  ViewController.m
//  AZXTagEdtingViewExample
//
//  Created by Azen.Xu on 15/8/8.
//  Copyright (c) 2015年 Azen.Xu. All rights reserved.
//

#import "ViewController.h"
#import "AZXTagEdtingView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    AZXTagEdtingView *edtingPage = [[AZXTagEdtingView alloc] initWithFrame:CGRectMake(0, 30, self.view.bounds.size.width, self.view.bounds.size.height)];
    edtingPage.backgroundColor = [UIColor blackColor];
    [self.view addSubview:edtingPage];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
