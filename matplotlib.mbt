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
pub fn subplots() -> (Figure, Axes) {
  let lib = singleton()
  guard lib.pyplot.get_attr("subplots") is Some(PyCallable(f))
  let args = PyTuple::new(0)
  guard f.invoke(args) is Some(PyTuple(fig_ax))
  guard fig_ax[0] is PyClass(fig)
  guard fig_ax[1] is PyClass(ax)
  let fig = Figure::{ obj: fig }
  let ax = Axes::{ obj: ax }
  (fig, ax)
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
