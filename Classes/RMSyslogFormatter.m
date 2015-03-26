//
//  RMSyslogFormatter.m
//  Pods
//
//  Created by Malayil Philip George on 5/7/14.
//  Copyright (c) 2014 Rogue Monkey Technologies & Systems Private Limited. All rights reserved.
//
//

#import "RMSyslogFormatter.h"

static NSString * const RMAppUUIDKey = @"RMAppUUIDKey";

@implementation RMSyslogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *msg = logMessage.message;
    
    NSString *logLevel;
    switch (logMessage.flag)
    {
        case LOG_FLAG_ERROR     : logLevel = @"11"; break;
        case LOG_FLAG_WARN      : logLevel = @"12"; break;
        case LOG_FLAG_INFO      : logLevel = @"14"; break;
        case LOG_FLAG_DEBUG     : logLevel = @"15"; break;
        case LOG_FLAG_VERBOSE   : logLevel = @"15" ; break;
        default                 : logLevel = @"15"; break;
    }
    
    //Also display the file the logging occurred in to ease later debugging
    NSString *file = [[logMessage.file lastPathComponent] stringByDeletingPathExtension];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *timestamp = [dateFormatter stringFromDate:logMessage.timestamp];
    
    //Get vendor id
    NSString *machineName = [self machineName];
    
    //Get program name
    NSString *programName = [self programName];
    
    NSString *log = [NSString stringWithFormat:@"<%@>%@ %@ %@: %x %@@%s@%i \"%@\"", logLevel, timestamp, machineName, programName, logMessage.threadID, file, logMessage.function, logMessage.line, msg];
    
    return log;
}

-(NSString *) machineName
{
    NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:kCFBundleExecutableKey];
    NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:kCFBundleVersionKey];

    return [@[appName, appVersion] componentsJoinedByString:@"-"];
}

-(NSString *) programName
{
    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

@end
