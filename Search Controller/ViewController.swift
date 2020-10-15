//
//  ViewController.swift
//  Search Controller
//
//  Created by Asad Ardiansyah on 14/10/20.
//  Copyright © 2020 Asad Ardiansyah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var tfSearch: UITextField!
    
    private var dataBerita: [Berita]?
    private var searchText: String = ""
    private var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tfSearch.addTarget(self, action: #selector(tfDidChanged), for: .editingChanged)
        
        self.tblView.register(UINib(nibName: "BeritaCell", bundle: nil), forCellReuseIdentifier: "BeritaCell")
        self.tblView.dataSource = self
        self.tblView.delegate = self
        
        refreshData()
    }
    
    @objc private func refreshData(){
        Network.fetchBooks(judul: searchText) {data in
            self.dataBerita = data.content
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
    }
    
    @objc private func tfDidChanged(_ sender: UITextField) {
        self.searchText = sender.text ?? ""
        
        //MARK: Cancel any previous timer
        timer?.invalidate()
        
        //MARK: Schedule a timer for 0.5 seconds after stop typing
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: {_ in
            self.refreshData()
        })
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if dataBerita?.count != 0 {
            return dataBerita?.count ?? 0
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard dataBerita?.count != 0 else {
            let cell = UITableViewCell()
            cell.textLabel?.text = "No data to show"
            cell.textLabel?.font = UIFont.italicSystemFont(ofSize: 15)
            cell.textLabel?.textAlignment = .center
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "BeritaCell") as! BeritaCell
        cell.initData(dataBerita: dataBerita?[indexPath.row])
        return cell
    }
}

