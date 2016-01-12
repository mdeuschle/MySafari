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
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadURLwithString:@"http://www.apple.com"];
    self.goBackButton.enabled = false;
    self.goForwardButton.enabled = false;
   }

-(BOOL)textFieldShouldReturn:(UITextField *)textField {

    NSString *enterText = textField.text;
    BOOL hasPrefix = ([enterText hasPrefix:@"http://"] || [enterText hasPrefix:@"https://"]);
    {
        if (hasPrefix == true) {
            [self loadURLwithString:enterText];
        }
        else{
            NSString *enterText2 = [NSString stringWithFormat:@"https://%@",textField.text];
            [self loadURLwithString:enterText2];
        }
        return self;
    }

}
// helper method
-(void)loadURLwithString:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.variableWebView loadRequest:request];
}

-(void)webViewDidStartLoad:(UIWebView *)webView {
    self.goForwardButton.enabled = self.variableWebView.canGoForward;
    self.goBackButton.enabled = self.variableWebView.canGoBack;
    [self.spinner startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.spinner stopAnimating];
}
- (IBAction)onBackButtonPressed:(UIBarButtonItem *)sender {
    [self.variableWebView goBack];
}
- (IBAction)onFowardButtonPressed:(UIBarButtonItem *)sender {
    [self.variableWebView goForward];
}
- (IBAction)onReloadButtonPressed:(UIBarButtonItem *)sender {
    [self.variableWebView reload];
}
- (IBAction)onStopLoadingButtonPressed:(UIBarButtonItem *)sender {
    [self.variableWebView stopLoading];
}
- (IBAction)onAlertButtonPressed:(UIBarButtonItem *)sender {

    
}

- (IBAction)onDismissKeyboard:(id)sender {
}



@end
