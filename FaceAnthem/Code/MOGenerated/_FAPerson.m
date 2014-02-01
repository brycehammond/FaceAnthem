// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FAPerson.m instead.

#import "_FAPerson.h"

const struct FAPersonAttributes FAPersonAttributes = {
	.name = @"name",
	.recognitionIdentifier = @"recognitionIdentifier",
	.thumbnailData = @"thumbnailData",
};

const struct FAPersonRelationships FAPersonRelationships = {
};

const struct FAPersonFetchedProperties FAPersonFetchedProperties = {
};

@implementation FAPersonID
@end

@implementation _FAPerson

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FAPerson" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FAPerson";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FAPerson" inManagedObjectContext:moc_];
}

- (FAPersonID*)objectID {
	return (FAPersonID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"recognitionIdentifierValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"recognitionIdentifier"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}




@dynamic name;






@dynamic recognitionIdentifier;



- (int32_t)recognitionIdentifierValue {
	NSNumber *result = [self recognitionIdentifier];
	return [result intValue];
}

- (void)setRecognitionIdentifierValue:(int32_t)value_ {
	[self setRecognitionIdentifier:[NSNumber numberWithInt:value_]];
}

- (int32_t)primitiveRecognitionIdentifierValue {
	NSNumber *result = [self primitiveRecognitionIdentifier];
	return [result intValue];
}

- (void)setPrimitiveRecognitionIdentifierValue:(int32_t)value_ {
	[self setPrimitiveRecognitionIdentifier:[NSNumber numberWithInt:value_]];
}





@dynamic thumbnailData;











@end
