import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf_reader/features/app_theme.dart';
import 'package:pdf_reader/view/widget/responsive_text.dart';

extension ResponsiveTextStyle on BuildContext {
  // Heading Styles

  TextStyle get h1 => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 15),
    fontWeight: FontWeight.w900,
    color: TextColor.primaryColor,
  );

  TextStyle get h2 => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 11),
    fontWeight: FontWeight.w500,
    color: TextColor.primaryColor,
  );

  //Body Styles

  TextStyle get bodyLarge => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 18),
    color: TextColor.primaryColor,
  );

  TextStyle get bodyMedium => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 16),
    color: TextColor.primaryColor,
  );

  TextStyle get bodySmall => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 12),
    color: TextColor.primaryColor,
  );

  TextStyle get bodySmallDark => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 12),
    color: TextColor.secondaryColor,
  );

  TextStyle get bodySmallDarkBold => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 12),
    fontWeight: FontWeight.w600,
    color: TextColor.secondaryColor,
  );

  TextStyle get bodySmallBold => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 12),
    fontWeight: FontWeight.bold,
    color: TextColor.primaryColor,
  );

  TextStyle get textSmall => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 9),
    color: TextColor.primaryColor,
  );

  TextStyle get textSmallBold => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 9),
    fontWeight: FontWeight.bold,
    color: TextColor.primaryColor,
  );

  TextStyle get bodyIconButton => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 9),
    fontWeight: FontWeight.w600,
    color: TextColor.primaryColor,
  );

  TextStyle get bodyMediumFont => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 13),
    fontWeight: FontWeight.w600,
    color: TextColor.secondaryColor,
  );

  // Footer styles

  TextStyle get footerMediumFont => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 12),
    fontWeight: FontWeight.w600,
    color: TextColor.primaryColor,
  );

  TextStyle get footerMediumFontSemiBold => GoogleFonts.jetBrainsMono(
    fontSize: ResponsiveText.getSize(this, 12),
    fontWeight: FontWeight.w400,
    color: TextColor.secondaryColor,
  );
}
