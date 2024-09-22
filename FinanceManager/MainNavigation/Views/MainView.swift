//
//  MainView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 06/09/2024.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel = MainViewModel()
    var body: some View {
        if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty {
            TabView {
                
                HomePage(viewModel1: FinanceInterestViewModel())
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                ProfileView()
                    .tabItem {
                        Label("Profile", systemImage: "person.circle")
                    }
                FinanceAspirationsView()
                    .tabItem {
                        Label("Financial Aspirations", systemImage: "dollarsign.arrow.circlepath")
                    }
                CurrentFinancesView()
                    .tabItem {
                        Label("Current Finances", systemImage: "dollarsign.circle")
                    }
            }
        } else {
            LoginView()
        }
    }
}
#Preview {
    MainView()
}
