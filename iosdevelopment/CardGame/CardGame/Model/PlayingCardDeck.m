//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by Kacey on 6/19/14.
//  Copyright (c) 2014 Kacey. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

-(instancetype)init
{
    self = [super init];
    if(self){
    
        for(NSString *suit in [PlayingCard validSuits]){
            for(NSUInteger rank =1; rank <= [PlayingCard maxRank]; ++rank){
                PlayingCard *card = [[PlayingCard alloc] init];
                card.rank = rank;
                card.suit = suit;
                if ([[card suit] isEqualToString:@"♥︎"] ||
                    [[card suit] isEqualToString:@"♦︎"])
                {
                    card.color = [UIColor redColor];
            
                } else{
                  
                    card.color = [UIColor blackColor];                }

                [self addCard:card];
            }
        
        }
    
    
    }
    return self;


}

@end
