//
//  LibraryView.swift
//  CampusNavigator
//
//  Created by Chathuri Maduka on 2025-06-07.
//

import SwiftUI

struct LibraryView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showNavigationPage = false
        @State private var showSeatBookingPage = false
    var body: some View {
        
        ZStack {
                     Color.appBackgroundGray
                         .ignoresSafeArea()
                     
                     VStack(spacing: 0) {
                        
                         ZStack {
                           
                             HStack {
                                 Button(action: {
                                     presentationMode.wrappedValue.dismiss()
                                 }) {
                                     Image(.image2)
                                         .font(.system(size: 18, weight: .semibold))
                                         .foregroundColor(.appPrimaryBlue)
                                 }
                                 Spacer()
                             }
                             
                             
                             Text("Library")
                                 .font(.appTitle1Bold)
                                 .foregroundColor(.appPrimaryBlue)
                         }
                                     .padding(.horizontal, 16)
                                     .padding(.vertical, 36)
                                     .background(Color.appBackgroundGray)
                                     
                    
                     ScrollView {
                         VStack(spacing: 10) {
                             
                             Image(.image1)
                                 .resizable()
                                 .aspectRatio(contentMode: .fill)
                                 .frame(height: 250)
                                 .clipped()
                                 .cornerRadius(16)
                                 .padding(.horizontal, 16)
                                 .padding(.top, 8)
                                             
                          
                             VStack(spacing: 16) {
                                 
                                 HStack {
                                     Text("Seat Availability :")
                                         .font(.appSubheadlineSemibold)
                                         .foregroundColor(Color.appBlack)
                                     Spacer()
                                     Text("20 out of 40")
                                                         .font(.appSubheadlineSemibold)
                                                         .foregroundColor(Color.appPrimaryBlue)
                                                 }
                                                 
                                                 Divider()
                                                     .background(Color.appBorderGray.opacity(0.3))
                                                 
                                                 
                                                 HStack {
                                                     Text("Floor :")
                                                         .font(.appSubheadlineSemibold)
                                                         .foregroundColor(Color.appBlack)
                                                     Spacer()
                                                     Text("3rd Floor")
                                                         .font(.appSubheadlineRegular)
                                                         .foregroundColor(Color.appTextGray)
                                                 }
                                                 
                                                 Divider()
                                                     .background(Color.appBorderGray.opacity(0.3))
                                                 
                                               
                                                 VStack(alignment: .leading, spacing: 8) {
                                                     HStack {
                                                         Text("Facilities :")
                                                             .font(.appSubheadlineSemibold)
                                                             .foregroundColor(Color.appBlack)
                                                         Spacer()
                                                     }
                                                     
                                                     HStack(spacing: 20) {
                                                         Image(.image5)
                                                             .font(.system(size: 20))
                                                             .foregroundColor(Color.appPrimaryBlue)
                                                         
                                                         Image(.image4)
                                                             .font(.system(size: 20))
                                                             .foregroundColor(Color.appPrimaryBlue)
                                                         
                                                         Image(.image3)
                                                             .font(.system(size: 20))
                                                             .foregroundColor(Color.appPrimaryBlue)
                                                         
                                                         Spacer()
                                                     }
                                                     .padding(.leading, 8)
                                                 }
                                                 
                                                 Divider()
                                                     .background(Color.appBorderGray.opacity(0.3))
                                                 
                                                 // Open Hours
                                                 HStack {
                                                     Text("Open Hours :")
                                                         .font(.appSubheadlineSemibold)
                                                         .foregroundColor(Color.appBlack)
                                                     Spacer()
                                                     Text("9:00 A.M. to 4:00 P.M.")
                                                         .font(.appSubheadlineRegular)
                                                         .foregroundColor(Color.appTextGray)
                                                 }
                                                 
                                                 Divider()
                                                     .background(Color.appBorderGray.opacity(0.3))
                                                 
                                                 // Crowd Level
                                                 VStack(alignment: .leading, spacing: 8) {
                                                     HStack {
                                                         Text("Crowd Level")
                                                             .font(.appSubheadlineSemibold)
                                                             .foregroundColor(Color.appBlack)
                                                         Spacer()
                                                     }
                                                     
                                                     VStack(alignment: .leading, spacing: 4) {
                                                         Text("50%")
                                                             .font(.appSubheadlineSemibold)
                                                             .foregroundColor(Color.appBlack)
                                                         
                                                         GeometryReader { geometry in
                                                             ZStack(alignment: .leading) {
                                                                 Rectangle()
                                                                     .frame(width: geometry.size.width, height: 8)
                                                                     .opacity(0.3)
                                                                     .foregroundColor(Color.appBorderGray)
                                                                     .cornerRadius(4)
                                                                 
                                                                 Rectangle()
                                                                     .frame(width: min(CGFloat(0.5) * geometry.size.width, geometry.size.width), height: 8)
                                                                     .foregroundColor(Color.appPrimaryBlue)
                                                                     .cornerRadius(4)
                                                             }
                                                         }
                                                         .frame(height: 8)
                                                     }
                                                 }
                                                 
                                                 // Action Buttons
                                                 HStack(spacing: 12) {
                                                     Button(action: {
                                                         showNavigationPage = true
                                                     }) {
                                                         Text("Navigate")
                                                             .font(.appButtonTitle)
                                                             .foregroundColor(Color.appWhite)
                                                             .frame(maxWidth: .infinity)
                                                             .frame(height: 50)
                                                             .background(Color.appPrimaryBlue)
                                                             .cornerRadius(25)
                                                     }
                                                     
                                                     Button(action: {
                                                         showSeatBookingPage = true
                                                     }) {
                                                         Text("Seat Book")
                                                             .font(.appButtonTitle)
                                                             .foregroundColor(Color.appWhite)
                                                             .frame(maxWidth: .infinity)
                                                             .frame(height: 50)
                                                             .background(Color.appPrimaryBlue)
                                                             .cornerRadius(25)
                                                     }
                                                 }
                                             }
                                             .padding(20)
                                             .background(Color.appLightBlue.opacity(0.15))
                                             .cornerRadius(16)
                                             .overlay(
                                                 RoundedRectangle(cornerRadius: 16)
                                                     .stroke(Color.appBorderGray.opacity(0.2), lineWidth: 1)
                                             )
                                             .padding(.horizontal, 16)
                                             .padding(.top, 12)
                                             .padding(.bottom, 20)
                                         }
                                     }
                                 }
                             }
                             .navigationBarHidden(true)
                             .sheet(isPresented: $showNavigationPage) {
                                 // Replace with your navigation view file name
                                 //YourNavigationView()
                             }
                             .sheet(isPresented: $showSeatBookingPage) {
                                 // Replace with your seat booking view file name
                                // YourSeatBookingView()
                             }
        
    }
}

#Preview {
    LibraryView()
}
