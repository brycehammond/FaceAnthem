// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FAPerson.h instead.

#import <CoreData/CoreData.h>


extern const struct FAPersonAttributes {
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *recognitionIdentifier;
	__unsafe_unretained NSString *thumbnailData;
} FAPersonAttributes;

extern const struct FAPersonRelationships {
} FAPersonRelationships;

extern const struct FAPersonFetchedProperties {
} FAPersonFetchedProperties;






@interface FAPersonID : NSManagedObjectID {}
@end

@interface _FAPerson : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FAPersonID*)objectID;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* recognitionIdentifier;



@property int32_t recognitionIdentifierValue;
- (int32_t)recognitionIdentifierValue;
- (void)setRecognitionIdentifierValue:(int32_t)value_;

//- (BOOL)validateRecognitionIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSData* thumbnailData;



//- (BOOL)validateThumbnailData:(id*)value_ error:(NSError**)error_;






@end

@interface _FAPerson (CoreDataGeneratedAccessors)

@end

@interface _FAPerson (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveRecognitionIdentifier;
- (void)setPrimitiveRecognitionIdentifier:(NSNumber*)value;

- (int32_t)primitiveRecognitionIdentifierValue;
- (void)setPrimitiveRecognitionIdentifierValue:(int32_t)value_;




- (NSData*)primitiveThumbnailData;
- (void)setPrimitiveThumbnailData:(NSData*)value;




@end
