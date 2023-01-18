//
//  CapstoneSnackbar.swift
//  CapstoneProject
//
//  Created by Benaya Oktavianus on 06/12/22.
//

import UIKit
import SnackBar

public final class CapstoneSnackbar: SnackBar {
    public override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .systemBlue
        style.textColor = .white
        return style
    }
}

public final class CapstoneErrorSnackbar: SnackBar {
    public override var style: SnackBarStyle {
        var style = SnackBarStyle()
        style.background = .systemRed
        style.textColor = .white
        return style
    }
}
