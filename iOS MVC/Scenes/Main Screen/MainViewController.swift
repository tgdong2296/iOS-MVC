//
//  MainViewController.swift
//  iOS MVC
//
//  Created by trinh.giang.dong on 10/2/19.
//  Copyright © 2019 demo. All rights reserved.
//

import UIKit
import Then
import Reusable

final class MainViewController: UIViewController {
    private struct Constant {
        static let apiMappingFailed = "API Mapping Value Failed"
    }
    
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    private var repository = UserRepository(api: APIService.shared)
    
    private var users = [User]() {
        // reload TableView when get new data
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configView()
    }
    
    private func configView() {
        tableView.do {
            $0.register(cellType: UserCell.self)
            $0.estimatedRowHeight = 50
            $0.rowHeight = UITableView.automaticDimension
            $0.dataSource = self
            $0.delegate = self
        }
    }
    
    @IBAction func handleSearchButtonTapped(_ sender: UIButton) {
        guard let keySearch = searchTextField.text else {
            searchTextField.text = nil
            return
        }
        
        self.showIndicator(true)
        
        repository.searchUsers(keyword: keySearch, limit: 10) { [weak self] response in
            guard let self = self, let response = response else { return }
            switch response {
            case .success(let searchResponse):
                guard let searchResponse = searchResponse else {
                    self.showError(message: Constant.apiMappingFailed)
                    return
                }
                self.users = searchResponse.users
                
            case .failure(let error):
                self.showError(message: error.localizedDescription)
            }
            
            self.showIndicator(false)
        }
    }
    
}

// UITableView data source protocol
extension MainViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UserCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setContentForCell(users[indexPath.row])
        return cell
    }
    
}

// UITableView delegate protocol
extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // do anything when user tab on Cell
    }
    
}

// Implement Reusable library protocol
extension MainViewController: StoryboardSceneBased {
    static var sceneStoryboard = StoryBoards.main
}
