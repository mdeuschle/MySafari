//
//  ViewController.m
//  MySafari
//
//  Created by Matt Deuschle on 1/12/16.
//  Copyright © 2016 Matt Deuschle. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UIWebViewDelegate, UITextFieldDelegate, UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *variableWebView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goBackButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goForwardButton;
@property (weak, nonatomic) IBOutlet UITextField *urlTextField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self loadURLwithString:@"http://www.apple.com"];
    self.goBackButton.enabled = false;
    self.goForwardButton.enabled = false;
    self.navigationController.hidesBarsOnSwipe = true;
    //self.navigationItem.title = @"Title";
    self.title = @"Apple";
    self.variableWebView.scrollView.delegate = self;
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
    [self.spinner startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView {
    self.goForwardButton.enabled = self.variableWebView.canGoForward;
    self.goBackButton.enabled = self.variableWebView.canGoBack;
    NSURLRequest *currentRequest = [self.variableWebView request];
    NSURL *currentURL = [currentRequest URL];
    self.urlTextField.text = currentURL.absoluteString;
    
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
    UIAlertController *comingSoon = [UIAlertController alertControllerWithTitle:@"Coming Soon!" message:@"Stay tuned!" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [comingSoon addAction:cancel];
    [self presentViewController:comingSoon animated:YES completion:nil];
}

- (IBAction)onDismissKeyboard:(id)sender {
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint pan = [scrollView.panGestureRecognizer translationInView:scrollView.superview];

    if(pan.y < 0)
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [self.urlTextField setAlpha:0];
        [UIView commitAnimations];
    } else
    {
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.2];
        [self.urlTextField setAlpha:1];
        [UIView commitAnimations];
    }
}

@end
