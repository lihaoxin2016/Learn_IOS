

#import "DetailViewController.h"
#import "AddViewController.h"

#import <BusinessLogicLayer/NoteBL.h>
#import <PersistenceLayer/Note.h>

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    if (self.detailItem) {
        Note* note = self.detailItem;
        self.detailDescriptionLabel.text = note.content;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configureView];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
