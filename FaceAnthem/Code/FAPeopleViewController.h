//
//  FAPeopleViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/28/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FAPeopleViewController;

@protocol FAPeopleViewControllerDelegate <NSObject>

- (void)didDismissPeopleViewController:(FAPeopleViewController *)peopleController;

@end

@interface FAPeopleViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<FAPeopleViewControllerDelegate> delegate;

@end
