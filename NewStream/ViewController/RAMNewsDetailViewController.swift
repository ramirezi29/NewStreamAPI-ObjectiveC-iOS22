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
            self.viewDidLoad()
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

        // Do any additional setup after loading the view.
    }
    
    func updateViews(){
        guard let news = news else {return}
        authoLabel.text = news.author
        sourceLabel.text = news.source
        bodyTextView.text = news.content
       // newsImageView.image = news.imageUrl
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
