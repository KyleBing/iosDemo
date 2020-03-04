//
//  URLSessionTableVC.swift
//  CustomisedViews
//
//  Created by Kyle on 2020/3/2.
//  Copyright © 2020 KyleBing. All rights reserved.
//

import UIKit

class URLSessionTableVC: UITableViewController {
    
    private let url = URL(string: "https://kylebing.cn/dontstarve/?type=query&table=characters")!
    private let session = URLSession(configuration: URLSessionConfiguration.ephemeral) // 短暂简单的数据请求，不需要缓存之类的
    
    
    var persons: Array<Person> = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchNetworkData(from: url)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return persons.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PersonCell", for: indexPath)
        let person = persons[indexPath.row]
        cell.textLabel?.text = person.name
        cell.detailTextLabel?.text = person.nickName

        return cell
    }
    
    // MARK: - User function
    
    func fetchNetworkData(from url: URL){
        
        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            guard let httpResponse = response as? HTTPURLResponse,
                (200...299).contains(httpResponse.statusCode) else {
                    print(response)
                    return
            }
            if  let mimeType = httpResponse.mimeType, mimeType == "text/html",
                let data = data
            {
                do {
                    let decoder = JSONDecoder()
                    let persons = try decoder.decode(Array<Person>.self, from: data)
                    DispatchQueue.main.async {
                        self.persons = persons
                        self.tableView.reloadData()
                    }

                } catch {
                    print(error)
                }
            }
        }
        task.resume()
    }
}
