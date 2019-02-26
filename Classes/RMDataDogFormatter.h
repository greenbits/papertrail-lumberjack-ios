//
//  RMDataDogFormatter.h
//

#import <Foundation/Foundation.h>
#import <CocoaLumberjack/CocoaLumberjack.h>

@interface RMDataDogFormatter : NSObject <DDLogFormatter>

@property (nonatomic, copy) NSString *apiKey;
@property (nonatomic, copy) NSString *programName;
@property (nonatomic, copy) NSString *machineName;
@property (nonatomic, copy) NSDictionary *tags;
@property (nonatomic, copy) NSDictionary *attributes;

- (void)addValue:(id)value forKeyToTags:(NSString *)key;
- (void)addValue:(id)value forKeyToAttributes:(NSString *)key;

@end
