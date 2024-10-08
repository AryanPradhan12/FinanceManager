//
//  RegisterView.swift
//  FinanceManager
//
//  Created by Aryan Pradhan on 15/09/2024.
//

import SwiftUI

struct RegisterView: View {
    @StateObject var viewModel = RegisterViewModel()
    @State private var errorMessageID = UUID()
    var body: some View {
        VStack {
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(.green)
                    .rotationEffect(Angle(degrees: -15),anchor: .center)
                VStack {
                    Text("Register")
                        .font(.system(size:35))
                        .foregroundColor(Color.white)
                        .bold()
                    
                    Text("Create Your Account")
                        .foregroundColor(Color.white)
                        .font(.system(size:20))
                }
            }
            
            .frame(width: UIScreen.main.bounds.width * 3, height: 300)
            .offset(y: -100)
            .padding(.bottom, 50)
            //End of header
                Form {
                    TextField("Full Name", text: $viewModel.name)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocorrectionDisabled()
                    
                    TextField("Email Address", text: $viewModel.email)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .autocapitalization(.none)
                        .autocorrectionDisabled()
                    
                    SecureField("Password", text: $viewModel.password)
                        .textFieldStyle(DefaultTextFieldStyle())
                    
                    ButtonView(title: "Create Account", background: .green) {
                        viewModel.register()
                        errorMessageID = UUID()
                    }
                    .padding()
                }
                .offset(y: -50)
                Spacer()
                
                VStack {
                    Text("Already have an account?")
                    NavigationLink("Log into your account", destination: LoginView())
                }
                Spacer()
            
            if !viewModel.errorMessage.isEmpty {
                            Text(viewModel.errorMessage)
                                .foregroundColor(Color.red)
                                .padding(.vertical, 10)
                                .id(errorMessageID)
                        }
        }
        
    }
}
#Preview {
    RegisterView()
}
