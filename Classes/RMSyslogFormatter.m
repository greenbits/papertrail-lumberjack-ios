//
//  RMSyslogFormatter.m
//  Pods
//
//  Created by Malayil Philip George on 5/7/14.
//  Copyright (c) 2014 Rogue Monkey Technologies & Systems Private Limited. All rights reserved.
//
//

#import "RMSyslogFormatter.h"

@implementation RMSyslogFormatter

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *msg = logMessage->logMsg;
    
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR     : logLevel = @"11"; break;
        case LOG_FLAG_WARN      : logLevel = @"12"; break;
        case LOG_FLAG_INFO      : logLevel = @"14"; break;
        case LOG_FLAG_DEBUG     : logLevel = @"15"; break;
        case LOG_FLAG_VERBOSE   : logLevel = @"15" ; break;
        default                 : logLevel = @"15"; break;
    }
    
    //Also display the file the logging occurred in to ease later debugging
    NSString *file = [[[NSString stringWithUTF8String:logMessage->file] lastPathComponent] stringByDeletingPathExtension];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MMM dd HH:mm:ss"];
    [dateFormatter setTimeZone:[NSTimeZone systemTimeZone]];
    NSString *timestamp = [dateFormatter stringFromDate:logMessage->timestamp];
    
    //Get vendor id
    NSString *vendorId = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    
    //Get app name
    NSString *appName = [[[NSBundle mainBundle] localizedInfoDictionary] objectForKey:@"CFBundleDisplayName"];
    if (appName == nil) {
        appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
    }
    
    //Remove all whitespace characters from appname
    if (appName != nil) {
        NSArray *components = [appName componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        appName = [components componentsJoinedByString:@""];
    }
    
    NSString *log = [NSString stringWithFormat:@"<%@>%@ %@ %@: %x %@@%s@%i \"%@\"", logLevel, timestamp, vendorId, appName, logMessage->machThreadID, file, logMessage->function, logMessage->lineNumber, msg];
    
    return log;
}


@end
