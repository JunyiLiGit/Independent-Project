//
//  CardMatchingGame.h
//  CardGame
//
//  Created by Kacey on 6/21/14.
//  Copyright (c) 2014 Kacey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"


@interface CardMatchingGame : NSObject

//designed initializer
-(instancetype)initWithCardCount:(NSUInteger)count  usingDeck:(Deck *)deck;

-(void)twoModeChooseCardAtIndex:(NSUInteger) index;
-(void)threeModeChooseCardAtIndex:(NSUInteger)index;
-(Card *)cardAtIndex:(NSUInteger)index;
-(void)resetUsingDeck:(Deck *)deck;
-(void)chooseCardAtIndex:(NSUInteger)index;
-(void)setCardMode:(NSUInteger)mode;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong, readonly) NSMutableArray *scoreHistory;

@end
