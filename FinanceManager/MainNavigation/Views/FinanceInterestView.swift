//
//  FinanceInterestView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 15/09/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

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
                    
                    InterestDisplayView(viewModel1: viewModel1)
                        .padding()
                    
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
        .onAppear {
            viewModel1.fetchSelectedOptions() // Fetch options on appear
        }
    }
}

struct InterestDisplayView: View {
    @ObservedObject var viewModel1: FinanceInterestViewModel
    
    var body: some View {
        VStack {
            if viewModel1.selectedOptions.isEmpty {
                RoundedRectangle(cornerRadius: 10)
                    .frame(height: 100)
                    .foregroundColor(.gray)
                    .overlay(Text("No Selected Options").foregroundColor(.white))
                    .padding()
            } else {
                // Display the selected options
                ForEach(viewModel1.selectedOptions, id: \.self) { option in
                    Text(option)
                        .font(.headline)
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 10).fill(Color.blue.opacity(0.2)))
                        .padding(.horizontal)
                }
            }
        }
    }
}

#Preview {
    FinanceInterestView()
}
