//
//  FinanceInterestViewModel.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 22/09/2024.
//

import SwiftUI
import Foundation
import FirebaseFirestore
import FirebaseAuth

class FinanceInterestViewModel: ObservableObject {
    struct Article: Identifiable {
        let id = UUID()
        let title: String
        let link: String
        let imageName: String
    }
    
    @Published var availableOptions: [String] = ["Stocks", "Real Estate", "Saving", "International Trade", "Risk Management"]
    @Published var selectedOptions: [String] = []
    @Published var articleLinks: [Article] = []
    
    private let db = Firestore.firestore()
    private var userId: String? // Assume you manage this via authentication
    
    init() {
        fetchSelectedOptions()
    }
    
    // Function to select and deselect options
    func selectOption(_ option: String) {
        if selectedOptions.contains(option) {
            selectedOptions.removeAll { $0 == option } // Deselect the option
        } else {
            selectedOptions.append(option) // Select the option
        }
        saveSelectedOptions()
        fetchArticleLinks(for: selectedOptions)
    }
    
    // Function to save selected options to Firestore
    private func saveSelectedOptions() {
        guard let userId = userId else { return }
        
        db.collection("users").document(userId).setData([
            "selectedOptions": selectedOptions
        ], merge: true) { error in
            if let error = error {
                print("Error saving options: \(error.localizedDescription)")
            } else {
                print("Selected options successfully saved")
            }
        }
    }
    
    // Function to fetch the user's selected options from Firestore
    private func fetchSelectedOptions() {
        guard let userId = userId else { return }
        
        db.collection("users").document(userId).getDocument { [weak self] document, error in
            if let error = error {
                print("Error fetching options: \(error.localizedDescription)")
                return
            }
            
            if let document = document, document.exists {
                if let selected = document.get("selectedOptions") as? [String] {
                    self?.selectedOptions = selected
                    self?.fetchArticleLinks(for: selected)
                }
            }
        }
    }
    
    // Function to fetch articles based on selected options
    private func fetchArticleLinks(for options: [String]) {
        articleLinks = [] // Clear previous articles
        for option in options {
            switch option {
            case "Stocks":
                articleLinks.append(contentsOf: [
                    Article(
                        title: "Understand how to invest",
                        link: "https://www.investopedia.com/articles/basics/06/invest1000.asp",
                        imageName: "UnderstandStocksImg"
                    ),
                    Article(
                        title: "Bear and Bull",
                        link: "https://www.fidelity.com/learning-center/smart-money/bear-vs-bull-market",
                        imageName: "BearBullImg"
                    ),
                    Article(
                        title: "Beginner's guide to Invest",
                        link: "https://fortune.com/recommends/investing/how-to-start-investing/",
                        imageName: "GuideToStocksImg"
                    )
                ])
                
            case "Real Estate":
                articleLinks.append(contentsOf: [
                    Article(
                        title: "Real Estate Investing for Beginners",
                        link: "https://www.investopedia.com/articles/mortgages-real-estate/08/invest-in-real-estate.asp",
                        imageName: "realEstateImage"
                    ),
                    Article(
                        title: "How to Buy a House",
                        link: "https://www.example.com/how-to-buy-a-house",
                        imageName: "realEstateImage2"
                    ),
                    Article(
                        title: "Real Estate Market Trends",
                        link: "https://www.example.com/real-estate-trends",
                        imageName: "realEstateImage3"
                    )
                ])
                
            case "Saving":
                articleLinks.append(contentsOf: [
                    Article(
                        title: "Top Tips for Saving Money",
                        link: "https://www.investopedia.com/articles/pf/06/emergencyfund.asp",
                        imageName: "savingTipsImage"
                    ),
                    Article(
                        title: "How to Create a Budget",
                        link: "https://www.example.com/how-to-create-a-budget",
                        imageName: "savingTipsImage2"
                    ),
                    Article(
                        title: "Best Savings Accounts of 2024",
                        link: "https://www.example.com/best-savings-accounts",
                        imageName: "savingTipsImage3"
                    )
                ])
                
            case "International Trade":
                articleLinks.append(contentsOf: [
                    Article(
                        title: "Understanding International Trade",
                        link: "https://www.example.com/international-trade",
                        imageName: "tradeImage"
                    ),
                    Article(
                        title: "The Benefits of International Trade",
                        link: "https://www.example.com/benefits-of-trade",
                        imageName: "tradeImage2"
                    ),
                    Article(
                        title: "Challenges in International Trade",
                        link: "https://www.example.com/challenges-in-trade",
                        imageName: "tradeImage3"
                    )
                ])
                
            case "Risk Management":
                articleLinks.append(contentsOf: [
                    Article(
                        title: "Introduction to Risk Management",
                        link: "https://www.example.com/risk-management",
                        imageName: "riskManagementImage"
                    ),
                    Article(
                        title: "Risk Management Strategies",
                        link: "https://www.example.com/risk-strategies",
                        imageName: "riskManagementImage2"
                    ),
                    Article(
                        title: "Common Risks in Finance",
                        link: "https://www.example.com/common-finance-risks",
                        imageName: "riskManagementImage3"
                    )
                ])
                
            default:
                break
            }
        }
    }

}
