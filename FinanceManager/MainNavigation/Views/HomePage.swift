//
//  ContentView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 06/09/2024.
//

import SwiftUI

struct HomePage: View {
    @StateObject var viewModel = HomePageViewModel()
    @StateObject var viewModel2 = ProfileViewModel()
    @StateObject var viewModel1 = FinanceInterestViewModel()
    @State private var showDropdown = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                ZStack {
                    VStack {
                        HStack {
                            VStack {
                                Button {
                                    showDropdown.toggle()
                                } label: {
                                    Image(systemName: "gearshape")
                                        .resizable()
                                        .frame(width: 30, height: 30)
                                        .foregroundColor(.black)
                                }
                                if showDropdown {
                                    VStack(alignment: .leading) {
                                        NavigationLink(destination: GetHelpView()) {
                                            Image(systemName: "questionmark.circle")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                        }
                                        
                                        NavigationLink(destination: NotificationsView()) {
                                            Image(systemName: "bell.circle")
                                                .resizable()
                                                .frame(width: 30, height: 30)
                                                .foregroundColor(.black)
                                        }
                                    }
                                    .transition(.slide)
                                }
                            }
                            if let userName = viewModel2.user?.name {
                                Text("Welcome, \(userName)")
                                    .bold()
                                    .font(.system(size: 18))
                            }  else {
                                Text("Welcome")
                                    .foregroundColor(Color.black)
                                    .fontWeight(.semibold)
                                    .font(.system(size: 18))
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        
                        Spacer()
                        
                        VStack {
                            Text("Dashboard")
                                .bold()
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(spacing: 20) {
                                    ForEach(galleries) { gallery in
                                        GalleryView(
                                            Im: gallery.Im,
                                            title: gallery.title,
                                            description: gallery.description,
                                            c: gallery.c, destination: gallery.destination
                                        )
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(height: 360)
                            
                            
                            Text("Articles of your interest")
                                .bold()
                                .font(.system(size: 25))
                                .foregroundColor(.black)
                            
                            if viewModel1.articleLinks.isEmpty {
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 100)
                                    .foregroundColor(.gray)
                                    .overlay(Text("No Articles Available").foregroundColor(.white))
                                    .padding()
                            } else {
                                ForEach(viewModel1.articleLinks) { article in
                                    NavigationLink(destination: SafariView(url: URL(string: article.link)!)) {
                                        HStack {
                                            Image(article.imageName)
                                                .resizable()
                                                .frame(width: 80, height: 80)
                                                .cornerRadius(10)
                                            VStack(alignment: .leading) {
                                                Text(article.title)
                                                    .font(.headline)
                                                    .foregroundColor(.black)
                                                Text("Read more...")
                                                    .font(.subheadline)
                                                    .foregroundColor(.blue)
                                            }
                                            .padding()
                                        }
                                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                                        .padding(.horizontal)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }
                }
                .onAppear {
                    viewModel2.fetchUser()
                    viewModel1.fetchSelectedOptions()
                }
            }
        }
    }
    struct GalleryCards: Identifiable {
        var id = UUID()
        var Im: String
        var title: String
        var description: String
        var c: Color
        var destination: AnyView
    }
    
    
    let galleries: [GalleryCards] = [
        GalleryCards(
            Im: "FinanceInterestIm",
            title: "Financial Interests",
            description: "Configure your article feed by inputting your financial interests",
            c: .green,
            destination: AnyView(FinanceInterestView())
        ),
        GalleryCards(Im: "TrendingFinanceIm", title: "Trending Financial News", description: "Explore the trending stories in the financial world!", c: .blue, destination: AnyView(TrendingFinanceView()))
    ]
    
    struct GalleryView: View {
        var Im: String
        var title: String
        var description: String
        var c: Color
        var destination: AnyView
        
        var body: some View {
            NavigationLink(destination: destination) {
                RoundedRectangle(cornerRadius: 25)
                    .fill(c)
                    .frame(width: 270, height: 350)
                    .overlay (
                        VStack {
                            Text(title)
                                .bold()
                                .font(.system(size: 24))
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing])
                                .lineLimit(nil)
                            Image(Im)
                                .resizable()
                                .frame(width: 130, height: 150)
                                .padding()
                            
                            Text(description)
                                .font(.system(size: 16))
                                .bold()
                                .foregroundColor(.black)
                                .multilineTextAlignment(.center)
                                .padding([.leading, .trailing])
                        }
                    )
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
    
}
#Preview {
    HomePage(viewModel1: FinanceInterestViewModel())
}
