//
//  MainView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 06/09/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack {
            TabView {
                
                HomePage()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                Finance1()
                    .tabItem {
                        Label("Finance1", systemImage: "person.circle")
                    }
                Finance2()
                    .tabItem {
                        Label("Finance2", systemImage: "figure.strengthtraining.traditional")
                    }
                Finance3()
                    .tabItem {
                        Label("Finance3", systemImage: "graduationcap.fill")
                    }
            }
        }
    }
}

#Preview {
    MainView()
}
