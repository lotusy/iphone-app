//
//  Business+Extensions.h
//  LotusyApp
//
//  Created by Allen on 2015-04-30.
//  Copyright (c) 2015 Cold Yam. All rights reserved.
//

#import "Business.h"

typedef void(^BusinessCompletionBlock)(Business *business);

@interface Business (Extensions)
+ (void)newBusinessData:(NSDictionary *)dictionary
      completionHandler:(BusinessCompletionBlock)completion;
@end
