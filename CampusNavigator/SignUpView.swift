//
//  SignUpView.swift
//  CampusNavigator
//
//  Created by Chathuri Maduka on 2025-06-04.
//

import SwiftUI

struct SignUpView: View {
    @State private var name: String = ""
    @State private var indexNumber: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    @State private var navigateToLogin = false

    var body: some View {
       
GeometryReader { geometry in
   ZStack {

Color.appBackgroundGray
.ignoresSafeArea()

ScrollView(.vertical, showsIndicators: false) {
VStack(spacing: 0) {
ZStack {

Color.appPrimaryBlue
   .clipShape(CurvedBottomShape())
   .frame(height: min(280, geometry.size.height * 0.35))

VStack {
   Spacer()
   
  
       Text("Sign Up")
           .font(.largeTitle)
           .fontWeight(.semibold)
           .foregroundColor(Color.appWhite)
           .padding(.bottom, 40)
   }
   .frame(height: min(280, geometry.size.height * 0.35))
}


VStack(spacing: 20) {

   Spacer()
       .frame(height: 20)
   
   VStack(spacing: 16) {
       // Name field
       CustomInputField(
           icon: "person.fill",
           placeholder: "Enter Your Name",
           text: $name,
           primaryColor: Color.appPrimaryBlue
       )
       .textContentType(.name)
       .autocapitalization(.words)
       
       CustomInputField(
           icon: "person.badge.key.fill",
           placeholder: "Enter Your Index",
           text: $indexNumber,
           primaryColor: Color.appPrimaryBlue
)
.keyboardType(.numberPad)
.textContentType(.username)

CustomPasswordField(
   icon: "lock.fill",
   placeholder: "Password",
   text: $password,
   isVisible: $isPasswordVisible,
   primaryColor: Color.appPrimaryBlue
)
.textContentType(.newPassword)

CustomPasswordField(
   icon: "lock.fill",
   placeholder: "Confirm Password",
   text: $confirmPassword,
   isVisible: $isConfirmPasswordVisible,
   primaryColor: Color.appPrimaryBlue
)
.textContentType(.newPassword)
}
.padding(.horizontal, 24)

Button(action: signUpAction) {
HStack {
   Text("Create Account")
       .font(.headline)
       .fontWeight(.semibold)
   
   Image(systemName: "arrow.right")
       .font(.system(size: 16, weight: .semibold))
}
.foregroundColor(Color.appWhite)
               .frame(maxWidth: .infinity)
               .frame(height: 50)
               .background(Color.appPrimaryBlue)
               .cornerRadius(12)
           }
           .padding(.horizontal, 24)
           .padding(.top, 8)
           
           HStack {
               Text("Already have an account?")
                   .font(.subheadline)
                   .foregroundColor(Color.appTextGray)
               
               Button(action: loginAction) {
                   Text("Sign In")
                       .font(.subheadline)
                       .fontWeight(.medium)
                       .foregroundColor(Color.appPrimaryBlue)
               }
           }
           .padding(.top, 16)
           
        
           Spacer()
               .frame(height: 40)
       }
   }
}
.scrollDismissesKeyboard(.interactively)
   }
}
.alert(alertTitle, isPresented: $showAlert) {
   Button("OK") { }
} message: {
   Text(alertMessage)
}
}

private func signUpAction() {
UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)

if let validationError = validateForm() {
   alertTitle = "Invalid Input"
   alertMessage = validationError
   showAlert = true
   return
}

alertTitle = "Success"
alertMessage = "Account created successfully! Welcome, \(name)!"
showAlert = true

// Clear form after successful signup
DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
   clearForm()
}
}
           
