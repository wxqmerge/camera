# OpenSCAD Development Agent Guide

**Version:** 2026.02.25 (dev snapshot)  
**Last Updated:** 2026-03-10  
**Source:** OpenSCAD Official Cheat Sheet

## Overview

OpenSCAD is a 3D CAD programming language that uses declarative syntax to create 3D models. The development version (2026.02.25) includes the latest features and improvements.

## Quick Start

- OpenSCAD models are written in script files with `.scad` extension
- The language is executed in a single pass, not a compiled process
- All parameters, variables, and modules must be defined before use
- Use the online editor at openscad.org for quick testing

## Constants

- `undef` - Represents undefined value
- `PI` - Mathematical constant (3.14159...)
- `hex` - Used for hexadecimal values (e.g., 0xFF)

## Operators

### Arithmetic Operators
- `+`, `-`, `*`, `/` - Basic arithmetic
- `%` - Modulo operation
- `^`, `**` - Power operation (right to left evaluation)
- `//` - Line comment
- `/* */` - Block comment

### Logical Operators
- `&&` - Logical AND
- `||` - Logical OR
- `!` - Logical NOT

### Relational Operators
- `==`, `!=`, `<`, `>`, `<=`, `>=` - Comparison operators

### List Operators
- `+` - Concatenation
- `[]` - List creation

### Special Operators
- `:` - List slicing (e.g., `[0:10]` creates `[0,1,2,3,4,5,6,7,8,9,10]`)
- `..` - Range operator (e.g., `0..10` or `10..0:-1`)
- `?` - Conditional operator (ternary)
- `=` - Assignment operator

## Special Variables

Special variables are predefined by OpenSCAD and affect rendering:

- `$fa` - Minimum angle for facets (default 12°)
- `$fs` - Minimum size for facets (default 2mm)
- `$fe` - Minimum edge length for facets (default 1mm)
- `$fn` - Number of fragments (overrides $fa and $fs)
- `$t` - Animation time (0 to 1)
- `$vpr` - View rotation (x,y,z degrees)
- `$vpt` - View position (x,y,z)
- `$vpd` - View distance
- `$vpf` - Field of view
- `$children` - Number of child modules
- `$preview` - Boolean (true if in preview mode)

## Modifier Characters

Modifiers change how modules are rendered:

- `*` - Generate preview only
- `!` - Generate preview and render
- `#` - Highlight in preview
- `%` - Show as semi-transparent in preview

## Built-in Modules

### 2D Shapes

#### `circle(d=1, r=1, segments=36)`
- Creates a 2D circle
- `d` or `r` specifies diameter or radius
- `segments` controls polygon approximation

#### `square(size=[x,y], center=true)`
- Creates a 2D square
- `size` is [width, height] or [size] for square
- `center` determines centering

#### `polygon(points, convexity=10)`
- Creates a 2D polygon from point list
- `points` is array of [x,y] coordinates
- `convexity` affects 3D extrusion

#### `text("text", size=10, font="Arial", halign="center", valign="center")`
- Creates 2D text
- Supports various font properties

#### `import("file.dxf", dxf_version=2.0)`
- Imports 2D shapes from DXF files
- `dxf_version` specifies DXF format

#### `projection(cut=false)`
- Projects 3D objects to 2D
- Used with `linear_extrude` or `rotate_extrude`

### 3D Shapes

#### `sphere(r=1, d=2, segments=36)`
- Creates a 3D sphere
- `r` or `d` specifies radius or diameter
- `segments` controls polygon approximation

#### `cube(size=[x,y,z], center=false)`
- Creates a 3D cube
- `size` is [width,height,depth] or [size] for cube
- `center` determines centering

#### `cylinder(h=1, r1=1, r2=1, d1=2, d2=2, segments=36)`
- Creates a 3D cylinder
- `h` - height
- `r1`/`r2` - top/bottom radii (for cone)
- `d1`/`d2` - top/bottom diameters (for cone)
- `segments` controls polygon approximation

#### `polyhedron(points, faces)`
- Creates arbitrary 3D polyhedron
- `points` - array of [x,y,z] coordinates
- `faces` - array of face definitions

#### `import("file.stl", convexity=5)`
- Imports 3D models from STL files
- `convexity` affects rendering

