//
//  ViewState.swift
//  avitoTestiOS_Shapovalov
//
//  Created by Aleksandr Shapovalov on 27/08/23.
//

import Foundation

/// Enum to represent the current state of the view
/// - loading: Indicates that data is currently being fetched or processed
/// - error: Indicates that an error occurred, contains an associated Error value
/// - content: Indicates that content is available to display
enum ViewState {
    case loading
    case error(Error)
    case content
}
