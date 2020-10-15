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
    @IBOutlet weak var lblId: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.imgView.layer.cornerRadius = 5
        self.imgView.backgroundColor = .lightGray
        self.imgView.contentMode = .scaleAspectFill
    }
    
    func initData(dataBerita: Berita?) {
        self.lblId.text = dataBerita?.id
        self.lblTitle.text = dataBerita?.istilahIndonesia
        self.lblDescription.text = "Bidang: \(dataBerita?.bidang ?? "-")"
    }
}
