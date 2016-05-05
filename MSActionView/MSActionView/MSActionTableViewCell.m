//
//  MSActionTableViewCell.m
//  MSActionView
//
//  Created by mesird on 5/6/16.
//  Copyright © 2016 mesird. All rights reserved.
//

#import "MSActionTableViewCell.h"

@implementation MSActionTableViewCell

- (void)awakeFromNib {
    NSLog(@"awake");
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    NSLog(@"coder");
    return [super initWithCoder:aDecoder];
}


@end
