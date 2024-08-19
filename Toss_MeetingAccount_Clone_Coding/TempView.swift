//
//  TempView.swift
//  Toss_MeetingAccount_Clone_Coding
//
//  Created by OWEN on 8/19/24.
//

import SwiftUI

struct TempView: View {
    @State private var scrollOffset: CGFloat = 0
    @State private var isRefresh: Bool = false
    @State private var downloadAmount : Double = 0.0
    @State private var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        ScrollViewReader { scrollReader in
            GeometryReader { geoReader in
                ZStack {
                    VStack {
                        if isRefresh {
                            ProgressView("새로고침중...", value: downloadAmount, total: 100)
                                .padding()
                                .onReceive(timer) { _ in
                                    if downloadAmount < 100 {
                                        downloadAmount += 5
                                    } else if downloadAmount == 100 {
                                        self.downloadAmount = 0
                                        withAnimation {
                                            self.isRefresh = false
                                        }
                                    }
                                }
                        }
                        HStack {
                            ZStack {
                                Image("image")
                                    .resizable()
                                    .scaledToFit()
                                Circle()
                                    .fill(LinearGradient(colors: [.gray, .white], startPoint: .topLeading, endPoint: .bottomTrailing))
                                    .frame(width: 200, height: 200)
                                    
                            }
                        }
                        .frame(maxWidth: .infinity)
                        .padding(.top, 0)
                        .ignoresSafeArea()
                        Spacer()
                    }
                }
                ScrollView {
                    VStack {
                        Color.clear.frame(height: 300)
                        ZStack {
                            Color.red
                            VStack {
                                ForEach(0..<100, id: \.self) { data in
                                    Text(String(data))
                                        .foregroundColor(.green)
                                }
                            }
                        }
                    }
                    .frame(minHeight: 700)
                    .padding(.top)
                }
                .refreshable {
                    withAnimation {
                        isRefresh = true
                    }
                }
                
            }
        }
    }
}

#Preview {
    TempView()
}
