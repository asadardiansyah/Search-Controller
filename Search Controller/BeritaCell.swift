//
//  BeritaCell.swift
//  Search Controller
//
//  Created by Asad Ardiansyah on 14/10/20.
//  Copyright © 2020 Asad Ardiansyah. All rights reserved.
//

import UIKit

class BeritaCell: UITableViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.cornerRadius = 5
        self.imgView.backgroundColor = .lightGray
        self.imgView.contentMode = .scaleAspectFill
    }
    
    func initData(dataBook: Berita?) {
        if let completeUrl = dataBook?.completeUrl, let url = URL(string: completeUrl) {
            downloadImage(from: url)
        }
        self.lblTitle.text = dataBook?.judul
        self.lblDescription.text = dataBook?.shortContentIna
    }
    
    func downloadImage(from url: URL) {
        Network.getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(url.absoluteString)
            DispatchQueue.main.async() {
                self.imgView.image = UIImage(data: data)
            }
        }
    }
}
