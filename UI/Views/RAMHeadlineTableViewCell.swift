//
//  RAMHeadlineTableViewCell.swift
//  NewStream
//
//  Created by Ivan Ramirez on 11/1/18.
//  Copyright © 2018 trevorAdcock. All rights reserved.
//

import UIKit

class RAMHeadlineTableViewCell: UITableViewCell {
    
    @IBOutlet weak var newsImageView: UIImageView!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sourceLabel: UILabel!
    
    // MARK: - Landing pad
    
    // NOTE: - ***** need to include @objc in order for our swift file to be seen by the )bjec C file 
    @objc var news: RAMNews?{
        didSet{
            updateViews()
            fetchAndSetImage()
        }
    }
    
    func updateViews() {
        guard let news = news else {return}
        titleLabel.text = news.title
        sourceLabel.text = news.source
        // NOTE: - author is nullable, we did this in the modelfile
        let author = nullToNil(value: news.author as AnyObject)
        authorLabel.text = author as? String ?? "None"
    }
    
    func fetchAndSetImage(){
        guard let imageUrl = news?.imageUrl else {return}
        RAMNewsAPIClient.fetchImage(forUrl: imageUrl) { (photo) in
            
            DispatchQueue.main.async {
                self.newsImageView.image = photo
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func nullToNil(value : AnyObject?) -> AnyObject? {
        if value is NSNull {
            return nil
        } else {
            return value
        }
    }
}
