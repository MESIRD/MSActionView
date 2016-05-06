//
//  MSActionView.h
//  MSActionView
//
//  Created by mesird on 5/5/16.
//  Copyright © 2016 mesird. All rights reserved.
//



#import <UIKit/UIKit.h>

@protocol MSActionViewDelegate <NSObject>

@optional
- (void)optionSelected:(NSDictionary *)userInfo;

@end

@interface MSActionView : UIView

typedef void (^TapActionBlock)(void);

@property (nonatomic, weak) id<MSActionViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle andOtherButtonTitles:(NSArray *)otherButtonTitles;

- (void)addButtonWithTitle:(NSString *)buttonTitle andTapActionBlock:(TapActionBlock)tapActionBlock;

- (void)show;

@end
