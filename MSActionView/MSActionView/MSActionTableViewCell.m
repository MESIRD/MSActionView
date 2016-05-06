//
//  MSActionTableViewCell.m
//  MSActionView
//
//  Created by mesird on 5/6/16.
//  Copyright © 2016 mesird. All rights reserved.
//



#import "MSActionTableViewCell.h"
#import "PrefixHeader.pch"

@implementation MSActionTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if ( self) {
        _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45.0f)];
        _titleLabel.textColor = COLOR_OF_RGBA(55.0f, 55.0f, 55.0f, 1.0f);
        _titleLabel.font = SYSTEM_FONT(15.0f);
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
        
        UIView *separatorLine = [[UIView alloc] initWithFrame:CGRectMake(0, 44.0f, SCREEN_WIDTH, 1.0f)];
        separatorLine.backgroundColor = COLOR_OF_RGBA(231.0f, 231.0f, 231.0f, 1.0f);
        [self addSubview:separatorLine];
    }
    return self;
}

- (void)setSelected:(BOOL)selected {
    
    [super setSelected:selected];
}


@end
