//
//  NBNIssueFilterViewController.h
//  GitLabIssues
//
//  Created by Piet Brauer on 17.12.12.
//  Copyright (c) 2012 nerdishbynature. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NBNMilestonesListViewController.h"
#import "NBNFilterComponentsCell.h"
#import "NBNFilterAssigneeCell.h"
#import "NBNFilterStatusCell.h"
#import "NBNFilterSortCell.h"
#import "Project.h"
#import "Filter.h"
#import "NBNMilestonesListViewController.h"
#import "NBNAssigneeListViewController.h"

extern NSString *const kKeyAssignedFilter;
extern NSString *const kKeyMilestoneFilter;
extern NSString *const kKeyLabelsFilter;
extern NSString *const kKeyIssueStatusFilter;
extern NSString *const kKeySortIssuesFilter;

@protocol NBNIssueFilterDelegate <NSObject>

/**
 Used to tell the associated view controller which filter to apply
 @param _filter the Filter object used to apply the settings
 */
-(void)applyFilter:(Filter *)_filter;

@end

@interface NBNIssueFilterViewController : UITableViewController <NBNMilestoneListDelegate, NBNFilterStatusCellDelegate, NBNFilterSortCellDelegate, NBNMilestoneListDelegate, NBNAssigneeListDelegate, NBNFilterComponentsCellDelegate, NBNFilterAssigneeCellDelegate>

/**
  Used to tell the associated view controller which filter to apply
 */
@property (nonatomic, weak) id<NBNIssueFilterDelegate> delegate;

/**
  Project used fot this ViewController
 */
@property (nonatomic, strong) Project *project;

/**
 This is used to allocate and initialize the view controller using a Filter object
 @param _filter the Filter object used to initialize the view controller
 */
+(NBNIssueFilterViewController *)loadViewControllerWithFilter:(Filter *)_filter;

@end
