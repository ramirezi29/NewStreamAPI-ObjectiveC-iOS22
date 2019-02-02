//
//  RAMNewsDetailViewController.swift
//  NewStream
//
//  Created by Ivan Ramirez on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class RAMNewsDetailViewController: UIViewController {
    
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authoLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    @objc var news: RAMNews? {
        didSet{
            //IN ORDER TO AVOID RACE CONDITIONS. THE DATA LOADING BEFORE ITS READY
            self.loadViewIfNeeded()
            updateViews()
        }
    }
    
    @objc var photo: UIImage?{
        didSet{
            self.loadViewIfNeeded()
            newsImageView.image = photo
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func updateViews(){
        guard let news = news else {return}
        authoLabel.text = news.author
        sourceLabel.text = news.source
        bodyTextView.text = news.content
        self.title = news.title
    }
}
