//
//  CardGameViewController.h
//  CardGame
//
//  Created by Kacey on 6/19/14.
//  Copyright (c) 2014 Kacey. All rights reserved.
//
//Abstruct class. Must implement methords as described below



#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController
//protected
//for subclasses

-(Deck *)createDeck; //abstract





@end
