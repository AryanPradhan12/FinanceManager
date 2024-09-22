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
        fetchUserId()
        fetchSelectedOptions()
    }
    
    private func fetchUserId() {
        // Implement your logic to fetch the current user's ID
        userId = Auth.auth().currentUser?.uid
    }

    func selectOption(_ option: String) {
        if selectedOptions.contains(option) {
            selectedOptions.removeAll { $0 == option } // Deselect the option
        } else {
            selectedOptions.append(option) // Select the option
        }
        saveSelectedOptions()
        fetchArticleLinks(for: selectedOptions)
    }

    private func saveSelectedOptions() {
        guard let userId = userId else { return }
        
        db.collection("users").document(userId).setData([
            "selectedOptions": selectedOptions
        ], merge: true) { error in
            if let error = error {
                print("Error saving options: \(error.localizedDescription)")
            }
        }
    }

    func fetchSelectedOptions() {
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
    
    private func fetchArticleLinks(for options: [String]) {
        articleLinks = [] // Clear previous articles
        for option in options {
            switch option {
            case "Stocks":
                articleLinks.append(contentsOf: [
                    Article(title: "Understand how to invest", link: "https://www.investopedia.com/articles/basics/06/invest1000.asp", imageName: "UnderstandStocksImg"),
                    Article(title: "Bear and Bull", link: "https://www.fidelity.com/learning-center/smart-money/bear-vs-bull-market", imageName: "BearBullImg"),
                    Article(title: "Beginner's guide to Invest", link: "https://fortune.com/recommends/investing/how-to-start-investing/", imageName: "GuideToStocksImg")
                ])
            case "Real Estate":
                            articleLinks.append(contentsOf: [
                                Article(title: "Real Estate Investing for Beginners", link: "https://www.forbes.com/advisor/investing/how-to-invest-in-real-estate/", imageName: "RealEstateInvestImg"),
                                Article(title: "How to analyze housing prices", link: "https://www.questionpro.com/blog/real-estate-market-analysis/", imageName: "AnalyzeHousePriceImg"),
                                Article(title: "How to analyze real estate market trends", link: "https://www.trulyengaging.com/blog/understanding-real-estate-market-trends-a-comprehensive-guide-for-agents#:~:text=Utilize%20data%20from%20Multiple%20Listing,it%20favors%20buyers%20or%20sellers.", imageName: "RealEstateMarketImg")
                            ])
                            
                        case "Saving":
                            articleLinks.append(contentsOf: [
                                Article(title: "Top tips for saving money", link: "https://bettermoneyhabits.bankofamerica.com/en/saving-budgeting/ways-to-save-money", imageName: "TipsForSaveMoneyImg"),
                                Article(title: "How to create a budget", link: "https://www.nerdwallet.com/article/finance/how-to-budget", imageName: "BudgetImg"),
                                Article(title: "Advice on saving money", link: "https://www.investopedia.com/how-to-save-money-4589942", imageName: "SaveMoneyImg")
                            ])
                            
                        case "International Trade":
                            articleLinks.append(contentsOf: [
                                Article(title: "Understanding International Trade", link: "https://corporatefinanceinstitute.com/resources/economics/international-trade/#:~:text=International%20trade%20is%20an%20exchange%20of%20a%20good%20or%20service,are%20tariffs%20and%20import%20quotas.", imageName: "UnderstandInternationalTradeImg"),
                                Article(title: "The Benefits of International Trade", link: "https://www.americanexpress.com/en-gb/business/trends-and-insights/articles/advantages-international-trade/", imageName: "BenefitsOfInternationalTradeImg"),
                                Article(title: "Challenges in International Trade", link: "https://online.hbs.edu/blog/post/challenges-of-international-business", imageName: "ChallengesInternationalTradeImg")
                            ])
                            
                        case "Risk Management":
                            articleLinks.append(contentsOf: [
                                Article(title: "Introduction to Risk Management", link: "https://www.softwareag.com/en_corporate/resources/process-management/ds/risk-compliance-management.html", imageName: "IntroToRiskManagementImg"),
                                Article(title: "Risk Management Strategies", link: "https://www.auditboard.com/blog/10-risk-management-strategies/", imageName: "RiskManagementStratergiesImg"),
                                Article(title: "Common Risks in Finance", link: "https://www.simplilearn.com/financial-risk-and-types-rar131-article#:~:text=Some%20common%20financial%20risks%20are,and%20or%20other%20debt%20issues.", imageName: "CommonFinancialRiskImg")
                            ])
            default:
                break
            }
        }
    }
}

