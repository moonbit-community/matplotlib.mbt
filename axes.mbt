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
  let args = PyTuple::new(2)
  args..set(0, xs)..set(1, ys)
  let kwargs : PyDict = PyDict::new()
  kwargs
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
/// Creates a scatter plot on the axes. Each data point is represented by a
/// marker at the coordinates specified by `x` and `y` arrays.
/// Same as `matplotlib.pyplot.scatter` in Python.
///
/// Parameters:
///
/// * `self`: The axes on which to create the scatter plot.
/// * `xs`: An array of x-coordinates for the data points.
/// * `ys`: An array of y-coordinates for the data points.
/// * `color`: The color of the markers. Defaults to blue.
/// * `marker`: The style of the markers. Defaults to circle ('o').
/// * `alpha`: The transparency level of the markers, ranging from 0.0
/// (transparent) to 1.0 (opaque). Defaults to 1.0.
///
/// Example:
///
/// ```moonbit
/// test "Axes::scatter" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   let x = [1.0, 2.0, 3.0]
///   let y = [4.0, 5.0, 6.0]
///   axes[0][0].scatter(x, y, color=Red, marker=Star, alpha=0.5)
/// }
/// ```
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
  let args = PyTuple::new(2)
  args..set(0, xs)..set(1, ys)
  let kwargs : PyDict = PyDict::new()
  kwargs
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
  let args = PyTuple::new(2)
  args..set(0, xs)..set(1, ys)
  let kwargs : PyDict = PyDict::new()
  kwargs..set("bottom", PyFloat::from(bottom))
  let _ = f.invoke(args~, kwargs~)

}

///|
/// Creates a bar plot on the axes. Each bar is centered at the x-coordinates
/// with the specified heights. Same as `matplotlib.pyplot.bar` in Python.
///
/// Parameters:
///
/// * `self`: The axes on which to create the bar plot.
/// * `xs`: An array of x-coordinates for the center of each bar.
/// * `heights`: An array of heights for each bar.
/// * `width`: The width of each bar. Defaults to 0.8.
/// * `bottom`: The y-coordinate of the bottom of each bar. Defaults to 0.0.
/// * `color`: The color of the bars. Defaults to blue.
///
/// Example:
///
/// ```moonbit
/// test "Axes::bar" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   let x = [1.0, 2.0, 3.0]
///   let heights = [4.0, 5.0, 6.0]
///   axes[0][0].bar(x, heights, width=0.5, color=Red)
/// }
/// ```
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
  let args = PyTuple::new(2)
  args..set(0, xs)..set(1, heights)
  let kwargs : PyDict = PyDict::new()
  kwargs
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
  let args = PyTuple::new(2)
  args..set(0, ys)..set(1, widths)
  let kwargs : PyDict = PyDict::new()
  kwargs
  ..set("height", PyFloat::from(hight))
  ..set("color", color.to_pystr())
  ..set("left", PyFloat::from(left))
  let _ = f.invoke(args~, kwargs~)

}

///|
/// Creates a pie chart on the axes. Each data point in `values` represents a
/// wedge of the pie, and the size of each wedge is determined by the relative
/// value with respect to the sum of all values.
/// Same as `matplotlib.pyplot.pie` in Python.
///
/// Parameters:
///
/// * `self` : The axes on which to create the pie chart.
/// * `values` : An array of numerical values that determine the size of each
/// wedge.
/// * `labels` : Optional array of strings to label each wedge. Must have the
/// same length as `values` if provided.
/// * `colors` : Optional array of colors for each wedge. Must have the same
/// length as `values` if provided.
///
/// Example:
///
/// ```moonbit
/// test "Axes::pie" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   let values = [35.0, 25.0, 40.0]
///   let labels = ["A", "B", "C"]
///   let colors = [
///     @matplotlib.Color::Red,
///     @matplotlib.Color::Green,
///     @matplotlib.Color::Blue,
///   ]
///   axes[0][0].pie(values, labels~, colors~)
/// }
/// ```
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
  let args = PyTuple::new(1)
  args..set(0, xs)
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

