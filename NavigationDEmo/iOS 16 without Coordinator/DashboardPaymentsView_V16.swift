//
//  DashboardPayments_V2.swift
//  NavigationDEmo
//
//  Created by Dmitrii Zverev on 3/3/2025.
//

import SwiftUI

@available(iOS 16.0, *)
struct DashboardPaymentsView_V16: View {
	@StateObject fileprivate var viewModel = DashboardPaymentsViewModel()
	@Binding var selectedTab: TabbarOption
	
    var body: some View {
		VStack {
			switch viewModel.loadingState {
			case .loading(let payment):
				if let payment {
					makeBoby(payment)
				} else {
					ProgressView()
						.frame(height: 50)
				}
			case .loaded(let payment):
				makeBoby(payment)
			case .error(let error):
				ErrorView(error: error)
					.frame(height: 50)
			}
		}
		.animation(.easeInOut, value: viewModel.loadingState.index)
		.task {
			await viewModel.load()
		}
	}
	
	private func makeBoby(_ payment: Payment) -> some View {
		GroupBox("Last payment:") {
			GroupBox {
				NavigationLink(value: payment) {
					PaymentsCardView(payment: payment)
				}
				.tint(.primary)
			}
			GroupBox {
				Button {
					selectedTab = .payments
				} label: {
					HStack {
						Text("See  all")
						Spacer()
					}
				}
				.tint(.primary)
			}
		}
		.transition(.move(edge: .top).combined(with: .opacity).combined(with: .scale))
	}
}

#Preview {
	if #available(iOS 16.0, *) {
		NavigationStack {
			VStack {
				DashboardPaymentsView_V16(selectedTab: .constant(.payments))
				Spacer()
			}
			.addNavigationDestinations()
			.padding()
		}
	}
}
