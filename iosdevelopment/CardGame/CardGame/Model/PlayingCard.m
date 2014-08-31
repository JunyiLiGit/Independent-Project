//
//  PlayingCard.m
//  CardGame
//
//  Created by Kacey on 6/19/14.
//  Copyright (c) 2014 Kacey. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard


-(int)twoModeMatch:(NSArray *)otherCards
{
    int score = 0;
    if([otherCards count] == 1){
        id card = [otherCards firstObject];
        if([card isKindOfClass:[PlayingCard class]]){
           PlayingCard *otherCard = (PlayingCard *)card;
           if(otherCard.rank == self.rank){
            score = 4;
            } else if([otherCard.suit isEqualToString:self.suit]){
            score = 1;
            }
            
         }
     }
    return score;

}


-(int)matchPlayingCard:(PlayingCard *)card1 with:(PlayingCard *)card2
{
    int score = 0;
    if(card1.rank == card2.rank){
        score = 4;
    } else if([card1.suit isEqualToString:card2.suit]){
        score = 1;
    }
    return score;
}

-(int)threeModeMatch:(NSArray *)otherCards
{
    int score = 0;
    if([otherCards count] == 2){
        for(Card* card in otherCards){
            if([card isKindOfClass:[PlayingCard class]]){
                PlayingCard *otherCard = (PlayingCard *)card;
                score += [self matchPlayingCard:self with:otherCard];
            }
        }
        score += [self matchPlayingCard:(PlayingCard *)[otherCards firstObject] with:
                               (PlayingCard *)[otherCards lastObject]];
        
    }
    return score;
}


- (int)match:(NSArray *)otherCards
{
    if([otherCards count] == 2){
        return [self threeModeMatch:otherCards];
    }
    NSLog(@"two mode match");
    return [self twoModeMatch:otherCards];


}


-(NSString *)contents
{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];

}
@synthesize suit = _suit;

+ (NSArray*) validSuits
{
    return @[@"♣︎",@"♠︎",@"♥︎",@"♦︎"];
    
}


-(void)setSuit:(NSString *)suit
{
    if([[PlayingCard validSuits] containsObject:suit]){
        _suit = suit;
    }

}

-(NSString *)suit
{
    return _suit ? _suit : @"?";

}

+(NSArray *)rankStrings
{
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
    
}


+(NSUInteger)maxRank
{
    return [[self rankStrings] count] - 1;
    
}

-(void)setRank:(NSUInteger)rank
{
    if(rank <= [PlayingCard maxRank]){
        _rank = rank;
    }

}









@end
