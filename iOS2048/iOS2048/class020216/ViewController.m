//
//  ViewController.m
//  class020216
//
//  Created by Matthew Reigada on 2/2/16.
//  Copyright © 2016 Matthew Reigada. All rights reserved.
//

#import "ViewController.h"
#define N 4

@interface ViewController ()

@end

@implementation ViewController

int scores[N][N] = {
                        {0,0,0,0},
                        {0,0,0,0},
                        {0,0,0,0},
                        {0,0,0,0}
                    };

/* Method rotates all values in scores 90 degrees clockwise */
- (void)rotateValues{
    int temp[N][N];
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            temp[j][i] = scores[(N-1)-i][j];
        }
    }
    for(int i = 0; i < N; i++){
        for(int j = 0; j < N; j++){
            scores[i][j] = temp[i][j];
        }
    }
}

/* Method shifts all zeroes to right end of matrix */
-(void)shiftZeroes{
    for(int possibleShifts = 0; possibleShifts < (N-1); possibleShifts++){
        for(int row = 0; row < N; row++){
            for(int column = 0; column < (N-1); column++){
                if(scores[row][column] == 0){
                    scores[row][column] = scores[row][column + 1];
                    scores[row][column + 1] = 0;
                }
            }
        }
    }
}

/* Method shifts matching block values in together */
-(void)shiftMatches{
    for(int i = 0; i < N; i++){
        for(int j = 0; j < (N-1); j++){
            if(scores[i][j] == scores[i][j + 1]){
                scores[i][j] *= 2;
                scores[i][j + 1] = 0;
            }
        }
    }
}

-(void)shiftValues{
    [self shiftZeroes];
    [self shiftMatches];
    [self shiftZeroes];
}

- (IBAction)nukeLocation:(id)sender {
    UIColor* defunctColor = [UIColor orangeColor];
    if ([sender backgroundColor] == defunctColor){
    
    }else{
        [self pickNukeLocation];
        [sender setBackgroundColor:defunctColor];
    }
    [self setTextVals];
}

-(void) pickNukeLocation{
    int x = arc4random_uniform(10000);
    int y = arc4random_uniform(10000);
    x = x % 4;
    y = y % 4;
    scores[x][y] = 0;
}

- (IBAction)northPress:(id)sender {
    for(int i = 0; i < 3; i++){
        [self rotateValues];
    }
    [self shiftValues];
    [self rotateValues];
    [self insertNewValue];
    [self setTextVals];
}

- (IBAction)southPress:(id)sender {
    [self rotateValues];
    [self shiftValues];
    for(int i = 0; i < 3; i++){
        [self rotateValues];
    }
    [self insertNewValue];
    [self setTextVals];
}

- (IBAction)westPress:(id)sender {
    [self shiftValues];
    [self insertNewValue];
    [self setTextVals];
}

- (IBAction)eastPress:(id)sender {
    for(int i = 0; i < 2; i++){
        [self rotateValues];
    }
    [self shiftValues];
    for(int i = 0; i < 2; i++){
        [self rotateValues];
    }
    [self insertNewValue];
    [self setTextVals];
}

-(void)insertNewValue{
    BOOL inserted = false;
    for(int i = 0; i < N && inserted == false; i++){
        for(int j = (N-1); j >= 0 && inserted == false; j--){
            int thisBox = arc4random_uniform(10);//this gives a 50% chance of insertion
            int twoFour = arc4random_uniform(4);
            twoFour = (twoFour >= 3)?4:2;
            if(scores[i][j] == 0 && (thisBox % 2 == 0)){
                scores[i][j] = twoFour;
                inserted = true;
            }
        }
    }
    
    if(inserted == false){
        for(int i = 0; i < N && inserted == false; i++){
            for(int j = (N-1); j >= 0 && inserted == false; j--){
                int twoFour = arc4random_uniform(4);
                twoFour = (twoFour >= 3)?4:2;
                if(scores[i][j] == 0){
                    scores[i][j] = twoFour;
                    inserted = true;
                }
            }
        }
    }
}

/* Method sets text field of buttons */
/* Method also inserts new 2 in matrix */
-(void) setTextVals{
    
    NSString* scoreFormat = @"%d";
    
    [_zeroZero setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[0][0]] forState:UIControlStateNormal];
    [_northWest setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[0][1]] forState:UIControlStateNormal];
    [_northEast setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[0][2]] forState:UIControlStateNormal];
    [_zeroThree setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[0][3]] forState:UIControlStateNormal];
    
    [_westNorth setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[1][0]] forState:UIControlStateNormal];
    [_oneOne setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[1][1]] forState:UIControlStateNormal];
    [_oneTwo setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[1][2]] forState:UIControlStateNormal];
    [_eastNorth setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[1][3]] forState:UIControlStateNormal];
    
    [_westSouth setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[2][0]] forState:UIControlStateNormal];
    [_twoOne setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[2][1]] forState:UIControlStateNormal];
    [_twoTwo setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[2][2]] forState:UIControlStateNormal];
    [_eastSouth setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[2][3]] forState:UIControlStateNormal];
    
    [_threeZero setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[3][0]] forState:UIControlStateNormal];
    [_southWest setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[3][1]] forState:UIControlStateNormal];
    [_southEast setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[3][2]] forState:UIControlStateNormal];
    [_threeThree setTitle:[[NSString alloc] initWithFormat:scoreFormat, scores[3][3]] forState:UIControlStateNormal];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
