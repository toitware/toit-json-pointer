// Copyright (C) 2025 Toit contributors.
// Use of this source code is governed by an MIT-style license that can be
// found in the package's LICENSE file.

import encoding.url

/**
JSON Pointer implementation following RFC 6901.
*/

/**
A JSON Pointer as per RFC 6901.
*/
class JsonPointer:
  segments/List

  constructor:
    segments = [""]

  constructor.with-segments .segments:

  /**
  Appends the given $segment to this JSON pointer and returns a new JSON pointer.
  */
  operator + segment/string -> JsonPointer:
    escaped := escape_ segment
    new-segments := segments.copy
    new-segments.add escaped
    return JsonPointer.with-segments new-segments

  /**
  Index operator to append a segment to this JSON pointer.
  Similar to $+ but supports both string and integer segments.
  */
  operator [] segment/any -> JsonPointer:
    if segment is string:
      return this + segment
    else if segment is int:
      return this + "$segment"
    else:
      throw "Invalid segment type"

  static escape_ str/string -> string:
    str = str.replace --all "~" "~0"
    str = str.replace --all "/" "~1"
    return str

  /**
  Converts this JSON pointer to its string representation.
  */
  to-string -> string:
    return segments.join "/"

  /**
  Converts this JSON pointer to a URI fragment identifier as per RFC 6901.
  */
  to-fragment-string -> string:
    return (segments.map: url.encode it).join "/"

  stringify -> string:
    return to-string
