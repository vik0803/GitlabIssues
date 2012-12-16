//
//  NBNProjectsViewController.m
//  GitLabIssues
//
//  Created by Piet Brauer on 16.12.12.
//  Copyright (c) 2012 nerdishbynature. All rights reserved.
//

#import "NBNProjectsViewController.h"
#import "Project.h"
#import "NBNProjectConnection.h"
#import "NBNIssuesViewController.h"

@interface NBNProjectsViewController ()

@property (nonatomic, retain) NSArray *projectsArray;

@end

@implementation NBNProjectsViewController
@synthesize projectsArray;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [NBNProjectConnection loadProjectsForDomain:[[Domain findAll] objectAtIndex:0] onSuccess:^{
        self.projectsArray = [Project findAllSortedBy:@"identifier" ascending:YES];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.projectsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    Project *project = [self.projectsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = project.name;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NBNIssuesViewController *issues = [NBNIssuesViewController loadWithProject:(Project *)[self.projectsArray objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:issues animated:YES];
    [issues release];
}

-(void)dealloc{
    self.projectsArray = nil;
    
    [projectsArray release];
    [super dealloc];
}


@end