# JSON pointer

A simple JSON-pointer package.

## Example

```
import json-pointer show *

main:
  pointer := (JsonPointer)["foo"][0]["bar"]
  print pointer.to-string  // => "/foo/0/bar".
```
