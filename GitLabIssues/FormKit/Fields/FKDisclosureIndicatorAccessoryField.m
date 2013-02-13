//
//  FKDisclosureField.m
//  FormKitDemo
//
//  Created by cesar4 on 31/07/12.
//
//

#import "FKDisclosureIndicatorAccessoryField.h"




@implementation FKDisclosureIndicatorAccessoryField



- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleBlue;
    }
    return self;
}


@end