///|
pub fn Axes::text(
  self : Axes,
  x : Double,
  y : Double,
  s : String,
  alpha~ : Double = 1.0,
  color~ : Color = Color::Black,
  background~ : Color = Color::White,
  fontsize~ : Double = 12.0,
  rotation~ : Double = 0.0
) -> Unit {
  guard self.obj.get_attr("text") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(3)
  args
  ..set(0, PyFloat::from(x))
  ..set(1, PyFloat::from(y))
  ..set(2, PyString::from(s))
  let kwargs : PyDict = PyDict::new()
  kwargs
  ..set("alpha", PyFloat::from(alpha))
  ..set("color", color.to_pystr())
  ..set("backgroundcolor", background.to_pystr())
  ..set("fontsize", PyFloat::from(fontsize))
  ..set("rotation", PyFloat::from(rotation))
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
  args..set(0, PyFloat::from(left))..set(1, PyFloat::from(right))
  let _ = f.invoke(args~)

}

///|
/// Gets the x-axis limits of the current axes. Same as `matplotlib.axes.Axes.get_xlim` in Python.
///
/// Parameters:
///
/// * `self` : The Axes instance to get the limits from.
///
/// Returns a tuple of two `Double` values representing the left and right limits
/// of the x-axis.
///
/// Example:
///
/// ```moonbit
/// test "Axes::get_xlim" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_xlim(-1.0, 1.0)
///   let (left, right) = axes[0][0].get_xlim()
///   inspect!((left, right), content="(-1.0, 1.0)")
/// }
/// ```
pub fn Axes::get_xlim(self : Axes) -> (Double, Double) {
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
  args..set(0, PyFloat::from(bottom))..set(1, PyFloat::from(top))
  let _ = f.invoke(args~)

}

///|
/// Gets the y-axis limits of the current axes.
/// Same as `matplotlib.axes.Axes.get_ylim` in Python.
///
/// Parameters:
///
/// * `self` : The Axes instance to get the limits from.
///
/// Returns a tuple of two `Double` values representing the bottom and top limits
/// of the y-axis.
///
/// Example:
///
/// ```moonbit
/// test "Axes::get_ylim" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_ylim(-1.0, 1.0)
///   let (bottom, top) = axes[0][0].get_ylim()
///   inspect!((bottom, top), content="(-1.0, 1.0)")
/// }
/// ```
pub fn Axes::get_ylim(self : Axes) -> (Double, Double) {
  guard self.obj.get_attr("get_ylim") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyTuple(t))
  guard t.get(0) is Some(PyObjectEnum::PyFloat(bottom))
  guard t.get(1) is Some(PyObjectEnum::PyFloat(top))
  let bottom = bottom.to_double()
  let top = top.to_double()
  return (bottom, top)
}

///|
/// Sets the x-axis bounds of the current axes.
/// Same as `matplotlib.axes.Axes.set_xbound` in Python.
///
/// Parameters:
///
/// * `self` : The axes instance to set the bounds for.
/// * `lower` : The lower bound of the x-axis.
/// * `upper` : The upper bound of the x-axis.
///
/// Example:
///
/// ```moonbit
/// test "Axes::set_xbound" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_xbound(-1.0, 1.0)
///   let (lower, upper) = axes[0][0].get_xbound()
///   inspect!((lower, upper), content="(-1.0, 1.0)")
/// }
/// ```
pub fn Axes::set_xbound(self : Axes, lower : Double, upper : Double) -> Unit {
  guard self.obj.get_attr("set_xbound") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(2)
  args..set(0, PyFloat::from(lower))..set(1, PyFloat::from(upper))
  let _ = f.invoke(args~)

}

