//
//  FAPersonBaseViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/15/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FAAddPhotosViewController.h"

@class FAPerson;

@interface FAPersonBaseViewController : UIViewController <FAAddPhotosViewControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (nonatomic, weak) IBOutlet UICollectionView *picturesCollectionView;
@property (nonatomic, strong) FAPerson *person;
@property (nonatomic, strong) NSMutableArray *personPictures;

@end
