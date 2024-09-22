//
//  FinanceInterestView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 15/09/2024.
//

import SwiftUI

struct FinanceInterestView: View {
    @StateObject var viewModel1 = FinanceInterestViewModel()
    
    var body: some View {
        ScrollView {
            ZStack {
                VStack {
                    Text("Configure Your Financial Feed!")
                        .font(.title2)
                        .foregroundColor(.black)
                        .bold()
                    
                    // Display the selected options
                    InterestDisplayView(viewModel1: viewModel1)
                        .padding()
                    
                    // Display the available options as buttons
                    ForEach(viewModel1.availableOptions, id: \.self) { option in
                        Button(action: {
                            viewModel1.selectOption(option)
                        }) {
                            HStack {
                                Text(option)
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(viewModel1.selectedOptions.contains(option) ? Color.green : Color.blue)
                                    .foregroundColor(.white)
                                    .cornerRadius(10)
                                    .padding(.horizontal)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct InterestDisplayView: View {
    @ObservedObject var viewModel1: FinanceInterestViewModel
    
    var body: some View {
        VStack {
            if viewModel1.articleLinks.isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 100)
                    .foregroundColor(.gray)
                    .overlay(Text("No Articles Available").foregroundColor(.white))
                    .padding()
            } else {
                // Display articles for the selected options
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

        }
    }
}


#Preview {
    FinanceInterestView()
}
