///|
pub struct Axes {
  priv obj : @python.PyObject
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
pub fn Axes::plot(
  self : Axes,
  xs : Array[Double],
  ys : Array[Double],
  color~ : Color = Blue,
  label~ : String? = None,
  linewidth~ : Double = 1.0,
  alpha~ : Double = 1.0,
  linestyle~ : LineStyle = Solid
) -> Unit {
  guard self.obj.get_attr("plot") is Some(@python.PyCallable(f))
  let args = @python.PyTuple::new(2)
  args[0] = xs.map(PyFloat::from) |> PyList::from
  args[1] = ys.map(PyFloat::from) |> PyList::from
  let kwargs : PyDict = PyDict::new()
  kwargs.set("color", PyString::from(color.to_string()))
  kwargs.set("linewidth", PyFloat::from(linewidth))
  kwargs.set("alpha", PyFloat::from(alpha))
  kwargs.set("linestyle", PyString::from(linestyle.to_string()))
  if label is Some(l) {
    kwargs.set("label", PyString::from(l))
  }
  let _ = f.invoke(args, kwargs~)

}

///|
pub fn set_xlim(self : Axes, left : Double, right : Double) -> Unit {
  guard self.obj.get_attr("set_xlim") is Some(@python.PyCallable(f))
  let args = @python.PyTuple::new(2)
  args[0] = PyFloat::from(left)
  args[1] = PyFloat::from(right)
  let _ = f.invoke(args)

}

///|
pub fn set_ylim(self : Axes, bottom : Double, top : Double) -> Unit {
  guard self.obj.get_attr("set_ylim") is Some(@python.PyCallable(f))
  let args = @python.PyTuple::new(2)
  args[0] = PyFloat::from(bottom)
  args[1] = PyFloat::from(top)
  let _ = f.invoke(args)

}

///|
pub fn set_title(self : Axes, title : String) -> Unit {
  guard self.obj.get_attr("set_title") is Some(@python.PyCallable(f))
  let args = @python.PyTuple::new(1)
  args[0] = PyString::from(title)
  let _ = f.invoke(args)

}
