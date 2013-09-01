//
//  OCTURITemplateTransformer.m
//  OctoKit
//
//  Created by Josh Vera on 8/31/13.
//  Copyright (c) 2013 GitHub. All rights reserved.
//

#import "OCTURITemplateTransformer.h"
#import <CSURITemplate/CSURITemplate.h>

NSString * const OCTURITemplateValueTransformerName = @"OCTURITemplateValueTransformerName";

@implementation OCTURITemplateTransformer

+ (void)load {
	@autoreleasepool {
		OCTURITemplateTransformer *transformer = [[OCTURITemplateTransformer alloc] init];
		[NSValueTransformer setValueTransformer:transformer forName:OCTURITemplateValueTransformerName];
	}
}

+ (BOOL)allowsReverseTransformation {
	return YES;
}

+ (Class)transformedValueClass {
	return [CSURITemplate class];
}

- (CSURITemplate *)transformedValue:(NSString *)value {
	return [CSURITemplate URITemplateWithString:value error:NULL];
}

- (NSString *)reverseTransformedValue:(CSURITemplate *)template {
	return template.templateString;
}

@end
