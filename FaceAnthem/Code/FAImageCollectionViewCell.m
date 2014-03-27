//
//  FAImageCollectionViewCell.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/26/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAImageCollectionViewCell.h"

@interface FAImageCollectionViewCell ()

@property (nonatomic, strong) UIImageView *internalImageView;

@end

@implementation FAImageCollectionViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupCell];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupCell];
}

- (void)setupCell
{
    self.internalImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    [self.contentView addSubview:self.internalImageView];
    
    UIButton *deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [deleteButton setBackgroundColor:[UIColor clearColor]];
    [deleteButton setTitle:@"X" forState:UIControlStateNormal];
    deleteButton.frame = CGRectMake(0,0,30,30);
    [deleteButton addTarget:self action:@selector(deletePressed:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deleteButton];
}

- (void)deletePressed:(id)sender
{
    [self.delegate didPressDeleteOnImageCollectionViewCell:self];
}

- (void)setImage:(UIImage *)image
{
    self.internalImageView.image = image;
}


@end
