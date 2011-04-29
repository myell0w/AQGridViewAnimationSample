//
//  ASCBaseViewController.h
//  ArtStarsCars
//
//  Created by Matthias Tretter on 14.04.11.
//  Copyright 2011 NOUS Wissensmanagement GmbH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSDefines.h"
#import "ASCBackgroundView.h"
#import "NGLabel.h"


@interface ASCBaseViewController : UIViewController {
    NGLabel *headerLabel_;
    ASCBackgroundView *backgroundView_;
}

@property (nonatomic, retain) ASCBackgroundView *backgroundView;


@end
