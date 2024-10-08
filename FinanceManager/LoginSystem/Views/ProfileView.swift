//
//  SettingsView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 15/09/2024.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(colors: [.blue, .purple], startPoint: .topLeading, endPoint: .bottomTrailing)
                    .ignoresSafeArea()
                VStack {
                    if let user = viewModel.user {
                        profile(user: user)
                    } else {
                        Text("Loading Profile...")
                    }
                }
                .navigationTitle("Profile")
            }
            .onAppear {
                viewModel.fetchUser()
            }
        }
        }
    @ViewBuilder
    func profile(user: User) -> some View {
            //Avatar
            Image(systemName: "person.circle")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundColor(Color.blue)
                .frame(width: 125, height: 125)
                .padding()
            
            //Info of user
            VStack(alignment: .leading) {
                HStack {
                    Text("Name:")
                        .bold()
                    Text(user.name)
                        .underline()
                }
                .padding()
                .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.7))
                )
                HStack {
                    Text("Email:")
                        .bold()
                    Text(user.email)
                        .underline()
                }
                .padding()
                .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.7))
                )
                HStack {
                    Text("Member Since:")
                        .bold()
                    Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
                        .underline()
                }
                .padding()
                .background(
                RoundedRectangle(cornerRadius: 15)
                    .fill(Color.white.opacity(0.7))
                )
            }
            .padding()
            
            //Sign out option
            Button("Log Out") {
                viewModel.logOut()
            }
            .tint(.white)
            .fontWeight(.semibold)
            .padding()
            .padding(.horizontal, 20)
            .background(Color.red
                .cornerRadius(10)
                .shadow(radius: 10))
            
            Spacer()
            
            //Settings
        }
        }
        

#Preview {
    ProfileView()
}
