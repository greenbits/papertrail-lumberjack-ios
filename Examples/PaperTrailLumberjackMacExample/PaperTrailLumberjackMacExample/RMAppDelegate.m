//
//  RMAppDelegate.m
//  PaperTrailLumberjackMacExample
//
//  Created by Malayil Philip George on 5/8/14.
//  Copyright (c) 2014 Rogue Monkey Technologies & Systems Private Limited. All rights reserved.
//

#import "RMAppDelegate.h"

#import <RMPaperTrailLogger.h>

const int ddLogLevel = LOG_LEVEL_VERBOSE;

@implementation RMAppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
    // Insert code here to initialize your application
    RMPaperTrailLogger *paperTrailLogger = [RMPaperTrailLogger sharedInstance];
    paperTrailLogger.host = @"logs.papertrailapp.com";
    paperTrailLogger.port = 13619;
    paperTrailLogger.useTcp = NO;
//    paperTrailLogger.useTLS = NO;
    
    [DDLog addLogger:paperTrailLogger];
    
    DDLogVerbose(@"");
    DDLogVerbose(@"Verbose Logging");
    DDLogInfo(@"Info Logging");
    DDLogDebug(@"Debug Logging");
    DDLogWarn(@"Warn Logging");
    DDLogError(@"Error Logging");
}

@end
