typealias PyModule = @python.PyModule
typealias PyString = @python.PyString
typealias PyInteger = @python.PyInteger
typealias PyFloat = @python.PyFloat
typealias PyTuple = @python.PyTuple
typealias PyDict = @python.PyDict
typealias PyList = @python.PyList
typealias Pycallable = @python.PyCallable

pub type! MatplotlibError {
  //LoadMatplotlibError
  LoadPyPlotError
  //LoadColorMapError
  LoadPylabError
  LoadFuncError(String)
  // CallFuncError(String)
} derive(Show)

pub struct Matplotlib {
  // matplotlib: PyModule 
  pyplot: PyModule
  // color_map: PyModule
  pylab: PyModule
}

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


  guard @python.pyimport("pylab") is Some(pylab) else {
    raise LoadPylabError
  }

  Matplotlib::{
    // matplotlib,
    pyplot,
    // color_map,
    pylab,
  }
}

fn pyplot_get_func(fname: String) -> Pycallable!MatplotlibError {
  let lib = singleton()
  guard lib.pyplot.get_attr(fname) is Some(PyCallable(f)) else {
    raise LoadFuncError("Didn't find function : \{fname} in matplotlib.pyplot")
  }
  f
}

fn pylab_get_func(fname: String) -> Pycallable!MatplotlibError {
  let lib = singleton()
  guard lib.pylab.get_attr(fname) is Some(PyCallable(f)) else {
    raise LoadFuncError("Didn't find function : \{fname} in pylab")
  }
  f
}

let singleton : () -> Matplotlib = get_lib()

fn get_lib() -> () -> Matplotlib {
  @python.init_py()
 
  let mlib = match new?() {
    Ok(mlib) => mlib
    Err(e) => {
      println(e)
      panic()
    }
  }

  fn () {mlib}
}

pub fn plot(xs: Array[Double], ys: Array[Double], format~: String = "r") -> Unit{
  let func = pyplot_get_func?("plot").unwrap()

  let xs = xs.map(PyFloat::from) |> PyList::from
  let ys = ys.map(PyFloat::from) |> PyList::from
  let format = @python.PyString::from(format)

  let args = PyTuple::new(3)
  args.set?(0, xs).unwrap()
  args.set?(1, ys).unwrap()
  args.set?(2, format).unwrap()

  let _ = func.invoke(args)
}

pub fn xlim(left: Double, right: Double) -> Unit{
  let func = pyplot_get_func?("xlim").unwrap()

  let left = PyFloat::from(left)
  let right = PyFloat::from(right)

  let list = PyList::from([left, right])
  let args = PyTuple::new(1)
  args.set?(0, list).unwrap()

  let _ = func.invoke(args)
}

pub fn ylim(left: Double, right: Double) -> Unit {
  let func = pyplot_get_func?("ylim").unwrap()

  let left = PyFloat::from(left)
  let right = PyFloat::from(right)

  let list = PyList::from([left, right])
  let args = PyTuple::new(1)
  args.set?(0, list).unwrap()

  let _ = func.invoke(args)
}

pub fn title(
  title_str: String,
) -> Unit {
  let func = pyplot_get_func?("title").unwrap()
  let py_str = PyString::from(title_str)

  let args = PyTuple::new(1)
  args.set?(0, py_str).unwrap()

  let _ = func.invoke(args)
}


pub fn show() -> Unit {
  let func = pyplot_get_func?("show").unwrap()
  let _ = func.invoke(PyTuple::new(0))
}

pub fn save(
  filename: String,
  dpi~: Int = 0
) -> Unit {
  let func = pylab_get_func?("save").unwrap()
  let py_str = PyString::from(filename)

  let args = PyTuple::new(1)
  args.set?(0, py_str).unwrap()
  let kwargs = PyDict::new()

  if dpi > 0 {
    kwargs.set("dpi", PyInteger::from(dpi.to_int64()))
  }

  let _ = func.invoke(args, kwargs = kwargs)
}