///|
/// Gets the x-axis bounds of the current axes.
/// Same as `matplotlib.axes.Axes.get_xbound` in Python.
///
/// Parameters:
///
/// * `axes` : The Axes instance to get the bounds from.
///
/// Returns a tuple of two `Double` values representing the lower and upper
/// bounds of the x-axis.
///
/// Example:
///
/// ```moonbit
/// test "Axes::get_xbound" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_xbound(-1.0, 1.0)
///   let (lower, upper) = axes[0][0].get_xbound()
///   inspect!((lower, upper), content="(-1.0, 1.0)")
/// }
/// ```
pub fn Axes::get_xbound(self : Axes) -> (Double, Double) {
  guard self.obj.get_attr("get_xbound") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyTuple(t))
  guard t.get(0) is Some(PyObjectEnum::PyFloat(lower))
  guard t.get(1) is Some(PyObjectEnum::PyFloat(upper))
  let lower = lower.to_double()
  let upper = upper.to_double()
  return (lower, upper)
}

///|
/// Sets the y-axis bounds of the current axes.
/// Same as `matplotlib.axes.Axes.set_ybound` in Python.
///
/// Parameters:
///
/// * `axes` : The Axes instance to set the bounds for.
/// * `lower` : The lower bound of the y-axis.
/// * `upper` : The upper bound of the y-axis.
///
/// Example:
///
/// ```moonbit
/// ///|
/// test "Axes::set_ybound" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_ybound(-1.0, 1.0)
///   let (lower, upper) = axes[0][0].get_ybound()
///   inspect!((lower, upper), content="(-1.0, 1.0)")
/// }
/// ```
pub fn Axes::set_ybound(self : Axes, lower : Double, upper : Double) -> Unit {
  guard self.obj.get_attr("set_ybound") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(2)
  args..set(0, PyFloat::from(lower))..set(1, PyFloat::from(upper))
  let _ = f.invoke(args~)

}

///|
/// Gets the y-axis bounds of the current axes. Same as
/// `matplotlib.axes.Axes.get_ybound` in Python.
///
/// Parameters:
///
/// * `axes` : The Axes instance to get the bounds from.
///
/// Returns a tuple of two `Double` values representing the lower and upper
/// bounds of the y-axis.
///
/// Example:
///
/// ```moonbit
/// ///|
/// test "Axes::get_ybound" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_ybound(-1.0, 1.0)
///   let (lower, upper) = axes[0][0].get_ybound()
///   inspect!((lower, upper), content="(-1.0, 1.0)")
/// }
/// ```
pub fn Axes::get_ybound(self : Axes) -> (Double, Double) {
  guard self.obj.get_attr("get_ybound") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyTuple(t))
  guard t.get(0) is Some(PyObjectEnum::PyFloat(lower))
  guard t.get(1) is Some(PyObjectEnum::PyFloat(upper))
  let lower = lower.to_double()
  let upper = upper.to_double()
  return (lower, upper)
}

///|
/// Sets the title of the axes. Provides the same functionality as
/// `matplotlib.axes.Axes.set_title` in Python.
///
/// Parameters:
///
/// * `self` : The axes instance to set the title for.
/// * `title` : The text to be displayed as the title of the axes.
///
/// Example:
///
/// ```moonbit
/// ///|
/// test "Axes::set_title" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_title("My Plot")
///   inspect!(axes[0][0].get_title(), content="\"My Plot\"")
/// }
/// ```
pub fn Axes::set_title(self : Axes, title : String) -> Unit {
  guard self.obj.get_attr("set_title") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(1)
  args..set(0, PyString::from(title))
  let _ = f.invoke(args~)

}

///|
/// Gets the title text of the current axes. Provides the same functionality as
/// `matplotlib.axes.Axes.get_title` in Python.
///
/// Parameters:
///
/// * `axes` : The axes instance from which to retrieve the title.
///
/// Returns the current title text of the axes as a string.
///
/// Example:
///
/// ```moonbit
/// ///|
/// test "Axes::get_title" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_title("My Plot")
///   inspect!(axes[0][0].get_title(), content="\"My Plot\"")
/// }
/// ```
pub fn Axes::get_title(self : Axes) -> String {
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
  let args = PyTuple::new(1)
  args..set(0, PyString::from(xlabel))
  let _ = f.invoke(args~)

}

