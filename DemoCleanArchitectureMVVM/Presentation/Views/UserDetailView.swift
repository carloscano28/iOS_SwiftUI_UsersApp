//
//  UserDetailView.swift
//  DemoCleanArchitectureMVVM
//
//  Created by Carlos R on 30/06/25.
//

import SwiftUI

struct UserDetailView: View {
    let user: User

    var body: some View {
        VStack(spacing: 16) {
            Text(user.name)
                .font(.largeTitle)
                .fontWeight(.bold)

            Text(user.email)
                .font(.title3)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle("User Detail")
    }
}
