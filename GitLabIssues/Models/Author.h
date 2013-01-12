//
//  Author.h
//  GitLabIssues
//
//  Created by Piet Brauer on 16.12.12.
//  Copyright (c) 2012 nerdishbynature. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Comment, Issue, MergeRequest, Note, Snippet;

@interface Author : NSManagedObject

@property (nonatomic, retain) NSNumber * blocked;
@property (nonatomic, retain) NSDate * created_at;
@property (nonatomic, retain) NSString * email;
@property (nonatomic, retain) NSNumber * identifier;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *issues;
@property (nonatomic, retain) MergeRequest *mergeRequests;
@property (nonatomic, retain) NSSet *notes;
@property (nonatomic, retain) Snippet *snippets;

/**
  This method is used for parsing the returned JSON from the API
 @param dict The JSON dictionary
 @return Initialized User object
 @see https://github.com/gitlabhq/gitlabhq/blob/master/doc/api/issues.md
 */
+(Author *)createAndParseJSON:(NSDictionary *)dict;

-(void)parseServerResonse:(NSDictionary *)dict;

@end

@interface Author (CoreDataGeneratedAccessors)

- (void)addIssuesObject:(Issue *)value;
- (void)removeIssuesObject:(Issue *)value;
- (void)addIssues:(NSSet *)values;
- (void)removeIssues:(NSSet *)values;

@end
