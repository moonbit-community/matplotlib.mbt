///|
typealias PyModule = @python.PyModule

///|
typealias PyString = @python.PyString

///|
typealias PyInteger = @python.PyInteger

///|
typealias PyFloat = @python.PyFloat

///|
typealias PyTuple = @python.PyTuple

///|
typealias PyDict = @python.PyDict

///|
typealias PyList = @python.PyList

///|
typealias Pycallable = @python.PyCallable

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
  Hex(String)
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
    Hex(hex) => hex
  }
}

///|
pub impl Show for Color with output(self, logger) {
  logger.write_string(self.to_string())
}

///|
pub type! MatplotlibError {
  //LoadMatplotlibError
  LoadPyPlotError
  //LoadColorMapError
  LoadPylabError
  LoadFuncError(String)
  // CallFuncError(String)
} derive(Show)

///|
pub struct Matplotlib {
  // matplotlib: PyModule 
  pyplot : PyModule
  // color_map: PyModule
  pylab : PyModule
}

///|
pub fn new() -> Matplotlib!Error {
  //guard @python.pyimport("matplotlib") is Some(matplotlib) else {
  //  raise LoadMatplotlibError
  //}

  //guard @python.pyimport("matplotlib.cm") is Some(color_map) else {
  //  raise LoadColorMapError
  //}

  guard @python.pyimport("matplotlib.pyplot") is Some(pyplot) else {
    raise LoadPyPlotError
  }
  guard @python.pyimport("pylab") is Some(pylab) else { raise LoadPylabError }
  Matplotlib::{
    // matplotlib,
    pyplot,
    // color_map,
    pylab,
  }
}

///|
fn pyplot_get_func(fname : String) -> Pycallable!MatplotlibError {
  let lib = singleton()
  guard lib.pyplot.get_attr(fname) is Some(PyCallable(f)) else {
    raise LoadFuncError("Didn't find function : \{fname} in matplotlib.pyplot")
  }
  f
}

///|
fn pylab_get_func(fname : String) -> Pycallable!MatplotlibError {
  let lib = singleton()
  guard lib.pylab.get_attr(fname) is Some(PyCallable(f)) else {
    raise LoadFuncError("Didn't find function : \{fname} in pylab")
  }
  f
}

///|
let singleton : () -> Matplotlib = get_lib()

///|
fn get_lib() -> () -> Matplotlib {
  @python.init_py()
  let mlib = match new?() {
    Ok(mlib) => mlib
    Err(e) => {
      println(e)
      panic()
    }
  }
  fn() { mlib }
}

///| Plot y versus x as lines and/or markers. Same as `matplotlib.pyplot.plot` in Python.
///
/// ## Arguments
///
/// - `xs`: x-coordinates of the points to plot.
/// - `ys`: y-coordinates of the points to plot.
///
/// ## Optional Arguments
///
/// - `format`: A format string that specifies the color and line style of the plot. Default is "r" (red line).
/// - `label`: A label for the plot, used in the legend. Default is None.
/// - `linewidth`: The width of the line. Default is 1.0.
/// - `linestyle`: The style of the line. Default is solid line.
/// - `alpha`: The transparency of the plot. Default is 1.0 (opaque).
///
/// (To be added later)
pub fn plot(
  xs : Array[Double],
  ys : Array[Double],
  color~ : Color = Color::Blue,
  label~ : String? = None,
  linewidth~ : Double = 1.0,
  alpha~ : Double = 1.0,
  linestyle~ : LineStyle = Solid
) -> Unit {
  let func = pyplot_get_func?("plot").unwrap()
  let xs = xs.map(PyFloat::from) |> PyList::from
  let ys = ys.map(PyFloat::from) |> PyList::from
  let args = PyTuple::new(2)
  args.set?(0, xs).unwrap()
  args.set?(1, ys).unwrap()
  let kwargs = PyDict::new()
  kwargs.set("color", PyString::from(color.to_string()))
  kwargs.set("linewidth", PyFloat::from(linewidth))
  kwargs.set("alpha", PyFloat::from(alpha))
  kwargs.set("linestyle", PyString::from(linestyle.to_string()))
  if label is Some(l) {
    kwargs.set("label", PyString::from(l))
  }
  let _ = func.invoke(args, kwargs~)

}

///| Set the x-axis limits of the current plot. Same as `matplotlib.pyplot.xlim` in Python.
pub fn xlim(left : Double, right : Double) -> Unit {
  let func = pyplot_get_func?("xlim").unwrap()
  let left = PyFloat::from(left)
  let right = PyFloat::from(right)
  let list = PyList::from([left, right])
  let args = PyTuple::new(1)
  args.set?(0, list).unwrap()
  let _ = func.invoke(args)

}

///|
pub fn ylim(left : Double, right : Double) -> Unit {
  let func = pyplot_get_func?("ylim").unwrap()
  let left = PyFloat::from(left)
  let right = PyFloat::from(right)
  let list = PyList::from([left, right])
  let args = PyTuple::new(1)
  args.set?(0, list).unwrap()
  let _ = func.invoke(args)

}

///|
pub fn title(title_str : String) -> Unit {
  let func = pyplot_get_func?("title").unwrap()
  let py_str = PyString::from(title_str)
  let args = PyTuple::new(1)
  args.set?(0, py_str).unwrap()
  let _ = func.invoke(args)

}

///|
pub fn show() -> Unit {
  let func = pyplot_get_func?("show").unwrap()
  let _ = func.invoke(PyTuple::new(0))

}

///|
pub fn save(filename : String, dpi~ : Int = 0) -> Unit {
  let func = pylab_get_func?("save").unwrap()
  let py_str = PyString::from(filename)
  let args = PyTuple::new(1)
  args.set?(0, py_str).unwrap()
  let kwargs = PyDict::new()
  if dpi > 0 {
    kwargs.set("dpi", PyInteger::from(dpi.to_int64()))
  }
  let _ = func.invoke(args, kwargs~)

}
