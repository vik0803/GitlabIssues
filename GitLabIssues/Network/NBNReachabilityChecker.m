//
//  NBNReachabilityChecker.m
//  GitLabIssues
//
//  Created by Piet Brauer on 11.01.13.
//  Copyright (c) 2013 nerdishbynature. All rights reserved.
//

#import "NBNReachabilityChecker.h"
#import "Reachability.h"

static NBNReachabilityChecker *sharedChecker = nil;

@interface NBNReachabilityChecker ()

@property (nonatomic, retain) NSDate *lastShown;

@end

@implementation NBNReachabilityChecker
@synthesize lastShown;

+ (NBNReachabilityChecker *) sharedChecker {
    
    @synchronized(self){
        
        if (sharedChecker == nil){
            sharedChecker = [[self alloc] init];
        }
    }
    
    return sharedChecker;
}

-(id)init{
    self = [super init];
    if (self) {
        self.lastShown = [NSDate dateWithTimeIntervalSince1970:0]; // set to really old date
    }
    
    return self;
}

-(BOOL)isReachable{
    Reachability *r = [Reachability reachabilityForInternetConnection];
    
    NetworkStatus internetStatus = [r currentReachabilityStatus];
    if(internetStatus == NotReachable) {
        
        NSTimeInterval interval = [[NSDate date] timeIntervalSinceDate:self.lastShown];
        if (interval > 15) { // more than 15s ago -> show AlertView
            UIAlertView *alert = [[[UIAlertView alloc] initWithTitle:@"" message:@"Your internet connection appears to be offline, reconnect and try again." delegate:nil cancelButtonTitle:@"Dismiss" otherButtonTitles:nil] autorelease];
            [alert show];
        }
        
        return NO;
    }
    return YES;
}

-(void)dealloc{
    self.lastShown = nil;
    
    [lastShown release];
    [super dealloc];
}

@end
