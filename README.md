# wren-path

Utility class for the [Wren scripting language](https://wren.io) to work with file and directory paths.

## Usage

``` js
import "path/to/wren-path/Path" for Path

Path.basename("path/to/something.txt") // => something.txt
Path.extname("something.txt") // => .txt
Path.isAbsolute("/path/to/something.txt") // => true
Path.dirname("/path/to/something.txt") // => /path/to
Path.normalize("path/to/other/../something.txt") // => path/to/something.txt
```

## Testing

```
git submodule update --init
wren_cli test.wren
```
