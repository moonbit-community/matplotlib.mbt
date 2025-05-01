///|
pub(all) enum LineStyle {
  Solid
  Dashed
  Dotted
  DashDot
} derive(Show)

///|
pub fn LineStyle::to_pystr(self : LineStyle) -> PyString {
  let s : String = match self {
    Solid => "solid"
    Dashed => "dashed"
    Dotted => "dotted"
    DashDot => "dashdot"
  }
  PyString::from(s)
}

///|
pub(all) enum Marker {
  Point
  Pixel
  Circle
  Octagon
  Square
  Pentagon
  Plus
  PlusFilled
  Star
  Hexagon1
  Hexagon2
  X
  XFilled
  Diamond
  ThinDiamond
  Vline
  Hline
  TriangleUp
  TriangleDown
  TriangleLeft
  TriangleRight
  TriDown
  TriUp
  TriLeft
  TriRight
} derive(Show)

///|
pub fn Marker::to_pystr(self : Marker) -> PyString {
  let s : String = match self {
    Point => "."
    Pixel => ","
    Circle => "o"
    Octagon => "8"
    Square => "s"
    Pentagon => "p"
    Plus => "+"
    PlusFilled => "P"
    Star => "*"
    Hexagon1 => "h"
    Hexagon2 => "H"
    X => "x"
    XFilled => "X"
    Diamond => "D"
    ThinDiamond => "d"
    Vline => "|"
    Hline => "_"
    TriangleUp => "^"
    TriangleDown => "v"
    TriangleLeft => "<"
    TriangleRight => ">"
    TriDown => "1"
    TriUp => "2"
    TriLeft => "3"
    TriRight => "4"
  }
  PyString::from(s)
}
