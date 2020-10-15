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
    let id: String?
    let istilahIndonesia: String?
    let bidang: String?
}
