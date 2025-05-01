///|
pub struct Axes {
  priv obj : PyObject
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
  guard xs.length() != 0 else {
    println("Error: xs must have at least one element.")
    return
  }
  guard xs.length() == ys.length() else {
    println("Error: xs and ys must have the same length.")
    return
  }
  guard self.obj.get_attr("plot") is Some(PyObjectEnum::PyCallable(f))
  let xs = xs.map(PyFloat::from) |> PyList::from
  let ys = ys.map(PyFloat::from) |> PyList::from
  let args = PyTuple::new(2)..set(0, xs)..set(1, ys)
  let kwargs : PyDict = PyDict::new()
    ..set("color", color.to_pystr())
    ..set("linewidth", PyFloat::from(linewidth))
    ..set("alpha", PyFloat::from(alpha))
    ..set("linestyle", linestyle.to_pystr())
  if label is Some(l) {
    kwargs.set("label", PyString::from(l))
  }
  let _ = f.invoke(args~, kwargs~)

}

///|
pub fn Axes::scatter(
  self : Axes,
  xs : Array[Double],
  ys : Array[Double],
  color~ : Color = Blue,
  marker~ : Marker = Marker::Circle,
  alpha~ : Double = 1.0
) -> Unit {
  guard xs.length() != 0 else {
    println("Error: xs must have at least one element.")
    return
  }
  guard xs.length() == ys.length() else {
    println("Error: xs and ys must have the same length.")
    return
  }
  guard self.obj.get_attr("scatter") is Some(PyObjectEnum::PyCallable(f))
  let xs = xs.map(PyFloat::from) |> PyList::from
  let ys = ys.map(PyFloat::from) |> PyList::from
  let args = PyTuple::new(2)..set(0, xs)..set(1, ys)
  let kwargs : PyDict = PyDict::new()
    ..set("color", color.to_pystr())
    ..set("marker", marker.to_pystr())
    ..set("alpha", PyFloat::from(alpha))
  let _ = f.invoke(args~, kwargs~)

}

///|
pub fn Axes::stem(
  self : Axes,
  xs : Array[Double],
  ys : Array[Double],
  bottom~ : Double = 0.0
) -> Unit {
  guard xs.length() != 0 else {
    println("Error: xs must have at least one element.")
    return
  }
  guard xs.length() == ys.length() else {
    println("Error: xs and ys must have the same length.")
    return
  }
  guard self.obj.get_attr("stem") is Some(PyObjectEnum::PyCallable(f))
  let xs = xs.map(PyFloat::from) |> PyList::from
  let ys = ys.map(PyFloat::from) |> PyList::from
  let args = PyTuple::new(2)..set(0, xs)..set(1, ys)
  let kwargs : PyDict = PyDict::new()
      ..set("bottom", PyFloat::from(bottom))
  let _ = f.invoke(args~, kwargs~)

}

///|
pub fn Axes::bar(
  self : Axes,
  xs : Array[Double],
  heights : Array[Double],
  width~ : Double = 0.8,
  bottom~ : Double = 0.0,
  color~ : Color = Blue
) -> Unit {
  guard xs.length() != 0 else {
    println("Error: xs must have at least one element.")
    return
  }
  guard xs.length() == heights.length() else {
    println("Error: xs and heights must have the same length.")
    return
  }
  guard self.obj.get_attr("bar") is Some(PyObjectEnum::PyCallable(f))
  let xs = xs.map(PyFloat::from) |> PyList::from
  let heights = heights.map(PyFloat::from) |> PyList::from
  let args = PyTuple::new(2)..set(0, xs)..set(1, heights)
  let kwargs : PyDict = PyDict::new()
    ..set("width", PyFloat::from(width))
    ..set("color", color.to_pystr())
    ..set("bottom", PyFloat::from(bottom))
  let _ = f.invoke(args~, kwargs~)

}

///|
pub fn Axes::barh(
  self : Axes,
  ys : Array[Double],
  widths : Array[Double],
  hight~ : Double = 0.8,
  left~ : Double = 0.0,
  color~ : Color = Blue
) -> Unit {
  guard ys.length() != 0 else {
    println("Error: ys must have at least one element.")
    return
  }
  guard ys.length() == widths.length() else {
    println("Error: ys and widths must have the same length.")
    return
  }
  guard self.obj.get_attr("barh") is Some(PyObjectEnum::PyCallable(f))
  let ys = ys.map(PyFloat::from) |> PyList::from
  let widths = widths.map(PyFloat::from) |> PyList::from
  let args = PyTuple::new(2)..set(0, ys)..set(1, widths)
  let kwargs : PyDict = PyDict::new()
    ..set("height", PyFloat::from(hight))
    ..set("color", color.to_pystr())
    ..set("left", PyFloat::from(left))
  let _ = f.invoke(args~, kwargs~)

}

