import 'package:flutter/material.dart';
import 'package:BOOC/core/utils/size_utils.dart';
import 'package:BOOC/theme/theme_helper.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Headline text style
  static get headlineSmallGray80001 => theme.textTheme.headlineSmall!.copyWith(
        color: appTheme.gray80001,
        fontWeight: FontWeight.w600,
      );
  // Righteous text style
  static get righteousOnPrimary => TextStyle(
        color: theme.colorScheme.onPrimary,
        fontSize: 80.fSize,
        fontWeight: FontWeight.w400,
      ).righteous;
  // Title text style
  static get titleMediumPrimaryContainer =>
      theme.textTheme.titleMedium!.copyWith(
        color: theme.colorScheme.primaryContainer,
        fontWeight: FontWeight.w600,
      );
}

extension on TextStyle {
  TextStyle get righteous {
    return copyWith(
      fontFamily: 'Righteous',
    );
  }

  TextStyle get abel {
    return copyWith(
      fontFamily: 'Abel',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }
}
