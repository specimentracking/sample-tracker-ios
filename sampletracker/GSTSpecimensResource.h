//
//  GSTSpecimensResource.h
//  sampletracker
//
//  Created by Ondřej Fabián on 08/02/2014.
//  Copyright (c) 2014 Galaxy. All rights reserved.
//

#import "GSTRESTResource.h"

@interface GSTSpecimensResource : GSTRESTResource

- (void)startCheckSpecimen:(NSString *)barcodeString;

- (void)startPostNewSpecimen:(GSTSpecimenModel *)specimen;

- (void)startPatchUpdateSpecimen:(GSTSpecimenModel *)specimen;


@end
