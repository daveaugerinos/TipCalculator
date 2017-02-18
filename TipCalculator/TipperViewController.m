//
//  TipperViewController.m
//  TipCalculator
//
//  Created by Dave Augerinos on 2017-02-17.
//  Copyright © 2017 Dave Augerinos. All rights reserved.
//

#import "TipperViewController.h"
#import "Tipper.h"

@interface TipperViewController ()

@property (weak, nonatomic) IBOutlet UILabel *billLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountDollarLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageTextField;
@property (strong, nonatomic) Tipper *tipper;

@end

@implementation TipperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSDecimalNumber *initialBillAmount = [[NSDecimalNumber alloc] initWithFloat:0.00];
    NSDecimalNumber *initialTipPercentage = [[NSDecimalNumber alloc] initWithFloat:0.15];

    self.tipper = [[Tipper alloc] initWithBillAmount:initialBillAmount TipPercentage: initialTipPercentage];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {

    NSDecimalNumber *tipAmount = [[NSDecimalNumber alloc] initWithString:@"0"];
    NSDecimalNumber *billAmount = [[NSDecimalNumber alloc] initWithString:@"0"];
    NSDecimalNumber *tipPercentage = [[NSDecimalNumber alloc] initWithString:@"0.15"];
    NSDecimalNumber *hundred = [[NSDecimalNumber alloc] initWithString:@"100"];
    
    NSCharacterSet* invalid = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    
    if(![self.billAmountTextField.text isEqualToString:@""]) {
        if([self.billAmountTextField.text rangeOfCharacterFromSet:invalid].location == NSNotFound || [self.tipPercentageTextField.text rangeOfCharacterFromSet:invalid].location == NSNotFound) {
            billAmount = [[NSDecimalNumber alloc] initWithString:self.billAmountTextField.text];
            tipPercentage = [[NSDecimalNumber alloc] initWithString:self.tipPercentageTextField.text];
            tipPercentage = [tipPercentage decimalNumberByDividingBy:hundred];
            tipAmount = [self.tipper calculateTipWithBillAmount:billAmount andTipPercentage:tipPercentage];
        }
        
        else {
            tipAmount = [self.tipper calculateTipWithBillAmount:billAmount andTipPercentage:tipPercentage];
        }
        
        NSNumberFormatter *formatDollars = [[NSNumberFormatter alloc] init];
        [formatDollars setNumberStyle:NSNumberFormatterCurrencyStyle];
        self.tipAmountLabel.text = [formatDollars stringFromNumber:tipAmount];
    }
    
    else {
        self.tipAmountLabel.text = @"$0.00";
    }
}

- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.tipPercentageTextField.text = [NSString stringWithFormat:@"%f", [sender value]];
}



@end