///|
/// Gets the label text of the x-axis of the current axes. Provides the same
/// functionality as `matplotlib.axes.Axes.get_xlabel` in Python.
///
/// Parameters:
///
/// * `axes`: The axes instance from which to retrieve the x-axis label.
///
/// Returns the current x-axis label text as a string.
///
/// Example:
///
/// ```moonbit
/// ///|
/// test "Axes::get_xlabel" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_xlabel("X Label")
///   inspect!(axes[0][0].get_xlabel(), content="\"X Label\"")
/// }
/// ```
pub fn Axes::get_xlabel(self : Axes) -> String {
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
  let args = PyTuple::new(1)
  args..set(0, PyString::from(ylabel))
  let _ = f.invoke(args~)

}

///|
/// Gets the label text of the y-axis of the current axes. Provides the same
/// functionality as `matplotlib.axes.Axes.get_ylabel` in Python.
///
/// Parameters:
///
/// * `axes`: The axes instance from which to retrieve the y-axis label.
///
/// Returns the current y-axis label text as a string.
///
/// Example:
///
/// ```moonbit
/// ///|
/// test "Axes::get_ylabel" {
///   let (fig, axes) = @matplotlib.subplots(1, 1)
///   axes[0][0].set_ylabel("Y Label")
///   inspect!(axes[0][0].get_ylabel(), content="\"Y Label\"")
/// }
/// ```
pub fn Axes::get_ylabel(self : Axes) -> String {
  guard self.obj.get_attr("get_ylabel") is Some(PyObjectEnum::PyCallable(f))
  guard f.invoke() is Some(PyObjectEnum::PyString(ylabel))
  ylabel.to_string()
}

///|
pub fn Axes::loglog(self : Axes, base~ : Double = 10.0) -> Unit {
  guard self.obj.get_attr("loglog") is Some(PyObjectEnum::PyCallable(f))
  let kwargs : PyDict = PyDict::new()
  kwargs..set("base", PyFloat::from(base))
  let _ = f.invoke(kwargs~)

}

///|
pub fn Axes::semilogx(self : Axes, base~ : Double = 10.0) -> Unit {
  guard self.obj.get_attr("semilogx") is Some(PyObjectEnum::PyCallable(f))
  let kwargs : PyDict = PyDict::new()
  kwargs..set("base", PyFloat::from(base))
  let _ = f.invoke(kwargs~)

}

///|
pub fn Axes::semilogy(self : Axes, base~ : Double = 10.0) -> Unit {
  guard self.obj.get_attr("semilogy") is Some(PyObjectEnum::PyCallable(f))
  let kwargs : PyDict = PyDict::new()
  kwargs..set("base", PyFloat::from(base))
  let _ = f.invoke(kwargs~)

}

///|
pub fn Axes::grid(
  self : Axes,
  visiable : Bool,
  color~ : Color = Color::Blue,
  linestyle~ : LineStyle = LineStyle::Solid,
  linewidth~ : Double = 1.0,
  alpha~ : Double = 0.8
) -> Unit {
  guard self.obj.get_attr("grid") is Some(PyObjectEnum::PyCallable(f))
  let args = PyTuple::new(1)
  args..set(0, PyBool::from(visiable))
  let kwargs : PyDict = PyDict::new()
  kwargs
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
  let args = PyTuple::new(3)
  args..set(0, x)..set(1, ymin)..set(2, ymax)
  let kwargs : PyDict = PyDict::new()
  kwargs
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
  let args = PyTuple::new(3)
  args..set(0, y)..set(1, xmin)..set(2, xmax)
  let kwargs : PyDict = PyDict::new()
  kwargs
  ..set("colors", color.to_pystr())
  ..set("linestyles", linestyle.to_pystr())
  let _ = f.invoke(args~, kwargs~)

}
