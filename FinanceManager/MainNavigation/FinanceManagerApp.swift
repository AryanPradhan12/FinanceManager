//
//  FinanceManagerApp.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 06/09/2024.
//

import SwiftUI

@main
struct FinanceManagerApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