private func validateForm() -> String? {

if name.trimmingCharacters(in: .whitespaces).isEmpty {
return "Please enter your full name"
}

if indexNumber.trimmingCharacters(in: .whitespaces).isEmpty {
return "Please enter your student index number"
}

if password.isEmpty {
return "Please enter a password"
}

if confirmPassword.isEmpty {
return "Please confirm your password"
}

let nameRegex = "^[a-zA-Z\\s]{2,50}$"
let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
if !namePredicate.evaluate(with: name.trimmingCharacters(in: .whitespaces)) {
return "Name must contain only letters and spaces (2-50 characters)"
}

let indexRegex = "^[a-zA-Z]{1,15}[0-9]{1,5}[a-zA-Z]{1,5}[0-9]{1,10}[a-zA-Z]{1,5}-[0-9]{1,10}$"
let indexPredicate = NSPredicate(format: "SELF MATCHES %@", indexRegex)
if !indexPredicate.evaluate(with: indexNumber.trimmingCharacters(in: .whitespaces)) {
return "Index number must follow format: cobsccomp4y222p-068"
}

if password.count < 8 {
return "Password must be at least 8 characters long"
}

if password.count > 128 {
return "Password must be less than 128 characters"
}


let hasLetter = password.rangeOfCharacter(from: .letters) != nil
let hasNumber = password.rangeOfCharacter(from: .decimalDigits) != nil
let hasSpecialChar = password.rangeOfCharacter(from: CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:,.<>?")) != nil

if !hasLetter {
return "Password must contain at least one letter"
}

if !hasNumber {
return "Password must contain at least one number"
}

if !hasSpecialChar {
return "Password must contain at least one special character"
}

if password != confirmPassword {
return "Passwords do not match"
}

let weakPasswords = ["12345678", "password123", "qwerty123", "abc12345"]
if weakPasswords.contains(password.lowercased()) {
return "This password is too common. Please choose a stronger password"
}

return nil
}

private func loginAction() {
// Implement navigation to login screen
print("Navigate to login")
    navigateToLogin = true
}

private func clearForm() {
name = ""
indexNumber = ""
password = ""
confirmPassword = ""
isPasswordVisible = false
isConfirmPasswordVisible = false
}
}


struct CustomInputField: View {
let icon: String
let placeholder: String
@Binding var text: String
let primaryColor: Color

var body: some View {
  HStack(spacing: 12) {
      
        Image(systemName: icon)
        .foregroundColor(primaryColor)
        .frame(width: 20)
        .font(.system(size: 16))

        TextField(placeholder, text: $text)
        .font(.system(size: 16))
        .foregroundColor(Color.appBlack)
    }
.padding(.horizontal, 16)
.padding(.vertical, 16)
.background(Color.appWhite)
.cornerRadius(12)
.overlay(
RoundedRectangle(cornerRadius: 12)
.stroke(Color.appBorderGray, lineWidth: 1)
)
.shadow(color: Color.appBlack.opacity(0.04), radius: 4, x: 0, y: 2)
}
}

struct CustomPasswordField: View {
            let icon: String
            let placeholder: String
            @Binding var text: String
            @Binding var isVisible: Bool
            let primaryColor: Color

var body: some View {
HStack(spacing: 12) {
Image(systemName: icon)
.foregroundColor(primaryColor)
.frame(width: 20)
.font(.system(size: 16))

Group {
if isVisible {
        TextField(placeholder, text: $text)
}
else {
  SecureField(placeholder, text: $text)
}
    
}
.font(.system(size: 16))
.foregroundColor(Color.appBlack)

Button(action:
        {
isVisible.toggle()
})
    {
Image(systemName: isVisible ? "eye.slash.fill" : "eye.fill")
.foregroundColor(Color.appDarkGray)
.font(.system(size: 16))
}
}
.padding(.horizontal, 16)
.padding(.vertical, 16)
.background(Color.appWhite)
.cornerRadius(12)
.overlay(
RoundedRectangle(cornerRadius: 12)
.stroke(Color.appBorderGray, lineWidth: 1)
)
.shadow(color: Color.appBlack.opacity(0.04), radius: 4, x: 0, y: 2)
}

struct CurvedBottomShape: Shape {
func path(in rect: CGRect) -> Path {
var path = Path()

path.move(to: CGPoint(x: 0, y: 0))
path.addLine(to: CGPoint(x: rect.width, y: 0))
path.addLine(to: CGPoint(x: rect.width, y: rect.height - 60))

path.addQuadCurve(
to: CGPoint(x: 0, y: rect.height - 60),
control: CGPoint(x: rect.width / 2, y: rect.height + 20)
)

path.addLine(to: CGPoint(x: 0, y: 0))

return path
}


}


}
#Preview {
    SignUpView()
}
