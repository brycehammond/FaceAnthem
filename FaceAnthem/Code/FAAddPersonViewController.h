//
//  FAAddPersonViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/1/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FAAddPersonViewController;
@class FAPerson;

@protocol FAAddPersonViewControllerDelegate <NSObject>

- (void)didCancelAddPersonViewController:(FAAddPersonViewController *)controller;
- (void)addPersonViewController:(FAAddPersonViewController *)controller didAddPerson:(FAPerson *)person;

@end

@interface FAAddPersonViewController : UIViewController

@property (nonatomic, weak) id<FAAddPersonViewControllerDelegate> delegate;

@end
