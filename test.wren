import "./vendor/assert/Assert" for Assert
import "./Path" for Path

var path = "/this/is/a/path/to/something.txt"

// Path.basename(path)
Assert[Path.basename(path), "something.txt"]

// Path.basename(path, ext)
Assert[Path.basename(path, ".txt"), "something"]
Assert[Path.basename("abcdef.txt", ".txt"), "abcdef"]
Assert[Path.basename("abcdef.md", ".txt"), "abcdef.md"]

// Path.dirname()
Assert[Path.dirname(path), "/this/is/a/path/to"]
Assert[Path.dirname("something.txt"), ""]

// Path.join()
Assert[Path.join(["/foo", "bar", "baz/asdf", "quux", ".."]), "/foo/bar/baz/asdf"]

// Path.normalize()
Assert[Path.normalize("/foo/bar//baz/asdf/quux/.."), "/foo/bar/baz/asdf"]
Assert[Path.normalize("foo/bar/../baz/asdf/quux/.."), "foo/baz/asdf"]

// Path.extname()
Assert[Path.extname("index.html"), ".html"]
Assert[Path.extname("index.coffee.md"), ".md"]
Assert[Path.extname("index."), "."]
Assert[Path.extname("index"), ""]
Assert[Path.extname(".index"), ""]
Assert[Path.extname(".index.md"), ".md"]
Assert[Path.extname("/path/to/something.txt"), ".txt"]

// Path.isAbsolute()
Assert[Path.isAbsolute("/some/thing.txt")]
Assert[Path.isAbsolute("some/thing.txt"), false]

// Path.sep
Assert[Path.sep, "/"]

// Path.parse()
var parse = Path.parse(path)
Assert[parse["dir"], "/this/is/a/path/to"]
Assert[parse["root"], "/"]
Assert[parse["ext"], ".txt"]
Assert[parse["name"], "something"]
Assert[parse["base"], "something.txt"]

System.print("Path tests passed")