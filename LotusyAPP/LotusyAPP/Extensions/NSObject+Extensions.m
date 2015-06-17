//
//  NSObject+Extensions.m
//  LotusyApp
//
//  Created by Allen on 2015-04-30.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "NSObject+Extensions.h"
#import "Business.h"

@implementation NSObject (Extensions)

- (BOOL)isNonNilString {
    
    if (self == nil) {
        return NO;
    }
    
    if ([self isKindOfClass:Nil]) {
        return NO;
    }
    
    return [self isKindOfClass:[NSString class]] ? YES : NO;

}

- (BOOL)isNonNilNumber {
    
    if (self == nil) {
        return NO;
    }
    
    if ([self isKindOfClass:Nil]) {
        return NO;
    }
    
    return [self isKindOfClass:[NSNumber class]] ? YES : NO;

}

- (BOOL)isNonNilDictionary {
    
    if (self == nil) {
        return NO;
    }
    
    if ([self isKindOfClass:Nil]) {
        return NO;
    }
    
    return [self isKindOfClass:[NSDictionary class]] ? YES : NO;
    
}

- (BOOL)isNonNilBusiness {
    
    if (self == nil) {
        return NO;
    }
    
    if ([self isKindOfClass:Nil]) {
        return NO;
    }
    
    return [self isKindOfClass:[Business class]] ? YES : NO;
    
}

@end
