//
//  WelcomeView.swift
//  CampusNavigator
//
//  Created by Chathuri Maduka on 2025-06-05.
//

import SwiftUI

struct WelcomeView: View {
    
    var illustrationImage: String? = nil
    var useCustomIllustration: Bool = false
    @State private var showSignInView = false
    var body: some View {
        
        GeometryReader { geometry in
                    ZStack {
                        Color.appPrimaryBlue
                            .ignoresSafeArea(.all)

                        VStack(spacing: 0) {
                            VStack {
                                Spacer()

                                Text("WELCOME")
                                    .font(.system(size: 40, weight: .bold, design: .default))
                                    .foregroundColor(.appWhite)
                                    .tracking(3)

                                Spacer()
                            }
                            .frame(height: geometry.size.height * 0.25)

                            ZStack {
                                CurvedTopWhiteSection()
                                    .fill(Color.appWhite)

                                VStack(spacing: 10) {
                                    Spacer().frame(height: 50)

                                    VStack(spacing: 24) {
                                        Image(.image)

                                        VStack(spacing: 10) {
                                            Text("UniFinder")
                                                .font(.system(size: 40, weight: .bold, design: .default))
                                                .foregroundColor(.appPrimaryBlue)

                                            Text("Start Your Journey accurately")
                                                .font(.system(size: 16, weight: .medium, design: .default))
                                                .foregroundColor(.appPrimaryBlue)
                                                .multilineTextAlignment(.center)
                                        }

                                        Spacer()

                                        Button(action: {
                                            showSignInView = true
                                        }) {
                                            Text("Start Exploring")
                                                .font(.system(size: 16, weight: .semibold))
                                                .foregroundColor(.appWhite)
                                                .frame(maxWidth: .infinity)
                                                .frame(height: 50)
                                                .background(Color.appPrimaryBlue)
                                                .cornerRadius(25)
                                        }
                                        .padding(.horizontal, 60)
                                        .padding(.bottom, 40)
                                    }
                                }
                            }
                            .frame(height: geometry.size.height * 0.75)
                        }
                    }
                }
                .sheet(isPresented: $showSignInView) {
                    SignInView()
                }
            }
        }

        struct WelcomeView_Previews: PreviewProvider {
            static var previews: some View {
                WelcomeView()
                    .previewDevice("iPhone 14 Pro")
            }
        }

        struct CurvedTopWhiteSection: Shape {
            func path(in rect: CGRect) -> Path {
                var path = Path()
                let curveHeight: CGFloat = 50
                path.move(to: CGPoint(x: 0, y: curveHeight))
                path.addCurve(
                    to: CGPoint(x: rect.width, y: curveHeight),
                    control1: CGPoint(x: rect.width * 0.3, y: 0),
                    control2: CGPoint(x: rect.width * 0.7, y: 0)
                )
                path.addLine(to: CGPoint(x: rect.width, y: rect.height))
                path.addLine(to: CGPoint(x: 0, y: rect.height))
                path.closeSubpath()
                return path
    }
    
}

#Preview {
    WelcomeView()
}
