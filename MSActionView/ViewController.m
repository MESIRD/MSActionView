//
//  ViewController.m
//  MSActionView
//
//  Created by mesird on 5/5/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "ViewController.h"
#import "MSActionView/MSActionViewHeader.h"

@interface ViewController ()

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
    
    MSActionView *actionView = [[MSActionView alloc] initWithTitle:@"ActionViewTitle" cancelButtonTitle:@"Cancel" andOtherButtonTitles:@[@"OptionA", @"OptionB"]];
    [actionView show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
