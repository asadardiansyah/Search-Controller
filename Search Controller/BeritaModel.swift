//
//  BookModel.swift
//  Search Controller
//
//  Created by Asad Ardiansyah on 14/10/20.
//  Copyright © 2020 Asad Ardiansyah. All rights reserved.
//

import Foundation
import UIKit

struct BeritaModel: Decodable {
    let content: [Berita]?
}

struct Berita: Decodable {
    let judul: String?
    let shortContentIna: String?
    let urlGambar: String?
    var completeUrl: String? {
        if let url = urlGambar {
            return "https://api-penerjemah.setkab.go.id" + url
        } else {
            return nil
        }
    }
}
