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

@interface FAPersonBaseViewController : UIViewController <FAAddPhotosViewControllerDelegate>


@property (nonatomic, strong) FAPerson *person;
@property (nonatomic, strong) NSMutableArray *personPictures;

@end
