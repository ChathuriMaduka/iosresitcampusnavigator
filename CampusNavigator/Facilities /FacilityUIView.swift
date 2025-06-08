//
//  FacilityUIView.swift
//  CampusNavigator
//
//  Created by Tharangani Hagoda Arachchi on 07/06/2025.
//

import SwiftUI

struct FacilityUIView: View {
    @State private var selectedTab = 0
    @State private var selectedBottomTab = 3
    @Environment(\.presentationMode) var presentationMode
    
    @State private var showHome = false
    @State private var showLocation = false
    @State private var showNotification = false
    @State private var showProfile = false
    @State private var showFacility = false
    
    @State private var showFacilityDetail = false
    @State private var showLibraryView = false
    @State private var showCafeteriaView = false
    
    let facilities = [
        FacilityItem(
            title: "iOS Lab",
            message: "Avalability : Available",
            updatedTime: "5mins ago",
        ),
        FacilityItem(
            title: "Network Lab",
            message: "Avalability : Available",
            updatedTime: "5mins ago",
        ),
        FacilityItem(
            title: "IOT Lab",
            message: "Avalability : Available",
            updatedTime: "5mins ago",
        ),
        FacilityItem(
            title: "Library",
            message: "Avalability : Full",
            updatedTime: "5mins ago",
        ),
        FacilityItem(
            title: "Cafeteria",
            message: "Avalability : Full",
            updatedTime: "5mins ago",
        ),
        
    ]

    var body: some View {
        NavigationView{
                   VStack(spacing: 0) {
                       HStack(spacing: 12) {
                           ForEach(Array(["Labs", "Library", "Cafeteria"].enumerated()), id: \.offset) { index, title in
                               Button(action: {
                                   selectedTab = index
                               }) {
                                   Text(title)
                                       .font(.system(size: 16, weight: .medium))
                                       .foregroundColor(selectedTab == index ? .appWhite : .appPrimaryBlue)
                                       .padding(.horizontal, 24)
                                       .padding(.vertical, 10)
                                       .background(
                                           selectedTab == index ? Color.appPrimaryBlue : Color.clear
                                       )
                                       .overlay(
                                           RoundedRectangle(cornerRadius: 20)
                                               .stroke(Color.appPrimaryBlue, lineWidth: 1)
                                       )
                                       .cornerRadius(20)
                                   
                               }
                           }
                           Spacer()
                       }
                       .padding(.horizontal, 16)
                       .padding(.top, 16)
                       
                       ScrollView {
                           LazyVStack(spacing: 20) {
                               ForEach(getFilteredFacility(), id: \.id) { facility in
                                   FacilityCardUIView(facility: facility) {
                                       handleViewMoreTapped(for: facility)
                                   }
                               }
                           }
                           .padding(.horizontal, 16)
                           .padding(.top, 30)
                           
                       }
                       BotemNavigationBarUIView(selectedTab: $selectedBottomTab) { index in
                           handleBottomTabSelection(index)
                       }
                       
                       Spacer()

                   }
            
                   .navigationTitle("Facilities")
                                      .navigationBarTitleDisplayMode(.inline)
                                      .navigationBarBackButtonHidden(true)
                                      .toolbar {
                                          ToolbarItem(placement: .navigationBarLeading) {
                                              Button(action: {
                                                  presentationMode.wrappedValue.dismiss()
                                              }) {
                                                  HStack(spacing: 4) {
                                                      Image(systemName: "arrow.left")
                                                          .foregroundColor(.appPrimaryBlue)
                                                          .font(.appBodySemibold)
                                                                                                        }
                                              }
                                          }
                                      }
                                      .toolbarColorScheme(.light)
                                      .toolbarBackground(Color.clear, for: .navigationBar)

                                      .onAppear {
                                          let appearance = UINavigationBarAppearance()
                                          appearance.configureWithTransparentBackground()
                                          appearance.titleTextAttributes = [
                                            .foregroundColor: UIColor.red,
                                              .font: UIFont.systemFont(ofSize: 18, weight: .semibold)
                                          ]
                                          
                                          UINavigationBar.appearance().standardAppearance = appearance
                                          UINavigationBar.appearance().scrollEdgeAppearance = appearance
                   }
            
            
                                      .fullScreenCover(isPresented: $showFacility) {
                                          FacilityUIView()
                                      }
                                      .fullScreenCover(isPresented: $showFacilityDetail) {
                                          FacilityDetailView()
                                      }
                                      .fullScreenCover(isPresented: $showLocation) {
                                         CampusNavigationView()
                                      }
                                                         
                                      .fullScreenCover(isPresented: $showLibraryView) {
                                            LibraryView()
                                       }
                                                         
                                      .fullScreenCover(isPresented: $showCafeteriaView) {
                                            CafeteriaView()
                                       }
                                     .fullScreenCover(isPresented: $showHome) {
                                         HomeScreenView()
                                     }
                                     .fullScreenCover(isPresented: $showNotification) {
                                         NotificationUIView()
                                     }
                                     .fullScreenCover(isPresented: $showProfile) {
                                         ProfileDetailsView()
                                     }
            
            

               }
    }
    private func getFilteredFacility() -> [FacilityItem] {
        switch selectedTab {
        case 0: // lab
            return Array(facilities.prefix(3))
        case 1: // library
            return Array(facilities.dropFirst(3).prefix(1))
        case 2: // cafe
            return Array(facilities.dropFirst(4).prefix(1))
        default:
            return facilities
        }
    }
    private func handleViewMoreTapped(for facility: FacilityItem) {
        switch facility.title {
                case "iOS Lab", "Network Lab", "IOT Lab":
                    showFacilityDetail = true
                    
                case "Library":
                    showLibraryView = true
                    
                case "Cafeteria":
                    showCafeteriaView = true
                    
                default:
                    print("Unknown facility: \(facility.title)")
                }

        
}
private func handleBottomTabSelection(_ index: Int) {
    
print("Bottom tab selected: \(index)")

switch index {
case 0: // home
    showHome = true
    
case 1: // notification
    showNotification = true
    
case 2: // Location
    showLocation = true
    
case 3: // facilities
    showFacility = false

case 4:
    showProfile = true// Profile

default:
    break
}

}

}

#Preview {
    FacilityUIView()
}
