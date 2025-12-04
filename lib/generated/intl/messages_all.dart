import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';
import 'package:intl/src/intl_helpers.dart';

import 'messages_ar.dart' as messages_ar;
import 'messages_en.dart' as messages_en;

typedef Future<dynamic> LibraryLoader();
Map<String, LibraryLoader> deferredLibraries = {
  'ar': () => new SynchronousFuture(null),
  'en': () => new SynchronousFuture(null),
};

MessageLookupByLibrary? findExact(String localeName) {
  switch (localeName) {
    case 'ar':
      return messages_ar.messages;
    case 'en':
      return messages_en.messages;
    default:
      return null;
  }
}

Future<bool> initializeMessages(String localeName) {
  var availableLocale = Intl.verifiedLocale(
    localeName,
    (locale) => deferredLibraries[locale] != null,
    onFailure: (_) => null,
  );
  if (availableLocale == null) {
    return new SynchronousFuture(false);
  }
  var lib = deferredLibraries[availableLocale];
  lib == null ? new SynchronousFuture(false) : lib();
  initializeInternalMessageLookup(() => new CompositeMessageLookup());
  messageLookup.addLocale(availableLocale, findGeneratedMessagesFor);
  return new SynchronousFuture(true);
}

bool messagesExistFor(String locale) {
  try {
    return findExact(locale) != null;
  } catch (e) {
    return false;
  }
}

MessageLookupByLibrary? findGeneratedMessagesFor(String locale) {
  var actualLocale = Intl.verifiedLocale(
    locale,
    messagesExistFor,
    onFailure: (_) => null,
  );
  if (actualLocale == null) return null;
  return findExact(actualLocale);
}
