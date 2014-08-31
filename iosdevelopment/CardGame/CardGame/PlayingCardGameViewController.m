//
//  PlayingCardGameViewController.m
//  CardGame
//
//  Created by Kacey on 6/22/14.
//  Copyright (c) 2014 Kacey. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

-(Deck *)createDeck
{
    return [[PlayingCardDeck alloc] init];

}



@end
