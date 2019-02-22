//
//  RMDataDogFormatter.m
//

#import "RMDataDogFormatter.h"

@implementation RMDataDogFormatter {
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

    NSString *file = [[logMessage.file lastPathComponent] stringByDeletingPathExtension];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *timestamp = [dateFormatter stringFromDate:logMessage.timestamp];

    NSMutableDictionary *json = [@{} mutableCopy];

    NSString *function = [NSString stringWithFormat:@"%@ %@@%@@%lu", logMessage.threadID, file,
                          logMessage.function, (unsigned long)logMessage.line];

    [json setObject:logLevel forKey:@"logLevel"];
    [json setObject:timestamp forKey:@"timestamp"];
    [json setObject:function forKey:@"function"];
    [json setObject:msg forKey:@"message"];
    [json setObject:self.machineName forKey:@"hostname"];
    [json setObject:self.programName forKey:@"service"];
    [json setObject:file forKey:@"ddsource"];
    [json setObject:[self tagsString] forKey:@"ddtags"];

    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:json
                                                       options:0
                                                         error:&error];

    NSString *log;
    if (!jsonData) {
        NSLog(@"%s: error: %@", __func__, error.localizedDescription);
        log = @"{}";
    } else {
        log = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }

    return [NSString stringWithFormat:@"%@ %@", self.apiKey, log];
}

- (NSString *)tagsString {
    NSMutableArray *tags = [@[] mutableCopy];

    [self.tags enumerateKeysAndObjectsUsingBlock:^(NSString *key, NSString *value, BOOL * _Nonnull stop) {
        NSString *tag = [NSString stringWithFormat:@"%@:%@", key, value];
        [tags addObject:tag];
    }];

    return [tags componentsJoinedByString:@","];
}

- (void)setTags:(NSDictionary *)tags {
    _tags = [tags copy];
}

- (void)setApiKey:(NSString *)apiKey {
    _apiKey = [apiKey copy];
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
