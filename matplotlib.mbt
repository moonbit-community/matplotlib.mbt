
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

///|
pub fn subplots(nrows: Int, ncols :Int, figsize~:(Double, Double) = (8, 6)) -> (Figure, Array[Array[Axes]]) {
  guard nrows >= 1 && ncols >= 1

  let lib = singleton()
  guard lib.pyplot.get_attr("subplots") is Some(PyCallable(f))
  let args = PyTuple::new(2)
  args.set?(0, PyInteger::from(nrows.to_int64())).unwrap()
  args.set?(1, PyInteger::from(ncols.to_int64())).unwrap()

  let kwargs = PyDict::new()
  let py_figsize_arg = PyTuple::new(2)
  let (w, h) = figsize
  py_figsize_arg.set?(0, PyFloat::from(w)).unwrap()
  py_figsize_arg.set?(1, PyFloat::from(h)).unwrap()
  kwargs.set("figsize", py_figsize_arg)

  guard f.invoke(args, kwargs = kwargs) is Some(PyTuple(fig_ax))
  guard fig_ax[0] is PyClass(fig)
  let fig = Figure::{ obj: fig }

  guard fig_ax[1] is PyClass(py_axes) // It possibly matpolotlib.axes._axes.Axes or numpy.ndarray
  let axes :Array[Array[Axes]] = Array::new()
  
  match (nrows, ncols) {
    (1, 1) => {
      axes.push(Array::new())
      axes[0].push(Axes::{ obj: py_axes })
    }
    (n, 1) => {
      for i in 0..<n {
        axes.push(Array::new())
        guard py_axes.get_attr("__getitem__") is Some(PyCallable(ax_getitem))
        let arg = PyTuple::new(1)
        arg.set?(0, PyInteger::from(i.to_int64())).unwrap()
        guard ax_getitem.invoke(arg) is Some(PyClass(ax))
        axes[i].push(Axes::{ obj: ax })
      }
    }
    (1, n) => {
      let col = Array::new()
      for i in 0..<n {
        guard py_axes.get_attr("__getitem__") is Some(PyCallable(ax_getitem))
        let arg = PyTuple::new(1)
        arg.set?(0, PyInteger::from(i.to_int64())).unwrap()
        guard ax_getitem.invoke(arg) is Some(PyClass(ax))
        col.push(Axes::{ obj: ax })
      }
      axes.push(col)
    }
    (r, c) => {
      for i in 0..<r {
        axes.push(Array::new())
        guard py_axes.get_attr("__getitem__") is Some(PyCallable(ax_r_getitem))
        let arg = PyTuple::new(1)
        arg.set?(0, PyInteger::from(i.to_int64())).unwrap()
        guard ax_r_getitem.invoke(arg) is Some(PyClass(ax_r))
        for j in 0..<c {
          guard ax_r.get_attr("__getitem__") is Some(PyCallable(ax_c_getitem))
          let arg = PyTuple::new(1)
          arg.set?(0, PyInteger::from(j.to_int64())).unwrap()
          guard ax_c_getitem.invoke(arg) is Some(PyClass(ax))
          axes[i].push(Axes::{ obj: ax })
        }
      }
    }
  }

  (fig, axes)
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
