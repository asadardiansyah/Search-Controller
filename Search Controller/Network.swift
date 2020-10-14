//
//  Network.swift
//  Search Controller
//
//  Created by Asad Ardiansyah on 14/10/20.
//  Copyright © 2020 Asad Ardiansyah. All rights reserved.
//

import Foundation
class Network {
    static func fetchBooks(judul: String = "", completionHandler: @escaping (BeritaModel) -> Void) {
        let parameters = "{\"page\": 0,\"size\": 1000\n}\n"
        let postData = parameters.data(using: .utf8)
        
        let query = judul.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) ?? ""
        let url = URL(string: "https://api-penerjemah.setkab.go.id/api/public/berita/filter?isPublished=true&categoryId=5&judul=\(query)")!
        var request = URLRequest(url: url,timeoutInterval: Double.infinity)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = postData
        
        print("\n\n")
        print(":::::::::::::: REQUEST ::::::::::::::")
        print("URL: \(url.absoluteString)")
        print("\n\n")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("\n\n")
            print(":::::::::::::: RESPONSE ::::::::::::::")
            print("URL: \(url.absoluteString)")
            
            if let error = error {
                print("Error with fetching books: \(error)")
                print("\n\n")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print("Error with the response, unexpected status code: \(response.debugDescription)")
                    print("\n\n")
                    return
            }
            
            if let data = data,
                let books = try? JSONDecoder().decode(BeritaModel.self, from: data) {
                print("TOTAL COUNT: \(books.content?.count ?? 0)")
                print("\n\n")
                completionHandler(books)
            }
        }
        
        task.resume()
    }

    static func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
}
