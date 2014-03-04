// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FAPicture.m instead.

#import "_FAPicture.h"

const struct FAPictureAttributes FAPictureAttributes = {
	.imageData = @"imageData",
	.standardizedImageData = @"standardizedImageData",
};

const struct FAPictureRelationships FAPictureRelationships = {
	.person = @"person",
};

const struct FAPictureFetchedProperties FAPictureFetchedProperties = {
};

@implementation FAPictureID
@end

@implementation _FAPicture

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"FAPicture" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"FAPicture";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"FAPicture" inManagedObjectContext:moc_];
}

- (FAPictureID*)objectID {
	return (FAPictureID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic imageData;






@dynamic standardizedImageData;






@dynamic person;

	






@end
