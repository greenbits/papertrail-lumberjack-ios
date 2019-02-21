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

@end
