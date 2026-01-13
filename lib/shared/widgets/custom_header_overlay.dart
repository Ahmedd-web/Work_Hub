// Used by CustomHeader in lib/shared/custom_heaedr.dart.
import 'package:flutter/material.dart';

class CustomHeaderOverlay extends StatelessWidget {
  final Widget? overlayChild;
  final double overlayChildHeight;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchSubmitted;
  final String searchHint;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final Color searchFillColor;

  const CustomHeaderOverlay({
    super.key,
    required this.overlayChild,
    required this.overlayChildHeight,
    required this.searchController,
    required this.onSearchSubmitted,
    required this.searchHint,
    required this.textDirection,
    required this.textAlign,
    required this.searchFillColor,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: -overlayChildHeight / 2,
      child:
          overlayChild != null
              ? SizedBox(height: overlayChildHeight, child: overlayChild)
              : Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(28),
                child: SizedBox(
                  height: overlayChildHeight,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: CustomHeaderSearchBar(
                      controller: searchController,
                      onSearchSubmitted: onSearchSubmitted,
                      searchHint: searchHint,
                      textDirection: textDirection,
                      textAlign: textAlign,
                      searchFillColor: searchFillColor,
                    ),
                  ),
                ),
              ),
    );
  }
}

class CustomHeaderSearchBar extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onSearchSubmitted;
  final String searchHint;
  final TextDirection textDirection;
  final TextAlign textAlign;
  final Color searchFillColor;

  const CustomHeaderSearchBar({
    required this.controller,
    required this.onSearchSubmitted,
    required this.searchHint,
    required this.textDirection,
    required this.textAlign,
    required this.searchFillColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      onSubmitted: onSearchSubmitted,
      textDirection: textDirection,
      textAlign: textAlign,
      decoration: InputDecoration(
        hintText: searchHint,
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(28),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: searchFillColor,
        contentPadding: const EdgeInsets.symmetric(vertical: 14),
      ),
    );
  }
}
