//
//  ViewController.swift
//  OneQuoteADay
//
//  Created by 蘇健豪 on 2019/11/28.
//  Copyright © 2019 蘇健豪. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Request.getQuote { (quote, error) in
            guard let quote = quote else { return }
            
            DispatchQueue.main.async {
                self.quoteLabel.text = quote.quote
                self.authorLabel.text = quote.author
            }
        }
    }

}

