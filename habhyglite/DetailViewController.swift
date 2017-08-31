//
//  DetailViewController.swift
//  habhyglite
//
//  Created by Brian Lanham on 8/18/17.
//  Copyright © 2017 Brian Lanham. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            self.title = detail.ProperName
            if let label = detailDescriptionLabel {
                label.text = detail.CommonName
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: StarData? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

