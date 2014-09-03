//
// Created by Ian Dundas on 20/08/2014.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <ReactiveCocoa/ReactiveCocoa/RACSignal.h>
#import "ScheduleImporter.h"
#import "RACSignal.h"
#import "NSURLConnection+RACSupport.h"
#import "RACSignal+Operations.h"
#import "RACScheduler.h"
#import "RACTuple.h"
#import "RACSequence.h"
#import "NSArray+RACSequenceAdditions.h"
#import "Programme.h"
#import <libextobjc/EXTScope.h>

// private interface:
@interface ScheduleImporter ()
@end

@implementation ScheduleImporter

+(RACSignal*)importProgrammes {
    NSMutableURLRequest *request = [NSMutableURLRequest
        requestWithURL:[NSURL
            URLWithString:@"http://www.bbc.co.uk/radio4/programmes/schedules/fm/today.json"]
    ];
    [request setHTTPMethod:@"GET"];

    return [[[[[[[[NSURLConnection rac_sendAsynchronousRequest:request
    ] logNext
    ] reduceEach:^id (NSURLResponse *response, NSData *data) {
        return data;
    }] deliverOn:[RACScheduler mainThreadScheduler]
    ] map:^id (NSData *data) {
        id results = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        return results;
    }] map:^id (id json) {
        return json[@"schedule"][@"day"][@"broadcasts"];
    }] map:^id (NSArray *broadcasts) {
        return [broadcasts valueForKeyPath:@"programme"];
    }] map:^id (NSArray *programmes) {

        return [programmes.rac_sequence map:^id (NSDictionary *programmeDictionary) {
            Programme *model = [Programme new];

            [self configurePhotoModel:model withDictionary:programmeDictionary];
            return model;
        }].array;
    }];

}

+ (void)configurePhotoModel:(Programme *)programme withDictionary:(NSDictionary *)dictionary {
    programme.name = dictionary[@"display_titles"][@"title"];
    programme.type = dictionary[@"type"];
}

@end