#### `linear_extrude(height=1, center=true, convexity=10)`
- Extrudes 2D shapes to 3D
- `height` - extrusion height
- `center` - center the extrusion
- `convexity` - complexity of faces

#### `rotate_extrude(angle=360, convexity=10)`
- Rotates 2D shapes around Z-axis
- `angle` - rotation angle (default 360°)
- `convexity` - complexity of faces

#### `surface(file="filename.obj", convexity=5)`
- Creates 3D surface from image or OBJ file
- `file` - path to image or OBJ file
- `convexity` - complexity of faces

## Transformations

Transformations modify the position, orientation, or size of objects:

#### `translate(v=[x,y,z])`
- Translates object
- `v` - translation vector

#### `rotate(a=[x,y,z], v=[x,y,z])`
- Rotates object
- `a` - rotation angles in degrees
- `v` - axis of rotation (optional)

#### `scale(v=[x,y,z])`
- Scales object
- `v` - scaling factors

#### `resize(newsize=[x,y,z], auto=true, center=false)`
- Resizes object
- `newsize` - target dimensions
- `auto` - calculate missing dimensions
- `center` - center the resizing

#### `mirror([x,y,z])`
- Mirrors object
- `v` - mirror axis

#### `multmatrix(m)`
- Applies 4x4 transformation matrix
- `m` - matrix values

#### `color(color="red")`
- Sets color of object
- `color` - named color or hex code

#### `offset(r=1, delta=0, segments=36)`
- Modifies polygon edges
- `r` - radius offset
- `delta` - linear offset
- `segments` - resolution

#### `fill(points, faces)`
- Fills polygons
- Used with `hull` and `minkowski`

#### `hull()`
- Creates convex hull
- Takes multiple children

#### `minkowski()`
- Creates minkowski sum
- Takes two children (inner and outer shapes)

## Boolean Operations

### `union()`
- Combines objects into single solid
- Multiple children

### `difference()`
- Subtracts objects
- First child is base, subsequent children are subtracted

### `intersection()`
- Creates intersection of objects
- Takes multiple children

## Lists and Objects

```openscad
// Lists
list = [1, 2, 3];
list2 = ["a", "b", "c"];

// Objects
obj = [x, y, z];
obj2 = [key1: val1, key2: val2];
```

## List Comprehensions

```openscad
// Basic syntax
[new_expr for (expr in list)]

// With condition
[new_expr for (expr in list) if (condition)]

// Nested
[new_expr for (expr1 in list1) for (expr2 in list2)]

// With index
[new_expr for (expr = [0:len(list)-1])]

// Advanced
[new_expr for (expr in list) let (var = expr * 2)]
```

## Flow Control

### `for` loop
```openscad
for (i = [0:10])
    cube([i,i,i]);
```

### `intersection_for` loop
```openscad
intersection_for (i = [0:10])
    rotate([0,0,i]) cylinder(r=10, h=20);
```

### `if` statement
```openscad
if (condition)
    cube();
else
    sphere();
```

### `let` statement
```openscad
let (x = 5, y = x + 2)
    cube([x,y,10]);
```

## Type Test Functions

### `is_undef(x)`
- Returns true if value is undefined

### `is_number(x)`
- Returns true if value is a number

### `is_bool(x)`
- Returns true if value is a boolean

### `is_string(x)`
- Returns true if value is a string

### `is_list(x)`
- Returns true if value is a list

### `is_vector(x)`
- Returns true if value is a vector (list of 3 numbers)

### `is_xxx(x)`
- Various type checks for vectors, matrices, etc.

## Other Features

### `echo("message")`
- Outputs message to console
- Useful for debugging

### `render(convexity=10)`
- Forces rendering of preview
- `convexity` - complexity of faces

### `children(n)`
- Accesses child modules
- `n` - index (0-based)

### `assert(condition, "message")`
- Fails if condition is false
- `message` - error message

### `assign(var = value)`
- Assigns value to variable
- `var` - variable name
- `value` - new value

## Functions

### `concat(list1, list2, ...)`
- Concatenates lists
- Returns new list

### `lookup(x, list)`
- Looks up x in [key:value] list
- Returns interpolated value

### `str(a, b, c)`
- Converts values to strings
- Concatenates string representations

### `chr(n)`
- Converts number to character

### `ord(c)`
- Converts character to number

