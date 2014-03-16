//
//  FAAddPersonViewController.h
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/28/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAPersonBaseViewController.h"

@class FAPerson;

@interface FAEditPersonViewController : FAPersonBaseViewController <UITextFieldDelegate>

@property (nonatomic, strong) FAPerson *person;

@end
