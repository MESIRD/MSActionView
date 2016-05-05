//
//  MSActionView.m
//  MSActionView
//
//  Created by mesird on 5/5/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSActionView.h"
#import "MSActionTableViewCell.h"

#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define COLOR_OF_RGBA(R,G,B,A) [UIColor colorWithRed:R/255.0f green:G/255.0f blue:B/255.0f alpha:A]
#define SYSTEM_FONT(size) [UIFont systemFontOfSize:size]

@interface MSActionView() <UITableViewDelegate, UITableViewDataSource>
{
    BOOL        hasTitle;
    BOOL        hasCancelButton;
    NSUInteger  otherButtonsSectionIndex;
    NSUInteger  cancelButtonSectionIndex;
}

@property (nonatomic, strong) UITableView       *actionTableView;
@property (nonatomic, strong) UIView            *contentView;
@property (nonatomic, strong) UIView            *maskView;

@property (nonatomic, copy) NSString            *title;
@property (nonatomic, copy) NSString            *cancelButtonTitle;
@property (nonatomic, copy) NSMutableArray      *otherButtonTitles;

@end

@implementation MSActionView

static NSString *const kReusableIdentifier = @"Action Table Vieww Cell";

static const CGFloat kTitleHeaderHeight = 30.0f;
static const CGFloat kOptionHeight = 45.0f;

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
        
        // init data
        [self initializeParameters];
        
        // set up UI
        [self setUpUI];
        
        // register cell class
        [_actionTableView registerClass:[MSActionTableViewCell class] forCellReuseIdentifier:kReusableIdentifier];
        
    }
    return self;
}

- (void)initializeParameters {
    // init your custom data here
    
    [self calculateSectionIndex];
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
    CGFloat tableViewHeight = 300;
//    0 + (hasTitle ? kTitleHeaderHeight : 0) + (_otherButtonTitles.count > 0 ? _otherButtonTitles.count * kOptionHeight : 0) + (hasCancelButton ? kOptionHeight : 0);
    _actionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - tableViewHeight, SCREEN_WIDTH, tableViewHeight) style:UITableViewStyleGrouped];
    _actionTableView.backgroundColor = COLOR_OF_RGBA(243.0f, 244.0f, 245.0f, 1.0f);
    _actionTableView.scrollEnabled = NO;
    _actionTableView.delegate = self;
    _actionTableView.dataSource = self;
    [_contentView addSubview:_actionTableView];
    
}

- (void)reloadViewComponents {
    
    
    [self calculateSectionIndex];
    [_actionTableView reloadData];
}

- (void)calculateSectionIndex {
    
    if ( _otherButtonTitles.count == 0) {
        otherButtonsSectionIndex = -1;
        cancelButtonSectionIndex = hasCancelButton ? 0 : -1;
    } else {
        otherButtonsSectionIndex = 0;
        cancelButtonSectionIndex = hasCancelButton ? 1 : -1;
    }
}

- (void)addOtherButtonWithTitle:(NSString *)otherButtonTitle andTapActionBlock:(TapActionBlock)tapActionBlock {
    
    
    
    [self reloadViewComponents];
}

- (void)show {
    
    UIWindow *currentWindow = [[UIApplication sharedApplication] keyWindow] ? [[UIApplication sharedApplication] keyWindow] : [[[UIApplication sharedApplication] windows] firstObject];
    [currentWindow addSubview:self];
}

- (void)hide {
    
    [self removeFromSuperview];
}

#pragma mark - Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return hasCancelButton ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ( otherButtonsSectionIndex == section) {
        return _otherButtonTitles.count;
    } else if ( cancelButtonSectionIndex == section) {
        return 1;
    }
    return 0;
}

- (MSActionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MSActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifier];
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kOptionHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ( otherButtonsSectionIndex == section) {
        if ( hasTitle) {
            UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kTitleHeaderHeight)];
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 19.0f)];
            titleLabel.textColor = COLOR_OF_RGBA(172.0f, 180.0f, 185.0f, 1.0f);
            titleLabel.font = SYSTEM_FONT(13.0f);
            titleLabel.textAlignment = NSTextAlignmentCenter;
            [header addSubview:titleLabel];
            return header;
        }
    }
    return [[UIView alloc] init];
}

@end
