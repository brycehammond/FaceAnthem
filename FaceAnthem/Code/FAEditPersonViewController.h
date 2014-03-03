//
//  FAAddPersonViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/28/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FAPerson;

@interface FAEditPersonViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, strong) FAPerson *person;

@end
