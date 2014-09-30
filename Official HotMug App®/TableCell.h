//
//  TableCell.h
//  Official HotMug App®
//
//  Created by Henry Mound on 7/26/14.
//  Copyright (c) 2014 Henry Mound. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TableCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *descriptionLabel;

@end