///|
pub fn Axes::pie(
  self : Axes,
  xs : Array[Double],
  labels~ : Array[String] = [],
  colors~ : Array[Color] = []
) -> Unit {
  guard xs.length() > 0 else {
    println("Error: xs must have at least one element.")
    return
  }
  guard labels.length() == 0 || labels.length() == xs.length() else {
    println("Error: labels must have the same length as xs or be empty.")
    return
  }
  guard colors.length() == 0 || colors.length() == xs.length() else {
    println("Error: colors must have the same length as xs or be empty.")
    return
  }
  guard self.obj.get_attr("pie") is Some(PyObjectEnum::PyCallable(f))
  let xs = xs.map(PyFloat::from) |> PyList::from
  let args = PyTuple::new(1)..set(0, xs)
  let kwargs : PyDict = PyDict::new()
  if labels.length() > 0 {
    let labels = labels.map(PyString::from) |> PyList::from
    kwargs.set("labels", labels)
  }
  if colors.length() > 0 {
    let colors = colors.map(fn(c) { c.to_pystr() }) |> PyList::from
    kwargs.set("colors", colors)
  }
  let _ = f.invoke(args~, kwargs~)

}

///| Set the x-axis view limits. Same as `matplotlib.axes.Axes.set_xlim` in Python.
///
/// ## Arguments
///
/// - `left`: The left limit of the x-axis.
/// - `right`: The right limit of the x-axis.
pub fn Axes::set_xlim(self : Axes, left : Double, right : Double) -> Unit {
  guard self.obj.get_attr("set_xlim") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(2)
    ..set(0, PyFloat::from(left))
    ..set(1, PyFloat::from(right))
  let _ = f.invoke(args~)

}

///|
pub fn Axes::get_xlim(self: Axes) -> (Double, Double) {
  guard self.obj.get_attr("get_xlim") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyTuple(t))

  guard t.get(0) is Some(PyObjectEnum::PyFloat(left))
  guard t.get(1) is Some(PyObjectEnum::PyFloat(right))

  let left = left.to_double()
  let right = right.to_double()
  return (left, right)
}

///| Set the y-axis view limits. Same as `matplotlib.axes.Axes.set_ylim` in Python.
///
/// ## Arguments
///
/// - `bottom`: The bottom limit of the y-axis.
/// - `top`: The top limit of the y-axis.
pub fn Axes::set_ylim(self : Axes, bottom : Double, top : Double) -> Unit {
  guard self.obj.get_attr("set_ylim") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(2)
    ..set(0, PyFloat::from(bottom))
    ..set(1, PyFloat::from(top))
  let _ = f.invoke(args~)

}

///|
pub fn Axes::get_ylim(self: Axes) -> (Double, Double) {
  guard self.obj.get_attr("get_ylim") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyTuple(t))

  guard t.get(0) is Some(PyObjectEnum::PyFloat(bottom))
  guard t.get(1) is Some(PyObjectEnum::PyFloat(top))

  let bottom = bottom.to_double()
  let top = top.to_double()
  return (bottom, top)
}

///|
pub fn Axes::set_xbound(self : Axes, lower : Double, upper : Double) -> Unit {
  guard self.obj.get_attr("set_xbound") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(2)
    ..set(0, PyFloat::from(lower))
    ..set(1, PyFloat::from(upper))
  let _ = f.invoke(args~)

}

///|
pub fn Axes::get_xbound(self: Axes) -> (Double, Double) {
  guard self.obj.get_attr("get_xbound") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyTuple(t))

  guard t.get(0) is Some(PyObjectEnum::PyFloat(lower))
  guard t.get(1) is Some(PyObjectEnum::PyFloat(upper))

  let lower = lower.to_double()
  let upper = upper.to_double()
  return (lower, upper)
}

///|
pub fn Axes::set_ybound(self : Axes, lower : Double, upper : Double) -> Unit {
  guard self.obj.get_attr("set_ybound") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(2)
    ..set(0, PyFloat::from(lower))
    ..set(1, PyFloat::from(upper))
  let _ = f.invoke(args~)

}

///|
pub fn Axes::get_ybound(self: Axes) -> (Double, Double) {
  guard self.obj.get_attr("get_ybound") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyTuple(t))

  guard t.get(0) is Some(PyObjectEnum::PyFloat(lower))
  guard t.get(1) is Some(PyObjectEnum::PyFloat(upper))

  let lower = lower.to_double()
  let upper = upper.to_double()
  return (lower, upper)
}

///| Set the title of the axes. Same as `matplotlib.axes.Axes.set_title` in Python.
///
/// ## Arguments
///
/// - `title`: The title string.
pub fn Axes::set_title(self : Axes, title : String) -> Unit {
  guard self.obj.get_attr("set_title") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(1)..set(0, PyString::from(title))
  let _ = f.invoke(args~)

}

