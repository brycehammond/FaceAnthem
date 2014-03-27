// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to FAPerson.h instead.

#import <CoreData/CoreData.h>


extern const struct FAPersonAttributes {
	__unsafe_unretained NSString *anthemLastPlayedAt;
	__unsafe_unretained NSString *name;
	__unsafe_unretained NSString *recognitionIdentifier;
	__unsafe_unretained NSString *songId;
} FAPersonAttributes;

extern const struct FAPersonRelationships {
	__unsafe_unretained NSString *pictures;
} FAPersonRelationships;

extern const struct FAPersonFetchedProperties {
} FAPersonFetchedProperties;

@class FAPicture;






@interface FAPersonID : NSManagedObjectID {}
@end

@interface _FAPerson : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (FAPersonID*)objectID;





@property (nonatomic, strong) NSDate* anthemLastPlayedAt;



//- (BOOL)validateAnthemLastPlayedAt:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* name;



//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* recognitionIdentifier;



@property int32_t recognitionIdentifierValue;
- (int32_t)recognitionIdentifierValue;
- (void)setRecognitionIdentifierValue:(int32_t)value_;

//- (BOOL)validateRecognitionIdentifier:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSNumber* songId;



@property int64_t songIdValue;
- (int64_t)songIdValue;
- (void)setSongIdValue:(int64_t)value_;

//- (BOOL)validateSongId:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSSet *pictures;

- (NSMutableSet*)picturesSet;





@end

@interface _FAPerson (CoreDataGeneratedAccessors)

- (void)addPictures:(NSSet*)value_;
- (void)removePictures:(NSSet*)value_;
- (void)addPicturesObject:(FAPicture*)value_;
- (void)removePicturesObject:(FAPicture*)value_;

@end

@interface _FAPerson (CoreDataGeneratedPrimitiveAccessors)


- (NSDate*)primitiveAnthemLastPlayedAt;
- (void)setPrimitiveAnthemLastPlayedAt:(NSDate*)value;




- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveRecognitionIdentifier;
- (void)setPrimitiveRecognitionIdentifier:(NSNumber*)value;

- (int32_t)primitiveRecognitionIdentifierValue;
- (void)setPrimitiveRecognitionIdentifierValue:(int32_t)value_;




- (NSNumber*)primitiveSongId;
- (void)setPrimitiveSongId:(NSNumber*)value;

- (int64_t)primitiveSongIdValue;
- (void)setPrimitiveSongIdValue:(int64_t)value_;





- (NSMutableSet*)primitivePictures;
- (void)setPrimitivePictures:(NSMutableSet*)value;


@end
