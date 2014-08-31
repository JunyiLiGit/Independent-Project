//
//  CardGameViewController.m
//  CardGame
//
//  Created by Kaitlyn on 6/19/14.
//  Copyright (c) 2014 Kacey. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"


@interface CardGameViewController ()
@property (strong,nonatomic) CardMatchingGame *game;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLable;
@property (weak, nonatomic) IBOutlet UIButton *resetButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *cardModeSegmentedControl;

@end

@implementation CardGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cardModeSegmentedControl addTarget:self action:@selector(changeCardMode:) forControlEvents:UIControlEventValueChanged];
     
}
-(CardMatchingGame *)game
{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
 
}

- (void)changeCardMode:(UIButton *)sender{
    NSUInteger mode = [self.cardModeSegmentedControl selectedSegmentIndex];
    if (mode == 0) {
        [self.game setCardMode:2];
    }
    else {
        [self.game setCardMode:3];
    }
    
}
-(Deck *)createDeck
{
    return nil;
}

-(void)reset
{
    [self.game resetUsingDeck:[self createDeck]];
}



- (IBAction)touchCardButton:(UIButton *)sender
{
    int choosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:choosenButtonIndex];
    [self updateUI];
    if (self.cardModeSegmentedControl.enabled) {
        self.cardModeSegmentedControl.enabled = NO;
    }
}

- (IBAction)resetButton:(UIButton *)sender
{
    [self reset];
    [self updateUI];
    if (!self.cardModeSegmentedControl.enabled) {
        self.cardModeSegmentedControl.enabled = YES;
    }
}


-(void)updateUI
{
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:(UIControlStateNormal)];
        [cardButton setBackgroundImage:[self bacgroundImageForCard:card] forState:(UIControlStateNormal)];
        [cardButton setTitleColor:[self colorForCard:(PlayingCard *)card] forState:(UIControlStateNormal)];
        cardButton.enabled = !card.isMatched;
        self.scoreLable.text = [NSString stringWithFormat:@"Score: %d", self.game.score]
        ;
    }
}

-(NSString *)titleForCard:(Card *)card
{
    return card.isChosen ? card.contents : @"";
}
-(UIColor *)colorForCard:(PlayingCard *)card
{
    return card.isChosen ? card.color : [UIColor whiteColor];
}
-(UIImage *)bacgroundImageForCard:(Card *)card
{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
