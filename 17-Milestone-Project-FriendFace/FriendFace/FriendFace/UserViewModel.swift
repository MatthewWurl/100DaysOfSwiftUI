//
//  UserViewModel.swift
//  FriendFace
//
//  Created by Matt X on 2/21/22.
//

import Foundation

class UserViewModel: ObservableObject {
    @Published var users = [User]()
    
    let urlString = "https://www.hackingwithswift.com/samples/friendface.json"
    
    init() {
        fetchUsers()
    }
    
    func fetchUsers() {
        let url = URL(string: urlString)!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else {
                print("Error fetching users: \(error?.localizedDescription ?? "Unknown error")")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            
            do {
                let decodedUsers = try decoder.decode([User].self, from: data)
                
                DispatchQueue.main.async {
                    self.users = decodedUsers.sorted { $0.name < $1.name }
                }
            } catch let decodeError {
                print("Error decoding users: \(decodeError.localizedDescription)")
            }
        }.resume()
    }
    
    
}
