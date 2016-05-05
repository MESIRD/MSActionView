//
//  MSActionView.h
//  MSActionView
//
//  Created by mesird on 5/5/16.
//  Copyright © 2016 mesird. All rights reserved.
//
//
//
//
//  There are two ways to implement selection action:
//
//  1. set your target view controller as MSActionView's delegate and implement method
//     '- (void)didSelectionOnOptionIndex:(NSUInteger)index', whenever the option is
//     selected, delegate will perform this method
//
//  2. initialize MSActionView with no other buttons at first time, add them one by one
//     with their own callback block then.
//


#import <UIKit/UIKit.h>

@protocol MSActionViewDelegate <NSObject>

@optional
- (void)didSelectionOnOptionIndex:(NSUInteger)index;

@end

@interface MSActionView : UIView

typedef void (^TapActionBlock)(void);

@property (nonatomic, weak) id<MSActionViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle andOtherButtonTitles:(NSArray *)otherButtonTitles;

- (void)addOtherButtonWithTitle:(NSString *)otherButtonTitle andTapActionBlock:(TapActionBlock)tapActionBlock;

- (void)show;

@end
