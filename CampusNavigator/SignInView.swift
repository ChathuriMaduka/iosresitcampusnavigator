//
//  SignInView.swift
//  CampusNavigator
//
//  Created by Chathuri Maduka on 2025-06-04.
//

import SwiftUI

struct SignInView: View {
    @State private var name: String = ""
       @State private var password: String = ""
       @State private var isPasswordVisible: Bool = false
       @State private var isLoading: Bool = false
       @State private var showAlert: Bool = false
       @State private var alertTitle: String = ""
       @State private var alertMessage: String = ""
       @State private var isLoginSuccessful: Bool = false
       @FocusState private var focusedField: Field?
       
       enum Field: Hashable {
           case name, password
       }
       
       // Hardcoded credentials
       private let validUsername = "cobsccomp4y222p-068"
       private let validPassword = "Test123@#"
    
var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.appBackgroundGray
                .ignoresSafeArea()
ScrollView(.vertical, showsIndicators: false)
{
    
VStack(spacing: 0) {
    ZStack {
        Color.appPrimaryBlue
            .clipShape(CurvedBottomShape())
            .frame(height: min(280, geometry.size.height * 0.35))
        
        Text("Sign In")
        
        
            .font(.largeTitle)
            
            .bold()
            .foregroundColor(.white)
            .padding(.bottom, 60)
    }
                                
VStack(spacing: 20) {
    Spacer().frame(height: 16)
                                    
// Username Field
HStack {
    Image(systemName: "person.fill")
        .foregroundColor(Color.appPrimaryBlue)
    TextField("Enter Your Name", text: $name)
        .autocapitalization(.none)
        .disableAutocorrection(true)
        .focused($focusedField, equals: .name)
        .onSubmit {
            focusedField = .password
        }
}
.padding()
.background(Color.white)
.cornerRadius(10)
.overlay(
    RoundedRectangle(cornerRadius: 10)
        .stroke(getFieldBorderColor(for: .name), lineWidth: 1)
)
                                    
// Password Field
HStack {
    Image(systemName: "lock.fill")
    .foregroundColor(Color.appPrimaryBlue)

   if isPasswordVisible {
     TextField("Enter Your Password", text: $password)
    .focused($focusedField, equals: .password)
} else {
    
SecureField("Enter Your Password", text: $password)
.focused($focusedField, equals: .password)
}

Button(action: {
    
isPasswordVisible.toggle()
})
{
Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
.foregroundColor(Color.appPrimaryBlue)
}
}
.padding()
.background(Color.white)
.cornerRadius(10)
.overlay(
    RoundedRectangle(cornerRadius: 10)
.stroke(getFieldBorderColor(for: .password),
    lineWidth: 1)
)
                                    
// Sign In Button
Button(action: {
    signIn()
})
{
    HStack {
        if isLoading {
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(0.8)
        }
        Text("Sign In")
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .semibold))
        
    }
.frame(maxWidth: .infinity)
.padding()
.background(isFormValid() ? Color.appPrimaryBlue : Color.appPrimaryBlue.opacity(0.6))
.cornerRadius(10)
}
.disabled(!isFormValid() || isLoading)

// Create New Account Button
Button(action: {
    // Handle create new account
    showCreateAccountAlert()
})
{
    Text("Create New Account")
        .foregroundColor(Color.appPrimaryBlue)
        .font(.system(size: 14, weight: .semibold))
}
.padding(.top, 8)
                                    
    if !name.isEmpty || !password.isEmpty {
        VStack(alignment: .leading, spacing: 4) {
            if !isUsernameValid() && !name.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.caption)
                    Text("Username must be at least 3 characters")
                        .font(.caption)
                        .foregroundColor(.red)
                }
            }
            
            if !isPasswordValid() && !password.isEmpty {
                HStack {
                    Image(systemName: "exclamationmark.circle.fill")
                        .foregroundColor(.red)
                        .font(.caption)
                    Text("Password must be at least 6 characters")
                        .font(.caption)
                        .foregroundColor(.red)
                }
                
            }
        }
        .padding(.horizontal, 4)
        
    }
                    
}
.padding(.horizontal, 24)
            }
        }
    }
}
.alert(alertTitle, isPresented: $showAlert) {
    Button("OK") {
        if isLoginSuccessful {
            // Handle successful login navigation here
            print("Navigate to main app")
        }
    }
    } message: {
        Text(alertMessage)
    }
    .onTapGesture {
                focusedField = nil
    }
}
            

private func isUsernameValid() -> Bool {
return name.count >= 3
}
            
    private func isPasswordValid() -> Bool {
        return password.count >= 6
        
    }
            
private func isFormValid() -> Bool {
    return isUsernameValid() && isPasswordValid()
}
            
private func getFieldBorderColor(for field: Field) -> Color {
switch field {
case .name:
    if name.isEmpty {
        return Color.appPrimaryBlue
    }
    return isUsernameValid() ? Color.green : Color.red
case .password:
    if password.isEmpty {
        return Color.appPrimaryBlue
    }
        return isPasswordValid() ? Color.green : Color.red
    }
        }
                        
private func signIn() {
    
    focusedField = nil
    
    isLoading = true
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
        isLoading = false
        
        if name.lowercased() == validUsername.lowercased() && password == validPassword {
            // Successful login
            isLoginSuccessful = true
            alertTitle = "Login Successful"
            alertMessage = "Welcome back! You have successfully signed in."
            showAlert = true
        } else
        
        {
        
            isLoginSuccessful = false
            alertTitle = "Login Failed"
            alertMessage = "Invalid username or password. Please try again."
            showAlert = true
            
       //clear passward after login fail
            password = ""
                    }
                }
            }
            
            private func showCreateAccountAlert() {
                alertTitle = "Coming Soon"
                alertMessage = "Account creation feature will be available soon."
                showAlert = true
            }
        }

        struct CurvedBottomShape: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                
                path.move(to: .zero)
                path.addLine(to: CGPoint(x: 0, y: rect.height - 100))
                path.addQuadCurve(
                    to: CGPoint(x: rect.width, y: rect.height - 100),
                    control: CGPoint(x: rect.width / 2, y: rect.height + 80)
                )
                path.addLine(to: CGPoint(x: rect.width, y: 0))
                path.closeSubpath()
                
                return path

    }
}

#Preview {
    SignInView()
}
