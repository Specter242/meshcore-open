import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:linkify/linkify.dart';

import '../helpers/link_handler.dart';

final RegExp _scopePattern = RegExp(
  r'(?:^|\s)(@(?:global|local|group:[A-Za-z0-9_-]{1,32}))(?=\s|$)',
  caseSensitive: false,
);

class ScopeLinkify extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextStyle? linkStyle;
  final TextStyle? scopeStyle;
  final Color? scopeBackground;

  const ScopeLinkify({
    super.key,
    required this.text,
    this.style,
    this.linkStyle,
    this.scopeStyle,
    this.scopeBackground,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final defaultStyle = style ?? DefaultTextStyle.of(context).style;
    final effectiveLinkStyle = linkStyle ??
        const TextStyle(
          color: Colors.green,
          decoration: TextDecoration.underline,
        );
    final effectiveScopeBackground =
        scopeBackground ?? colorScheme.tertiaryContainer;
    final effectiveScopeStyle = scopeStyle ??
        TextStyle(
          fontWeight: FontWeight.w700,
          color: colorScheme.onTertiaryContainer,
          backgroundColor: effectiveScopeBackground,
        );

    final elements = linkify(
      text,
      options: const LinkifyOptions(humanize: false, defaultToHttps: false),
      linkifiers: const [UrlLinkifier()],
    );

    final spans = <InlineSpan>[];
    for (final element in elements) {
      if (element is UrlElement) {
        spans.add(TextSpan(
          text: element.text,
          style: defaultStyle.merge(effectiveLinkStyle),
          recognizer: TapGestureRecognizer()
            ..onTap = () => LinkHandler.handleLinkTap(context, element.url),
        ));
      } else {
        _addTextWithScopeHighlights(
          element.text,
          defaultStyle,
          effectiveScopeStyle,
          spans,
        );
      }
    }

    return Text.rich(
      TextSpan(children: spans),
    );
  }

  void _addTextWithScopeHighlights(
    String segment,
    TextStyle baseStyle,
    TextStyle scopeTextStyle,
    List<InlineSpan> spans,
  ) {
    var cursor = 0;
    for (final match in _scopePattern.allMatches(segment)) {
      final tokenStart = match.start;
      final tokenGroup = match.group(1)!;
      final tokenStartInSegment = segment.indexOf(tokenGroup, tokenStart);

      if (tokenStartInSegment > cursor) {
        spans.add(TextSpan(
          text: segment.substring(cursor, tokenStartInSegment),
          style: baseStyle,
        ));
      }

      spans.add(WidgetSpan(
        alignment: PlaceholderAlignment.baseline,
        baseline: TextBaseline.alphabetic,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
          decoration: BoxDecoration(
            color: scopeTextStyle.backgroundColor,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            tokenGroup,
            style: scopeTextStyle.copyWith(backgroundColor: null),
          ),
        ),
      ));

      cursor = tokenStartInSegment + tokenGroup.length;
    }

    if (cursor < segment.length) {
      spans.add(TextSpan(
        text: segment.substring(cursor),
        style: baseStyle,
      ));
    }
  }
}
