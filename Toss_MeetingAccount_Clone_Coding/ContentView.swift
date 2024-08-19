//
//  ContentView.swift
//  Toss_MeetingAccount_Clone_Coding
//
//  Created by OWEN on 8/13/24.
//

import SwiftUI

struct ContentView: View {
    @State private var isPresented: Bool = Bool()
    @State private var offsetY: CGFloat = CGFloat()
    @State private var headerHeight: CGFloat = CGFloat()
    @State private var initOffsetY: CGFloat? = nil
    var onRefresh: () -> Void
    
    var body: some View {
        GeometryReader { screenGeometry in
            ZStack {
                Color.black.ignoresSafeArea()
                
                VStack {
                    ScrollView(showsIndicators: false) {
                        VStack(spacing: 0.0) {
                            Color.clear
                                .frame(height: headerHeight)
                                .overlay(
                                    VStack(spacing: 0) {
                                        Image("image")
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: screenGeometry.size.width, height: 400)
                                            .ignoresSafeArea(edges: .top)
                                            .offset(y: headerHeight + screenGeometry.safeAreaInsets.top - offsetY)
                                            .frame(height: 400)
                                    }
                                )
                            
                            ZStack {
                                Color.black.cornerRadius(35).shadow(color: .black.opacity(0.2), radius: 15, x: 0.0, y: 0.0)
                                    .padding(.bottom, -50).ignoresSafeArea()
                                
                                VStack {
                                    //Handle
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: 48, height: 4)
                                        .background(Color(red: 0.52, green: 0.52, blue: 0.52))
                                        .cornerRadius(30)
                                    
                                    
                                    HStack(spacing: 12) {
                                        VStack {
                                            Image(systemName: "chevron.left")
                                        }
                                        .padding(.all, 4)
                                        .background(Color.white)
                                        .frame(width: 25, height: 25)
                                        
                                        Text("오늘 날짜")
                                            .frame(maxWidth: .infinity, alignment: .center)
                                        
                                        VStack {
                                            Image(systemName: "chevron.right")
                                        }
                                        .padding(.all, 4)
                                        .background(Color.white)
                                        .frame(width: 25, height: 25)
                                    }
                                    .padding(.top, 8)
                                    .padding(.horizontal, 16)
                                    
                                    HStack {
                                        Text("선택 날짜: 2024.03.01")
                                            .foregroundColor(.white)
                                        Spacer()
                                        Button(action: {
                                            print("오늘로 이동")
                                        }, label: {
                                            Text("오늘로 이동")
                                        })
                                    }
                                    .frame(maxWidth: .infinity, alignment: .trailing)
                                    .padding(.horizontal, 16)
                                    
                                    Divider()
                                    
                                    VStack {
                                        ForEach(0..<100, id: \.self) { data in
                                            Text(String(data))
                                                .foregroundColor(.red)
                                        }
                                        Spacer()
                                    }
                                }
                                .frame(minHeight: 700)
                                .padding(.top)
                            }
                            .overlay(
                                GeometryReader { proxy in
                                    Color.clear
                                        .onChange(of: proxy.frame(in: .global).minY) { newValue in
//                                                print("proxy.frame(in: .global).minY: ", proxy.frame(in: .global).minY)
//                                                print("NewValue: ", newValue)
                                            offsetY = newValue
                                            self.initOffsetY = newValue
//                                                if self.initOffsetY == nil {
//                                                    self.initOffsetY = newValue
//                                                }
                                        }
                                }
                            )
                        }
                        
                    }
                    .refreshable {
                        onRefresh()
                    }
                }
                
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                        Image(systemName: "chevron.down")
                    }
                }
            }
            .position(x: screenGeometry.size.width/2, y: screenGeometry.size.height/2)
            .alert(isPresented: $isPresented) { Alert(title: Text("Button tapped")) }
            .statusBar(hidden: true)
        }
    }
}

// PreferenceKey를 사용하여 ScrollView의 offset을 추적
struct OffsetKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
#Preview {
    ContentView {
        
    }
}
