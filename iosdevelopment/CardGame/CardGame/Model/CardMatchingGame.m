//
//  CardMatchingGame.m
//  CardGame
//
//  Created by Kacey on 6/21/14.
//  Copyright (c) 2014 Kacey. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite)NSInteger score;
@property (nonatomic, strong, readwrite) NSMutableArray *scoreHistory;
@property (nonatomic, strong) NSMutableArray *cards;
@property (nonatomic) NSUInteger cardCount;
@property (nonatomic) NSUInteger whichMode;

@end


@implementation CardMatchingGame

-(NSMutableArray *)cards
{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray *)scoreHistory
{
    if(!_scoreHistory) _scoreHistory = [[NSMutableArray alloc] init];
    return _scoreHistory;
}

-(void)setCardMode:(NSUInteger)mode
{
    self.whichMode = mode;

}


-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck
{
    self = [super init];
    if(self){
        for(int i = 0; i <count; ++i ){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }
            else
            {
                self =nil;
                break;
            
            }
        }
        self.whichMode = 2;
    
    }
    
    self.cardCount = 0;
    return self;
}

-(void)resetUsingDeck:(Deck *)deck
{
    NSUInteger count = [self.cards count];
    [self.cards removeAllObjects];
    for(int i = 0; i <count; ++i ){
        Card *card = [deck drawRandomCard];
        if(card){
            [self.cards addObject:card];
        } else {
            break;
            
        }
    }

    self.cardCount = 0;
    self.score = 0;

}





-(Card *)cardAtIndex:(NSUInteger)index
{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;


-(void)twoModeChooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
        }else{
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    int matchScore = [card match:@[otherCard]];
                    if(matchScore){
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        otherCard.matched = YES;
                /*
                        NSString *message = [NSString stringWithFormat:@"Matched %@ %@ for %d points ", [card contents], [otherCard contents], matchScore * MATCH_BONUS];
                        [self.scoreHistory addObject:message];
                        NSLog(@"%@",[self.scoreHistory lastObject]);*/
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        
                        /*NSString *message = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty", [card contents], [otherCard contents], MISMATCH_PENALTY];
                        [self.scoreHistory addObject:message];
                        NSLog(@"%@",[self.scoreHistory lastObject]);*/
                    }
                    break;
                }
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }

}

-(void)setAllToNotChosen:(NSMutableArray *)otherCards
{
    for(Card *card in otherCards){
        card.chosen = NO;
    }
}

-(void)setAllToMatched:(NSMutableArray *)otherCards
{
    for(Card *card in otherCards){
        card.matched = YES;
    }
}


-(void)threeModeChooseCardAtIndex:(NSUInteger)index
{
    Card *card = [self cardAtIndex:index];
    if(!card.isMatched){
        if(card.isChosen){
            card.chosen = NO;
            self.cardCount--;
        }else{
            if(self.cardCount == 2){
                NSMutableArray *otherCards = [[NSMutableArray alloc] init];
                for(Card *otherCard in self.cards){
                    if(otherCard.isChosen && !otherCard.isMatched){
                        [otherCards addObject:otherCard];
                        self.cardCount--;
                        if(self.cardCount == 0){
                        int matchScore = [card match:otherCards];
                        if(matchScore){
                            self.score += matchScore * MATCH_BONUS;
                            card.matched = YES;
                            [self setAllToMatched:otherCards];
                            NSString *message = [NSString stringWithFormat:@"Matched %@ %@ %@ for %d points ", [card contents], [[otherCards firstObject] contents], [[otherCards lastObject] contents], matchScore * MATCH_BONUS];
                            [self.scoreHistory addObject:message];
                            NSLog(@"%@",[self.scoreHistory lastObject]);
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            [self setAllToNotChosen:otherCards];
                            self.cardCount = 1;
                            NSString *message = [NSString stringWithFormat:@"%@ %@ %@ don't match!  %d point penalty ", [card contents], [[otherCards firstObject] contents], [[otherCards lastObject] contents], MISMATCH_PENALTY];
                            [self.scoreHistory addObject:message];
                            NSLog(@"%@",[self.scoreHistory lastObject]);
                        }
                        break;
                        }
                    }
                }
            }
            else  {
             self.cardCount++;
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
            NSLog(@"card count is %d", self.cardCount);
        }
    }
    
}

-(void)chooseCardAtIndex:(NSUInteger)index
{
    if(self.whichMode == 2){
        [self twoModeChooseCardAtIndex:index];
    } else [self threeModeChooseCardAtIndex:index];

}





@end
