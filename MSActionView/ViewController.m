//
//  ViewController.m
//  MSActionView
//
//  Created by mesird on 5/5/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "ViewController.h"
#import "MSActionView/MSActionViewHeader.h"

@interface ViewController () <MSActionViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeContactAdd];
    button.frame = CGRectMake(100, 100, 100, 100);
    [button addTarget:self action:@selector(display) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)display {
    
    MSActionView *actionView;
    
    // 1. using delegate to implement tap action
    actionView = [self configActionViewWithDelegate];
    
    // 2. using blocks to implement tap action
//    actionView = [self configActionViewWithBlock];
    
    [actionView show];
}

- (MSActionView *)configActionViewWithDelegate {
    
    MSActionView *actionView = [[MSActionView alloc] initWithTitle:@"ActionViewTitle" cancelButtonTitle:@"Cancel" andOtherButtonTitles:@[@"OptionA", @"OptionB"]];
    actionView.delegate = self;
    return actionView;
}

- (MSActionView *)configActionViewWithBlock {
    
    MSActionView *actionView = [[MSActionView alloc] initWithTitle:@"Action View Title" cancelButtonTitle:nil andOtherButtonTitles:nil];
    [actionView addButtonWithTitle:@"OptionA" andTapActionBlock:^{
        NSLog(@"This is optionA!");
    }];
    [actionView addButtonWithTitle:@"OptionB" andTapActionBlock:^{
        NSLog(@"This is optionB!");
    }];
    return actionView;
}

- (void)optionSelected:(NSDictionary *)userInfo {
    
    NSUInteger index = [userInfo[@"index"] unsignedIntegerValue];
    switch (index) {
        case 0:
            NSLog(@"AAAA");
            break;
        case 1:
            NSLog(@"BBBB");
            break;
        default:
            break;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
