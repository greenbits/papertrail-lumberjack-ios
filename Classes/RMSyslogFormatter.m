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

@implementation RMSyslogFormatter {
    NSString *_programName;
    NSString *_machineName;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *msg = logMessage.message;
    
    NSString *logLevel;
    switch (logMessage.flag) {
        case DDLogFlagError     : logLevel = @"11"; break;
        case DDLogFlagWarning   : logLevel = @"12"; break;
        case DDLogFlagInfo      : logLevel = @"14"; break;
        case DDLogFlagDebug     : logLevel = @"15"; break;
        case DDLogFlagVerbose   : logLevel = @"15"; break;
        default                 : logLevel = @"15"; break;
    }
    
    // Also display the file the logging occurred in to ease later debugging
    NSString *file = [[logMessage.file lastPathComponent] stringByDeletingPathExtension];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *timestamp = [dateFormatter stringFromDate:logMessage.timestamp];
    
    NSString *log = [NSString stringWithFormat:@"<%@>%@ %@ %@: %@ %@@%@@%lu \"%@\"", logLevel,
                     timestamp, self.machineName, self.programName, logMessage.threadID, file,
                     logMessage.function, (unsigned long)logMessage.line, msg];
    
    return log;
}

- (NSString *)machineName {
    if (_machineName) {
        return _machineName;
    }

    return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
}

- (void)setMachineName:(NSString *)machineName {
    _machineName = [machineName copy];
}

- (NSString *)programName {
    if (_programName) {
        return _programName;
    }

    NSString *appName = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"];
    NSString *version = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    NSString *build = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleVersion"];

    return [@[appName, version, build] componentsJoinedByString:@"-"];
}

- (void)setProgramName:(NSString *)programName {
    _programName = [programName copy];
}

@end
