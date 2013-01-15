//
//  NBNUsersConnection.h
//  GitLabIssues
//
//  Created by Piet Brauer on 18.12.12.
//  Copyright (c) 2012 nerdishbynature. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NBNUsersConnection : NSObject

+ (NBNUsersConnection *) sharedConnection;

- (void) cancelMembersRequest;

/**
 Loads all member for the specified project.
 @param projectID The gitlab project identifier
 @param block The completion block, which is called on success.
 @see https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/users.md#list-users
 */
-(void)loadMembersWithProjectID:(NSUInteger)project_id onSuccess:(void (^)(NSArray *array))block;

@end
