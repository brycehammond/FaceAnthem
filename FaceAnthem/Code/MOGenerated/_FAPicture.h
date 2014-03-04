// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FAPicture.h instead.

#import <CoreData/CoreData.h>


extern const struct FAPictureAttributes {
	__unsafe_unretained NSString *imageData;
	__unsafe_unretained NSString *standardizedImageData;
} FAPictureAttributes;

extern const struct FAPictureRelationships {
	__unsafe_unretained NSString *person;
} FAPictureRelationships;

extern const struct FAPictureFetchedProperties {
} FAPictureFetchedProperties;

@class FAPerson;




@interface FAPictureID : NSManagedObjectID {}
@end

@interface _FAPicture : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FAPictureID*)objectID;





@property (nonatomic, strong) NSData* imageData;



//- (BOOL)validateImageData:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* standardizedImageData;



//- (BOOL)validateStandardizedImageData:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) FAPerson *person;

//- (BOOL)validatePerson:(id*)value_ error:(NSError**)error_;





@end

@interface _FAPicture (CoreDataGeneratedAccessors)

@end

@interface _FAPicture (CoreDataGeneratedPrimitiveAccessors)


- (NSData*)primitiveImageData;
- (void)setPrimitiveImageData:(NSData*)value;




- (NSData*)primitiveStandardizedImageData;
- (void)setPrimitiveStandardizedImageData:(NSData*)value;





- (FAPerson*)primitivePerson;
- (void)setPrimitivePerson:(FAPerson*)value;


@end
