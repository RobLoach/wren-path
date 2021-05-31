/**
 * Path manipulation library for Wren.
 *
 * @author Rob Loach (@RobLoach)
 * @license MIT
 * @website https://github.com/RobLoach/wren-path
 */
class Path {
    static basename(path) {
        if (!(path is String)) {
            Fiber.abort("Expected a String")
        }
        if (!path.contains(sep)) {
            return path
        }
        var reversePath = path[path.count - 1..0]
        var lastSlash = reversePath.indexOf(sep)
        return reversePath[lastSlash - 1..0]
    }

    static basename(path, ext) {
        var base = basename(path)
        return base.trimEnd(ext)
    }

    static dirname(path) {
        if (!path.contains(sep)) {
            return ""
        }
        var filename = basename(path)
        return path[0..path.count - filename.count - 2]
    }

    static isAbsolute(path) {
        if (!(path is String)) {
            Fiber.abort("Expected a String")
        }
        // TODO: Add Windows support
        return path.startsWith(sep)
    }

    static join(paths) {
        if (paths is String) {
            return paths
        }

        return normalize(paths.join(sep))
    }

    static normalize(path) {
        var abs = isAbsolute(path)
        var paths = path.split(sep)
        var finalPaths = []
        for (path in paths) {
            if (path == "..") {
                if (finalPaths.count > 0) {
                    finalPaths.removeAt(finalPaths.count - 1)
                    //finalPaths = finalPaths.take(finalPaths.count - 1)
                }
            } else {
                finalPaths.add(path)
            }
        }

        var outPaths = []
        for (path in finalPaths) {
            if (path is String && !path.isEmpty) {
                outPaths.add(path)
            }
        }

        var output = outPaths.join(sep)
        if (abs) {
            output = sep + output
        }

        return output
    }

    static extname(path) {
        if (!(path is String)) {
            Fiber.abort("Expected a String")
        }

        var filename = basename(path)
        if (filename.isEmpty) {
            return ""
        }

        if (filename[0] == ".") {
            var filenameWithoutStart = filename.skip(1)
            if (!filenameWithoutStart.contains(".")) {
                return ""
            }
        }

        if (filename.endsWith(".")) {
            return "."
        }

        if (!filename.contains(".")) {
            return ""
        }

        var reversePath = filename[filename.count - 1..0]
        var lastDot = reversePath.indexOf(".")
        var ext = reversePath[lastDot - 1..0]
        return "." + ext
    }

    static parse(path) {
        var root = ""
        if (isAbsolute(path)) {
            root = sep
        }
        var dir = dirname(path)
        var base = basename(path)
        var ext = extname(path)
        var name = basename(base, ext)
        return {
            "root": root,
            "base": base,
            "dir": dir,
            "ext": ext,
            "name": name
        }
    }

    static sep {
        // TODO: Add support for Windows
        return "/"
    }
}