### `search(pattern, list)`
- Searches for pattern in list
- Returns matching indices

### `version()`
- Returns version string
- e.g., "2026.02.25"

### `version_num()`
- Returns version number
- e.g., 20260225

### `parent_module()`
- Returns module hierarchy

### `textmetrics(text)`
- Returns text metrics
- Useful for layout calculations

### `fontmetrics(font)`
- Returns font information
- Useful for text sizing

## Mathematical Functions

### Trigonometry
- `sin(a)` - Sine
- `cos(a)` - Cosine
- `tan(a)` - Tangent
- `asin(a)` - Arc sine
- `acos(a)` - Arc cosine
- `atan(a)` - Arc tangent
- `atan2(y, x)` - Arc tangent with two arguments

### Basic Math
- `abs(x)` - Absolute value
- `round(x)` - Round to nearest integer
- `floor(x)` - Round down
- `ceil(x)` - Round up
- `sign(x)` - Sign of value
- `pow(a, b)` - Power
- `sqrt(x)` - Square root
- `exp(x)` - Exponential
- `log(x)` - Natural log
- `ln(x)` - Natural log
- `log2(x)` - Base 2 log
- `log10(x)` - Base 10 log

### Rounding
- `rnd()` - Random number (0 to 1)

### Trig Helpers
- `sin(deg)` - Convert degrees to radians internally
- `cos(deg)`
- `tan(deg)`
- `asin(deg)`
- `acos(deg)`
- `atan(deg)`

## Best Practices

1. **Use descriptive variable names** for clarity
2. **Group related code** with `{}` for readability
3. **Comment complex logic** with `//` or `/* */`
4. **Test incrementally** - build and verify each part
5. **Use special variables** for fine-tuning rendering quality
6. **Leverage transformations** for complex geometry
7. **Use list comprehensions** for generating patterns
8. **Keep parameters configurable** at the top of your file
9. **Render preview first** (`*` modifier) before full render
10. **Check for undefined values** to avoid runtime errors

## Testing .scad files with openscad_runner

This workspace includes `openscad_runner/` — a Python library that wraps the OpenSCAD CLI.

### Prerequisites

- **Python 3.10+** with `uv` package manager
- **OpenSCAD** installed and on PATH (see below)

### Install

```bash
cd openscad_runner
uv sync
```

### OpenSCAD setup (Linux flatpak)

If OpenSCAD is installed via flatpak, create a wrapper so the runner can find it:

```bash
cat > ~/.local/bin/openscad <<'EOF'
#!/bin/bash
exec flatpak run --command=openscad-nightly org.openscad.OpenSCAD "$@"
EOF
chmod +x ~/.local/bin/openscad
```

**Important:** Flatpak's sandbox blocks writes to `/tmp`. Use home directory or other permitted paths for output files.

### Usage examples

```python
from openscad_runner import OpenScadRunner, RenderMode

# Test-only mode (no output file, just validates the script)
osr = OpenScadRunner("bridge.gcode", "/dev/null", render_mode=RenderMode.test_only)
osr.run()
print(osr.errors)   # ERROR:/TRACE: lines from stderr
print(osr.warnings)  # WARNING: lines from stderr

# Full render to STL
osr = OpenScadRunner("bridge.gcode", "/home/sally/Desktop/output.stl", render_mode=RenderMode.render)
osr.run()

# Preview PNG with antialiasing
osr = OpenScadRunner("bridge.gcode", "/home/sally/Desktop/output.png",
    render_mode=RenderMode.preview, imgsize=(800, 600), antialias=2.0)
osr.run()
```

### Render modes

| Mode | Use case |
|------|----------|
| `test_only` | Validate script without producing output |
| `render` | Full high-quality render (slowest) |
| `preview` | Fast preview render |
| `thrown_together` | Preview with all children shown |
| `wireframe` | Wireframe rendering |

### Checking results

- `osr.success` — True if return code was 0, no errors, and no warnings (unless `hard_warnings=True`)
- `osr.good()` — same as `success`
- `osr.errors` — list of ERROR:/TRACE: lines
- `osr.warnings` — list of WARNING: lines
- `osr.echos` — list of ECHO: lines

### Running tests

```bash
cd openscad_runner
uv run pytest              # full suite (unit + integration)
```

Integration tests auto-skip if OpenSCAD is not found.
