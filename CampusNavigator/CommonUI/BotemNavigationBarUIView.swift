//
//  BotemNavigationBarUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI

struct TabItem {
    let id = UUID()
    let iconName: String
    let title: String
    let isSelected: Bool
}


struct BotemNavigationBarUIView: View {
    
    @Binding var selectedTab: Int
    let onTabSelected: (Int) -> Void
        
    private let icons = [ "house.fill","bell.fill", "location.fill", "list.bullet.rectangle", "person.fill"]
    
    var body: some View {
        
        HStack(spacing: 0) {
            
            
                            ForEach(Array(icons.enumerated()), id: \.offset) { index, iconName in
                                Button(action: {
                                    withAnimation(.easeInOut(duration: 0.3)) {
                                        selectedTab = index
                                        onTabSelected(index)
                                    }
                                }) {
                                    VStack(spacing: 2) {
                                        Image(systemName: iconName)
                                            .font(.appTitle3Bold)
                                            .foregroundColor(selectedTab == index ? .appWhite : .appPrimaryBlue)
                                            .frame(width: 24, height: 24)
                                        
                                        // for dot indicator
                                        Circle()
                                            .fill(selectedTab == index ? Color.appWhite : Color.clear)
                                            .frame(width: 4, height: 4)
                                    }
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 12)
                                    .background(
                                        selectedTab == index ?
                                        Circle()
                                            .fill(Color.appWhite.opacity(0.2))
                                            .frame(width: 50, height: 50) :
                                        nil
                                    )
                                }
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 8)
                        .background(
                            RoundedRectangle(cornerRadius: 25)
                                .fill(Color.appLightBlue)
                                .shadow(color: Color.appBlack.opacity(0.1), radius: 10, x: 0, y: 5)
                        )
                        .padding(.horizontal, 16)
                        .padding(.bottom, 30)
        
    }
}

