//
//  FAAddPersonViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/28/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAEditPersonViewController.h"
#import "FAPerson.h"

@interface FAEditPersonViewController ()
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation FAEditPersonViewController

@synthesize person = _person;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.nameTextField.text = self.person.name;

}

- (void)setPerson:(FAPerson *)person
{
    _person = person;
    self.personPictures = self.person.pictures.allObjects.mutableCopy;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.person.name = self.nameTextField.text;
    self.person.pictures = [NSSet setWithArray:self.personPictures];
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveToPersistentStoreAndWait];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField == self.nameTextField)
    {
        NSString *inputText = [textField.text stringByReplacingCharactersInRange:range withString:string];
        self.navigationItem.hidesBackButton = (inputText.length <= 0); //Only enable back button if we have text in the name field
    }
    return YES;
}


@end
