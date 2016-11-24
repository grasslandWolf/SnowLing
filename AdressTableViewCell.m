//
//  AdressTableViewCell.m
//  SnowLing
//
//  Created by 刘新乐 on 16/11/14.
//  Copyright © 2016年 lxl. All rights reserved.
//

#import "AdressTableViewCell.h"

@implementation AdressTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)editAdress:(id)sender {
    if ([self.delegate respondsToSelector:@selector(editAdress:)]) {
        [self.delegate editAdress:sender];
    }
}
- (IBAction)deleteAdress:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(deleteAdress:)]) {
        [self.delegate deleteAdress:sender];
    }
}
- (IBAction)defaultAdress:(id)sender {
    
}

-(void)getModel:(AdressFmdbModel*)ADmodel {

    self.ADmodel = ADmodel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
