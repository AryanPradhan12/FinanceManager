//
//  ButtonView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 15/09/2024.
//

import SwiftUI

struct ButtonView: View {
    let title: String
    let background: Color
    let action: () -> Void
    var body: some View {
        Button {
          action()
        }label: {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(background)
                Text(title)
                    .foregroundColor(Color.white)
                    .bold()
            }
            
        }
    }
}
struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(title: "Value", background: .green) {
            //Action
        }
    }
}
