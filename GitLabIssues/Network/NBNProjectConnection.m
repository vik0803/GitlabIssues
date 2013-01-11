//
//  NBNProjectConnection.m
//  GitLabIssues
//
//  Created by Piet Brauer on 16.12.12.
//  Copyright (c) 2012 nerdishbynature. All rights reserved.
//

#import "NBNProjectConnection.h"
#import "User.h"
#import "NBNGitlabEngine.h"

@interface NBNProjectConnection ()

@property (nonatomic, retain) NBNGitlabEngine *projectConnection;
@property (nonatomic, retain) NBNGitlabEngine *membersConnection;

@end

static NBNProjectConnection* sharedConnection = nil;

@implementation NBNProjectConnection
@synthesize projectConnection;
@synthesize membersConnection;

+ (NBNProjectConnection *) sharedConnection {
    
    @synchronized(self){
        
        if (sharedConnection == nil){
            sharedConnection = [[self alloc] init];
        }
    }
    
    return sharedConnection;
}

-(void)loadProjectsForDomain:(Domain *)domain onSuccess:(void (^)(void))block{
    
    [Session getCurrentSessionWithCompletion:^(Session *session) {        
        
        self.projectConnection = [[NBNGitlabEngine alloc] init];
        [self.projectConnection requestWithURL:[NSString stringWithFormat:@"%@://%@/api/v3/projects?private_token=%@", domain.protocol, domain.domain, session.private_token] completionHandler:^(MKNetworkOperation *request) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
            
            for (NSDictionary *dict in array) {
                
                NSPredicate *projectFinder = [NSPredicate predicateWithFormat:@"identifier = %i", [[dict objectForKey:@"id"] integerValue]]; // 1 domain means no conflicts
                
                if ([[Project MR_findAllWithPredicate:projectFinder] count] == 0) { // new Project
                    [Project createAndParseJSON:dict];
                } else if ([[Project MR_findAllWithPredicate:projectFinder] count] == 1){ // update Project
                    Project *project = [[[[[NSManagedObjectContext defaultContext] ofType:@"Project"] where:@"identifier == %i", [[dict objectForKey:@"id"] integerValue]] toArray] objectAtIndex:0];
                    [project parseServerResponseWithDict:dict];
                }
            }
            
            block();
        } errorHandler:^(NSError *error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:error.localizedFailureReason message:error.localizedDescription delegate:nil cancelButtonTitle:@"Dimiss" otherButtonTitles:nil];
            [alert show];
        }];
    }];
}

-(void)cancelProjectsConnection{
    [self.projectConnection cancel];
}

-(void)loadMembersForProject:(Project *)project onSuccess:(void (^)(void))block{
    Domain *domain = [[Domain findAll] objectAtIndex:0];

    [Session getCurrentSessionWithCompletion:^(Session *session) {
        
        self.membersConnection = [[NBNGitlabEngine alloc] init];
        [self.membersConnection requestWithURL:[NSString stringWithFormat:@"%@://%@/api/v3/projects/%@/members?private_token=%@", domain.protocol, domain.domain, project.identifier, session.private_token] completionHandler:^(MKNetworkOperation *request) {
            NSArray *array = [NSJSONSerialization JSONObjectWithData:[request responseData] options:kNilOptions error:nil];
            
            for (NSDictionary *dict in array) {
                
                NSPredicate *userFinder = [NSPredicate predicateWithFormat:@"identifier = %i", [[dict objectForKey:@"id"] integerValue]]; // 1 domain means no conflicts
                
                if ([[User MR_findAllWithPredicate:userFinder] count] == 0) {
                    [User createAndParseJSON:dict];
                }
            }
            
            block();
        } errorHandler:^(NSError *error) {
            PBLog(@"err %@", error);
        }];
    }];
}

-(void)cancelMembersConnection{
    [self.membersConnection cancel];
}

@end
