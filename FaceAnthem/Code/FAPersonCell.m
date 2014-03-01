//
//  FAPersonCell.m
//  FaceAnthem
//
//  Created by Bryce Hammond on 2/28/14.
//  Copyright (c) 2014 Imulus. All rights reserved.
//

#import "FAPersonCell.h"
#import "FAPerson.h"

@interface FAPersonCell ()
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@end

@implementation FAPersonCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setPerson:(FAPerson *)person
{
    self.nameLabel.text = person.name;
}

@end
