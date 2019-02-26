//
//  RMDataDogFormatter.m
//

#import "RMDataDogFormatter.h"

@implementation RMDataDogFormatter {
    NSString *_programName;
    NSString *_machineName;
}

- (id)init {
    self = [super init];
    if (self) {
        _tags = @{};
        _attributes = @{};
    }

    return self;
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage {
    NSString *msg = logMessage.message;
    
    NSString *logLevel;
    switch (logMessage.flag) {
        case DDLogFlagError     : logLevel = @"error"; break;
        case DDLogFlagWarning   : logLevel = @"warning"; break;
        case DDLogFlagInfo      : logLevel = @"info"; break;
        case DDLogFlagDebug     : logLevel = @"debug"; break;
        case DDLogFlagVerbose   : logLevel = @"verbose"; break;
        default                 : logLevel = @"verbose"; break;
    }

    NSString *file = [[logMessage.file lastPathComponent] stringByDeletingPathExtension];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    NSLocale *enUSPOSIXLocale = [NSLocale localeWithLocaleIdentifier:@"en_US_POSIX"];
    [dateFormatter setLocale:enUSPOSIXLocale];
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZZZZZ"];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
    NSString *timestamp = [dateFormatter stringFromDate:logMessage.timestamp];

    NSMutableDictionary *json = [self.attributes mutableCopy];

    NSString *function = [NSString stringWithFormat:@"%@@%@@%lu", file,
                          logMessage.function, (unsigned long)logMessage.line];

    [json setObject:logLevel forKey:@"status"];
    [json setObject:timestamp forKey:@"timestamp"];
    [json setObject:function forKey:@"function"];
    [json setObject:logMessage.threadID forKey:@"threadId"];
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

- (void)addTag:(NSString *)tag withValue:(id)value {
    NSMutableDictionary *newTags = [self.tags mutableCopy];
    [newTags setValue:value forKey:tag];

    self.tags = [newTags copy];
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

- (void)addAttribute:(NSString *)attribute withValue:(id)value {
    NSMutableDictionary *newAttributes = [self.attributes mutableCopy];
    [newAttributes setValue:value forKey:attribute];

    self.attributes = [newAttributes copy];
}

- (void)setAttributes:(NSDictionary *)attributes {
    _attributes = [attributes copy];
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
