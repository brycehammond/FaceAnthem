//
//  FAImageCollectionViewCell.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/26/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FAImageCollectionViewCell;

@protocol FAImageCollectionViewCellDelegate <NSObject>

- (void)didPressDeleteOnImageCollectionViewCell:(FAImageCollectionViewCell *)cell;

@end

@interface FAImageCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) id<FAImageCollectionViewCellDelegate> delegate;

- (void)setImage:(UIImage *)image;

@end
