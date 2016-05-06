//
//  MSActionView.m
//  MSActionView
//
//  Created by mesird on 5/5/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSActionView.h"
#import "MSActionTableViewCell.h"
#import "PrefixHeader.pch"

@interface MSActionView() <UITableViewDelegate, UITableViewDataSource>
{
    BOOL        hasTitle;
    BOOL        hasCancelButton;
    NSUInteger  otherButtonsSectionIndex;
    NSUInteger  cancelButtonSectionIndex;
}

@property (nonatomic, strong) UITableView                       *actionTableView;
@property (nonatomic, strong) UIView                            *contentView;
@property (nonatomic, strong) UIView                            *maskView;

@property (nonatomic, copy) NSString                            *title;
@property (nonatomic, copy) NSString                            *cancelButtonTitle;
@property (nonatomic, copy) NSMutableArray<NSString *>          *otherButtonTitles;
@property (nonatomic, copy) NSMutableArray<TapActionBlock>      *otherButtonActionBlocks;

@end

@implementation MSActionView

static NSString *const kReusableIdentifier = @"Action Table Vieww Cell";

static const CGFloat kTitleHeaderHeight  = 30.0f;
static const CGFloat kNormalHeaderHeight = 10.0f;
//static const CGFloat kNoHeaderHeight     = 0.0f;
static const CGFloat kOptionHeight       = 45.0f;
static const NSTimeInterval kSlideTime   = 0.3f;


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
        
    }
    return self;
}

- (void)initializeParameters {
    // init your custom data here
    
    _otherButtonActionBlocks = [[NSMutableArray alloc] init];
    
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
    _maskView.layer.opacity = 0.0f;
    [_contentView addSubview:_maskView];
    // add tap gesture recognizer to mask layer
    UITapGestureRecognizer *hideGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [_maskView addGestureRecognizer:hideGestureRecognizer];
    
    // config table view
    CGFloat tableViewHeight = 0 + (hasTitle ? kTitleHeaderHeight : 0) + (_otherButtonTitles.count > 0 ? _otherButtonTitles.count * kOptionHeight : 0) + (hasCancelButton ? _otherButtonTitles.count > 0 ? kOptionHeight + kNormalHeaderHeight : kOptionHeight : 0);
    _actionTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, tableViewHeight)];
    _actionTableView.backgroundColor = COLOR_OF_RGBA(243.0f, 244.0f, 245.0f, 1.0f);
    _actionTableView.scrollEnabled = NO;
    _actionTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _actionTableView.delegate = self;
    _actionTableView.dataSource = self;
    [_actionTableView registerClass:[MSActionTableViewCell class] forCellReuseIdentifier:kReusableIdentifier];
    [_contentView addSubview:_actionTableView];
}

- (void)reloadViewComponents {
    
    [self calculateSectionIndex];
    [_actionTableView reloadData];
}

- (UIView *)configTitleHeader {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _actionTableView.frame.size.width, kTitleHeaderHeight)];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _actionTableView.frame.size.width, kTitleHeaderHeight)];
    titleLabel.textColor = COLOR_OF_RGBA(172.0f, 180.0f, 185.0f, 1.0f);
    titleLabel.font = SYSTEM_FONT(13.0f);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = _title;
    [header addSubview:titleLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kTitleHeaderHeight - 1, _actionTableView.frame.size.width, 1.0f)];
    line.backgroundColor = COLOR_OF_RGBA(231.0f, 231.0f, 231.0f, 1.0f);
    [header addSubview:line];
    
    return header;
}

- (UIView *)configNormalHeader {
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kNormalHeaderHeight)];
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, kNormalHeaderHeight - 1, _actionTableView.frame.size.width, 1.0f)];
    line.backgroundColor = COLOR_OF_RGBA(231.0f, 231.0f, 231.0f, 1.0f);
    [header addSubview:line];
    return header;
}

- (void)resetTableViewFrame {
    
    CGFloat tableViewHeight = 0 + (hasTitle ? kTitleHeaderHeight : 0) + (_otherButtonTitles.count > 0 ? _otherButtonTitles.count * kOptionHeight : 0) + (hasCancelButton ? _otherButtonTitles.count > 0 ? kOptionHeight + kNormalHeaderHeight : kOptionHeight : 0);
    _actionTableView.frame = CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, tableViewHeight);
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

