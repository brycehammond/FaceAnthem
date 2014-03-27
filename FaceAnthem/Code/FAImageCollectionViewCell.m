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
}

- (void)setImage:(UIImage *)image
{
    self.internalImageView.image = image;
}


@end
