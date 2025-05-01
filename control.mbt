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
pub(all) enum Color {
  Red
  Green
  Blue
  Yellow
  Black
  Cyan
  White
  Magenta
  Rgb(Int, Int, Int)
} derive(Show)

///|
pub fn Color::to_pystr(self : Color) -> PyString {
  let s : String = match self {
    Red => "r"
    Green => "g"
    Blue => "b"
    Yellow => "y"
    Black => "k"
    Cyan => "c"
    White => "w"
    Magenta => "m"
    Rgb(r, g, b) => {
      let rs = (r & 0xff).to_string(radix=16)
      let gs = (g & 0xff).to_string(radix=16)
      let bs = (b & 0xff).to_string(radix=16)
      "#\{rs}\{gs}\{bs}"
    }
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