- (void)addButtonWithTitle:(NSString *)buttonTitle andTapActionBlock:(TapActionBlock)tapActionBlock {
    
    [_otherButtonTitles addObject:buttonTitle];
    [_otherButtonActionBlocks addObject:tapActionBlock];
    [self resetTableViewFrame];
    [self reloadViewComponents];
}

#pragma mark - Action View Animations

- (void)show {
    
    UIWindow *currentWindow = [[UIApplication sharedApplication] keyWindow] ? [[UIApplication sharedApplication] keyWindow] : [[[UIApplication sharedApplication] windows] firstObject];
    [currentWindow addSubview:self];
    
    [UIView animateWithDuration:kSlideTime animations:^{
        _maskView.layer.opacity = 1.0f;
        _actionTableView.frame = CGRectMake( _actionTableView.frame.origin.x, SCREEN_HEIGHT - _actionTableView.frame.size.height, _actionTableView.frame.size.width, _actionTableView.frame.size.height);
    } completion:^(BOOL finished) {
        NSLog(@"Action View Slide In Complete.");
    }];
}

- (void)hide {
    
    [UIView animateWithDuration:kSlideTime animations:^{
        _actionTableView.frame = CGRectMake( _actionTableView.frame.origin.x, SCREEN_HEIGHT, _actionTableView.frame.size.width, _actionTableView.frame.size.height);
        _maskView.layer.opacity = 0.0f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        NSLog(@"Action View Slide Out Complete.");
    }];
}

#pragma mark - Table View Delegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _otherButtonTitles.count > 0 && hasCancelButton ? 2 : 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if ( otherButtonsSectionIndex == section) {
        return _otherButtonTitles.count;
    } else if ( cancelButtonSectionIndex == section) {
        return 1;
    } else if ( 0 == section) {
        return 1;
    }
    return 0;
}

- (MSActionTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MSActionTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kReusableIdentifier forIndexPath:indexPath];
    if ( otherButtonsSectionIndex == indexPath.section) {
        cell.titleLabel.text = _otherButtonTitles[indexPath.row];
        return cell;
    } else if ( cancelButtonSectionIndex == indexPath.section) {
        cell.titleLabel.text = _cancelButtonTitle;
        return cell;
    }
    
    return [[MSActionTableViewCell alloc] init];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return _otherButtonTitles.count > 0 || hasCancelButton ?  kOptionHeight : 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if ( _otherButtonTitles.count > 0) {
        return otherButtonsSectionIndex == section ? kTitleHeaderHeight : kNormalHeaderHeight;
    } else if ( hasCancelButton) {
        return kTitleHeaderHeight;
    }
    return kTitleHeaderHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if ( otherButtonsSectionIndex == section) {
        if (  hasTitle) {
            return [self configTitleHeader];
        } else {
            return [[UIView alloc] init];
        }
    } else if ( cancelButtonSectionIndex == section) {
        if ( _otherButtonTitles.count > 0) {
            return [self configNormalHeader];
        } else {
            return [self configTitleHeader];
        }
    } else if ( 0 == section) {
        return [self configTitleHeader];
    }
    return [[UIView alloc] init];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ( self.delegate) {
        if ( cancelButtonSectionIndex == indexPath.section && indexPath.row == 0) {
            //cancel button pressed
        } else if ( otherButtonsSectionIndex == indexPath.section) {
            //other button pressed
            if ( [self.delegate respondsToSelector:@selector(optionSelected:)]) {
                [self.delegate performSelector:@selector(optionSelected:) withObject:@{@"index":[NSNumber numberWithUnsignedInteger:indexPath.row], @"title":_otherButtonTitles[indexPath.row]}];
            }
            NSLog(@"Button at index(%ld) is pressed", indexPath.row);
        }
    } else if ( _otherButtonActionBlocks.count > indexPath.row) {
        if (  _otherButtonActionBlocks[indexPath.row]) {
            _otherButtonActionBlocks[indexPath.row]();
        }
    }
    
    [self hide];
}

@end
