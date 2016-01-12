//
//  ViewController.m
//  MySafari
//
//  Created by Matt Deuschle on 1/12/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *variableWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadURLwithString:@"http://www.apple.com"];
   }

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self loadURLwithString:textField.text];
    return true;
}
// helper method
-(void)loadURLwithString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.variableWebView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    [self.spinner startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
}
//- (IBAction)onBackButtonPressed:(UIBarButtonItem *)sender {
//    [self.variableWebView canGoBack];
//}
//- (IBAction)onFowardButtonPressed:(UIBarButtonItem *)sender {
//}
//- (IBAction)onReloadButtonPressed:(UIBarButtonItem *)sender {
//}
//- (IBAction)onStopLoadingButtonPressed:(UIBarButtonItem *)sender {
//}
//- (IBAction)onAlertButtonPressed:(UIBarButtonItem *)sender {
//}



@end
