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

- (IBAction)addPressed:(id)sender
{
    
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

@end
