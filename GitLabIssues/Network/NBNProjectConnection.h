//
//  NBNProjectConnection.h
//  GitLabIssues
//
//  Created by Piet Brauer on 16.12.12.
//  Copyright (c) 2012 nerdishbynature. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Project.h"
#import "Domain.h"
#import "Session.h"

@interface NBNProjectConnection : NSObject

+ (NBNProjectConnection *) sharedConnection;

/**
  Loads all project for the specified domain object.
 @param domain The domain object
 @param block The completion Block which is called on success
 @see https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/projects.md#list-projects
 */
-(void)loadProjectsForDomain:(Domain *)domain onSuccess:(void (^)(void))block;

-(void)cancelProjectsConnection;

-(void)loadMembersForProject:(Project *)project onSuccess:(void (^)(void))block;

-(void)cancelMembersConnection;

@end
