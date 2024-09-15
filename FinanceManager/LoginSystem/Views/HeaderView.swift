//
//  HeaderView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 15/09/2024.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.green)
                    .rotationEffect(Angle(degrees: 15),anchor: .center)
                VStack {
                    Text("Finance Manager")
                        .font(.system(size:35))
                        .foregroundColor(Color.white)
                        .bold()
                    
                    Text("Stay organized and track your finances!")
                        .foregroundColor(Color.white)
                        .font(.system(size:20))
                }
            }
            .frame(width: UIScreen.main.bounds.width * 3, height: 300)
            .offset(y: -100)
        }
    }
}
#Preview {
    HeaderView()
}
