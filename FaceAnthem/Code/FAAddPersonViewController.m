//
//  FAAddPersonViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 3/1/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAAddPersonViewController.h"
#import "FAPerson.h"

@interface FAAddPersonViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;

@end

@implementation FAAddPersonViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self setupController];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self setupController];
}

- (void)setupController
{
    self.personPictures = [[NSMutableArray alloc] init];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender
{
    [self.personPictures makeObjectsPerformSelector:@selector(MR_deleteEntity)]; //delete any pictures we may have taken
    [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveOnlySelfAndWait];
    [self.delegate didCancelAddPersonViewController:self];
}

- (IBAction)save:(id)sender
{
    if(self.nameTextField.text.length > 0)
    {
        FAPerson *person = [FAPerson MR_createEntity];
        person.name = self.nameTextField.text;
        person.pictures = [NSSet setWithArray:self.personPictures];
        
        if([FAPerson MR_hasAtLeastOneEntity])
        {
            FAPerson *lastPerson = [FAPerson MR_findFirstOrderedByAttribute:@"recognitionIdentifier" ascending:NO];
            person.recognitionIdentifier = @(lastPerson.recognitionIdentifierValue + 1); //add 1 to the last recognition identifier
        }
        else
        {
            person.recognitionIdentifier = @1;
        }
        
        [[NSManagedObjectContext MR_contextForCurrentThread] MR_saveOnlySelfAndWait];
        [self.delegate addPersonViewController:self didAddPerson:person];
    }
    else
    {
        [[[UIAlertView alloc] initWithTitle:@"Person Needs Name" message:@"The new person must have a name" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }
}

@end
