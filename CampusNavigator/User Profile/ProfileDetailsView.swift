//
//  ProfileDetailsView.swift
//  CampusNavigator
//
//  Created by Malsha Bopage on 2025-06-07.
//

import SwiftUI

struct ProfileDetailsView: View {
    @State private var name = "Chathuri Maduka"
    @State private var department = "Computing"
    @State private var batch = "COBSCCOMP222P"
    @State private var index = "COBSCCOMP222P - 012"
    @State private var location = "Program Office, 4th floor"
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.appBackgroundGray
                    .ignoresSafeArea()
                
                VStack(spacing: 0) {
                   
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(.image2)
                                .font(.appTitle3Semibold)
                                .foregroundColor(.appPrimaryBlue)
                        }
                        
                        Spacer()
                        
                        Text("Profile Details")
                            .font(.appTitle3Semibold)
                            .foregroundColor(.appPrimaryBlue)
                        
                        Spacer()
                        
                       
                        Image(systemName: "chevron.left")
                            .font(.appTitle3Semibold)
                            .opacity(0)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                    .background(Color.appWhite)
                    
                    ScrollView {
                        VStack(spacing: 24) {
                           
                            VStack(spacing: 16) {
                                ZStack {
                                    Circle()
                                        .fill(Color.appLightGray)
                                        .frame(width: 100, height: 100)
                                    
                                   
                                    Image(systemName: "person.circle.fill")
                                        .font(.system(size: 100))
                                        .foregroundColor(.appDarkGray.opacity(0.3))
                                    
                                   
                                    VStack {
                                        Spacer()
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                             
                                            }) {
                                                Circle()
                                                    .fill(Color.appWhite)
                                                    .frame(width: 32, height: 32)
                                                    .overlay(
                                                        Image(systemName: "camera.fill")
                                                            .font(.system(size: 16))
                                                            .foregroundColor(.appDarkGray)
                                                    )
                                                    .shadow(color: .black.opacity(0.1), radius: 2, x: 0, y: 1)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.top, 20)
                            
                          
                            VStack(spacing: 20) {
                                ProfileTextField(
                                    title: "Your Name",
                                    text: $name
                                )
                                
                                ProfileTextField(
                                    title: "Your Department",
                                    text: $department
                                )
                                
                                ProfileTextField(
                                    title: "Your Batch",
                                    text: $batch
                                )
                                
                                ProfileTextField(
                                    title: "Your Index",
                                    text: $index
                                )
                                
                                ProfileTextField(
                                    title: "Your Current Location",
                                    text: $location
                                )
                            }
                            .padding(.horizontal, 16)
                            
                           
                            Button(action: {
                               
                                saveChanges()
                            }) {
                                Text("Save Changes")
                                    .font(.appButtonTitle)
                                    .foregroundColor(.appWhite)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .background(Color.appPrimaryBlue)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 10)
                            .padding(.bottom, 30)
                        }
                    }
                }
            }
        }
        .navigationBarHidden(true)
    }
    
    private func saveChanges() {
       
        print("Saving changes...")
      
    }
}

struct ProfileTextField: View {
    let title: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.appCalloutRegular)
                .foregroundColor(.appPrimaryBlue)
            
            TextField("", text: $text)
                .font(.appInputField)
                .foregroundColor(.appPrimaryBlue)
                .padding(.horizontal, 16)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.appLightBlue.opacity(0.15))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(Color.appLightBlue.opacity(0.3), lineWidth: 1)
                        )
                )
        }
    }
}


#Preview {
    ProfileDetailsView()
}
