//
//  HomePageViewModel.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 15/09/2024.
//

import FirebaseAuth
import Foundation
import FirebaseFirestore

class HomePageViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle?
    init() {
        self.handler = Auth.auth().addStateDidChangeListener { [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        }
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }

}
