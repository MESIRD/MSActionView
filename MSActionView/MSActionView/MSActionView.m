//
//  MSActionView.m
//  MSActionView
//
//  Created by mesird on 5/5/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSActionView.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define COLOR_OF_RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]

@interface MSActionView() <UITableViewDelegate, UITableViewDataSource>
{
    BOOL        hasTitle;
    BOOL        hasCancelButton;
    NSUInteger  otherButtonCount;
}

@property (nonatomic, strong) UITableView       *actionTableView;
@property (nonatomic, strong) UIView            *contentView;
@property (nonatomic, strong) UIView            *maskView;

@property (nonatomic, copy) NSString            *title;
@property (nonatomic, copy) NSString            *cancelButtonTitle;
@property (nonatomic, copy) NSMutableArray      *otherButtonTitles;

@end

@implementation MSActionView

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle andOtherButtonTitles:(NSArray *)otherButtonTitles {
    
    self = [super initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    if ( self) {
        
        // whether has title
        hasTitle = title && ![title isEqualToString:@""];
        _title = title;
        
        // whether has cancel button
        hasCancelButton = cancelButtonTitle && ![cancelButtonTitle isEqualToString:@""];
        _cancelButtonTitle = cancelButtonTitle;
        
        // whether has other buttons
        _otherButtonTitles = otherButtonTitles ? [otherButtonTitles mutableCopy] : [[NSMutableArray alloc] init];
        otherButtonCount = _otherButtonTitles ? _otherButtonTitles.count : 0;
        
        // init data
        [self initializeParameters];
        
        // set up UI
        [self setUpUI];
        
    }
    return self;
}

- (void)initializeParameters {
    // init your custom data here
}

- (void)setUpUI {
    //set up your custom view here
    
    // config content view
    _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
    _contentView.backgroundColor = [UIColor clearColor];
    [self addSubview:_contentView];
    
    // config mask layer
    _maskView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _contentView.frame.size.width, _contentView.frame.size.height)];
    _maskView.backgroundColor = [UIColor colorWithWhite:0.0f alpha:0.5f];
    [_contentView addSubview:_maskView];
    // add tap gesture recognizer to mask layer
    UITapGestureRecognizer *hideGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [_maskView addGestureRecognizer:hideGestureRecognizer];
    
    // config table view
    _actionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0)];
    _actionTableView.backgroundColor = COLOR_OF_RGBA(243.0f, 244.0f, 245.0f, 1.0f);
    _actionTableView.delegate = self;
    _actionTableView.dataSource = self;
    [_contentView addSubview:_actionTableView];
    
    
}

- (void)addOtherButtonWithTitle:(NSString *)otherButtonTitle andTapActionBlock:(TapActionBlock)tapActionBlock {
    
}

- (void)show {
    
}

- (void)hide {
    
}

#pragma mark - Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return hasCancelButton ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
}

@end