///|
pub fn Axes::get_title(self: Axes) -> String {
  guard self.obj.get_attr("get_title") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyString(title))
  title.to_string()
}

///| Set the label for the x-axis. Same as `matplotlib.axes.Axes.set_xlabel` in Python.
///
/// ## Arguments
///
/// - `xlabel`: The label string for the x-axis.
pub fn Axes::set_xlabel(self : Axes, xlabel : String) -> Unit {
  guard self.obj.get_attr("set_xlabel") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(1)..set(0, PyString::from(xlabel))
  let _ = f.invoke(args~)

}

///|
pub fn Axes::get_xlabel(self: Axes) -> String {
  guard self.obj.get_attr("get_xlabel") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyString(xlabel))
  xlabel.to_string()
}

///| Set the label for the y-axis. Same as `matplotlib.axes.Axes.set_ylabel` in Python.
///
/// ## Arguments
///
/// - `ylabel`: The label string for the y-axis.
pub fn Axes::set_ylabel(self : Axes, ylabel : String) -> Unit {
  guard self.obj.get_attr("set_ylabel") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(1)..set(0, PyString::from(ylabel))
  let _ = f.invoke(args~)

}

///|
pub fn Axes::get_ylabel(self: Axes) -> String {
  guard self.obj.get_attr("get_ylabel") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyString(ylabel))
  ylabel.to_string()
}

///|
pub fn Axes::loglog(self : Axes, base~ : Double = 10.0) -> Unit {
  guard self.obj.get_attr("loglog") is Some(PyObjectEnum::PyCallable(f))
  let kwargs : PyDict = PyDict::new()..set("base", PyFloat::from(base))
  let _ = f.invoke(kwargs~)

}

///|
pub fn Axes::semilogx(self : Axes, base~ : Double = 10.0) -> Unit {
  guard self.obj.get_attr("semilogx") is Some(PyObjectEnum::PyCallable(f))
  let kwargs : PyDict = PyDict::new()..set("base", PyFloat::from(base))
  let _ = f.invoke(kwargs~)

}

///|
pub fn Axes::semilogy(self : Axes, base~ : Double = 10.0) -> Unit {
  guard self.obj.get_attr("semilogy") is Some(PyObjectEnum::PyCallable(f))
  let kwargs : PyDict = PyDict::new()..set("base", PyFloat::from(base))
  let _ = f.invoke(kwargs~)

}

///|
pub fn Axes::grid(
  self: Axes, 
  visiable: Bool,
  color~ : Color = Color::Blue,
  linestyle~:LineStyle = LineStyle::Solid,
  linewidth~:Double = 1.0,
  alpha~:Double = 0.8
) -> Unit {
  guard self.obj.get_attr("grid") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(1)..set(0, PyBool::from(visiable))
  let kwargs : PyDict = PyDict::new()
    ..set("color", color.to_pystr())
    ..set("linestyle", linestyle.to_pystr())
    ..set("linewidth", PyFloat::from(linewidth))
    ..set("alpha", PyFloat::from(alpha))
  let _ = f.invoke(args~, kwargs~)
}

///|
pub fn Axes::vline(
  self : Axes,
  x : Double,
  ymin : Double,
  ymax : Double,
  color~ : Color = Color::Blue,
  linestyle~ : LineStyle = LineStyle::Solid
) -> Unit {
  guard self.obj.get_attr("vlines") is Some(PyObjectEnum::PyCallable(f))
  let x = PyFloat::from(x)
  let ymin = PyFloat::from(ymin)
  let ymax = PyFloat::from(ymax)
  let args = PyTuple::new(3)..set(0, x)..set(1, ymin)..set(2, ymax)
  let kwargs : PyDict = PyDict::new()
    ..set("colors", color.to_pystr())
    ..set("linestyles", linestyle.to_pystr())
  let _ = f.invoke(args~, kwargs~)

}

///|
pub fn Axes::hline(
  self : Axes,
  y : Double,
  xmin : Double,
  xmax : Double,
  color~ : Color = Color::Blue,
  linestyle~ : LineStyle = LineStyle::Solid
) -> Unit {
  guard self.obj.get_attr("hlines") is Some(PyObjectEnum::PyCallable(f))
  let y = PyFloat::from(y)
  let xmin = PyFloat::from(xmin)
  let xmax = PyFloat::from(xmax)
  let args = PyTuple::new(3)..set(0, y)..set(1, xmin)..set(2, xmax)
  let kwargs : PyDict = PyDict::new()
    ..set("colors", color.to_pystr())
    ..set("linestyles", linestyle.to_pystr())
  let _ = f.invoke(args~, kwargs~)
}
