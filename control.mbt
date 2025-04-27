///|
pub(all) enum LineStyle {
  Solid
  Dashed
  Dotted
  DashDot
}

///|
pub impl Show for LineStyle with to_string(self) -> String {
  match self {
    Solid => "solid"
    Dashed => "dashed"
    Dotted => "dotted"
    DashDot => "dashdot"
  }
}

///|
pub impl Show for LineStyle with output(self, logger) {
  logger.write_string(self.to_string())
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
  Rgb(Int, Int, Int)
}

///|
pub impl Show for Color with to_string(self) -> String {
  match self {
    Red => "r"
    Green => "g"
    Blue => "b"
    Yellow => "y"
    Black => "k"
    Cyan => "c"
    White => "w"
    Rgb(r, g, b) => {
      let rs = (r & 0xff).to_string(radix=16)
      let gs = (g & 0xff).to_string(radix=16)
      let bs = (b & 0xff).to_string(radix=16)
      "#\{rs}\{gs}\{bs}"
    }
  }
}

///|
pub impl Show for Color with output(self, logger) {
  logger.write_string(self.to_string())
}
