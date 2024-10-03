//
//  ViewController.swift
//  innergrim
//
//  Created by 지연 on 9/21/24.
//

import Combine
import UIKit

import Core

struct GitHubUser: Decodable {
    let login: String
    let id: Int
    let name: String?
}

class ViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        let provider = NetworkService()
        let target = TestAPI.getUser(username: "noeyiz")
        provider.request(target, responseType: GitHubUser.self)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished:
                    print("User fetch completed")
                case .failure(let error):
                    print("Error fetching user: \(error)")
                }
            }, receiveValue: { user in
                print("Fetched user: \(user.name ?? user.login)")
                print("User ID: \(user.id)")
            })
            .store(in: &cancellables)
    }
}
