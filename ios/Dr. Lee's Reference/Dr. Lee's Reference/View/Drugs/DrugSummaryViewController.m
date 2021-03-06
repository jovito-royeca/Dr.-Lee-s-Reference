//
//  DrugSummaryViewController.m
//  Dr. Lee's Reference
//
//  Created by Jovito Royeca on 11/27/13.
//  Copyright (c) 2013 Jovito Royeca. All rights reserved.
//

#import "DrugSummaryViewController.h"

@interface DrugSummaryViewController ()

@property(strong,nonatomic) NSArray *sections;

@end

@implementation DrugSummaryViewController

@synthesize sections = _sections;
@synthesize tblDrug = _tblDrug;
@synthesize drugSummary = _drugSummary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        // Custom initialization
        [self setTitle:@"Summary"];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    self.sections = [NSArray arrayWithObjects:@"Overview", @"Forms and Strengths", @"Applications", nil];
    
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height);
    self.tblDrug = [[UITableView alloc] initWithFrame:frame style:UITableViewStyleGrouped];
    self.tblDrug.delegate = self;
    self.tblDrug.dataSource = self;
    
//    UIBarButtonItem *btnBack = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:nil action:nil];
    
    [self.view addSubview:self.tblDrug];
//    self.navigationController.navigationItem.backBarButtonItem = btnBack;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITABleViewDataSource
//- (NSArray*) sectionIndexTitlesForTableView:(UITableView *)tableView
//{
//    return sections;
//}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString*)title atIndex:(NSInteger)index
{
    return [self.sections indexOfObject:title];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.sections count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int rows = 0;
    
    switch (section)
    {
        case 0:
        {
            rows = 2;
            break;
        }
        case 1:
        {
            rows = [[self.drugSummary objectForKey:@"Forms and Strengths"] count];
            break;
        }
        case 2:
        {
            rows = [[self.drugSummary objectForKey:@"Details"] count];
            break;
        }
    }
    
    return rows;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.sections objectAtIndex:section];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2)
    {
        NSArray *arrDetails = [self.drugSummary objectForKey:@"Details"];
    
        if (arrDetails)
        {
            id drugDetails = [arrDetails objectAtIndex:indexPath.row];
        
            if (drugDetails && [drugDetails isKindOfClass:[NSDictionary class]])
            {
                DrugDetailsViewController *detailsVC = [[DrugDetailsViewController alloc] init];
                detailsVC.drugDetails = drugDetails;
    
                [self.navigationController pushViewController:detailsVC animated:YES];
            }
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section)
    {
        case 0:
        {
            switch (indexPath.row)
            {
                case 0:
                {
                    cell.textLabel.text = @"Drug Name";
                    cell.detailTextLabel.text = [self.drugSummary objectForKey:@"Drug Name"];
                    break;
                }
                case 1:
                {
                    cell.textLabel.text = @"Active Ingredient(s)";
                    cell.detailTextLabel.text = [self.drugSummary objectForKey:@"Active Ingredient(s)"];
                    break;
                }
            }
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        }
        case 1:
        {
            NSArray *arrForms = [self.drugSummary objectForKey:@"Forms and Strengths"];
//            NSMutableArray *allKeys = [[NSMutableArray alloc] init];
//            for (NSDictionary *dict in arrForms)
//            {
//                [allKeys addObject:[[dict allKeys] objectAtIndex:0]];
//            }
//            NSArray *sortedKeys = [sortedKeys sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
            
            NSDictionary *dictForms = [arrForms objectAtIndex:indexPath.row];
            NSString *key = [[dictForms allKeys] objectAtIndex:0];
            
            cell.textLabel.text = key;
            cell.detailTextLabel.text = [JJJUtil arrayToString:[dictForms valueForKey:key]];
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        }
        case 2:
        {
            NSArray *arrDetails = [self.drugSummary objectForKey:@"Details"];
            NSDictionary *dict = [arrDetails objectAtIndex:indexPath.row];
            
            cell.textLabel.text = [dict objectForKey:@"ApplNo"];
            cell.detailTextLabel.text = [dict objectForKey:@"Company"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
    }
    
    return cell;
}

@end
