//
//  MSActionView.h
//  MSActionView
//
//  Created by mesird on 5/5/16.
//  Copyright © 2016 mesird. All rights reserved.
//



#import <UIKit/UIKit.h>

typedef void (^TapActionBlock)(void);



@protocol MSActionViewDelegate <NSObject>

@optional

/*
 *  userInfo contains three keys
 *
 *  MSOptionUserInfoTarget : the instance of action view itself
 *  MSOptionUserInfoIndex  : the selected option index
 *  MSOptionUserInfoTitle  : the selected option title
 */
- (void)optionSelected:(NSDictionary *)userInfo;

@end

@interface MSActionView : UIView

extern NSString * const MSOptionUserInfoTarget;
extern NSString * const MSOptionUserInfoIndex;
extern NSString * const MSOptionUserInfoTitle;

@property (nonatomic, weak) id<MSActionViewDelegate> delegate;

- (instancetype)initWithTitle:(NSString *)title cancelButtonTitle:(NSString *)cancelButtonTitle andOtherButtonTitles:(NSArray *)otherButtonTitles;

- (void)addButtonWithTitle:(NSString *)buttonTitle andTapActionBlock:(TapActionBlock)tapActionBlock;

- (void)show;

@end
