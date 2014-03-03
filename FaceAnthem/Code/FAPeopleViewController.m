//
//  FAPeopleViewController.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/28/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAPeopleViewController.h"
#import "FAPerson.h"
#import "FAPersonCell.h"

@interface FAPeopleViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *people;

@end

@implementation FAPeopleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.people = [FAPerson MR_findAllSortedBy:@"name" ascending:YES];
    [self.tableView reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)donePressed:(id)sender
{
    [self.delegate didDismissPeopleViewController:self];
}

#pragma mark -
#pragma mark UITableViewDelegate / DataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.people.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FAPerson *person = self.people[indexPath.row];
    FAPersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCell"];
    [cell setPerson:person];
    return cell;
}

#pragma mark -
#pragma mark Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"AddPerson"])
    {
        FAAddPersonViewController *addPersonController = segue.destinationViewController;
        addPersonController.delegate = self;
    }
}

#pragma mark -
#pragma mark FAAddPErsonViewControllerDelegate

- (void)didCancelAddPersonViewController:(FAAddPersonViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addPersonViewController:(FAAddPersonViewController *)controller didAddPerson:(FAPerson *)person
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
