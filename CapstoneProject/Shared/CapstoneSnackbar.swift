//
//  CapstoneSnackbar.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import SnackBar

final class CapstoneSnackbar: SnackBar {
    override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .systemBlue
        style.textColor = .white
        return style
    }
}
