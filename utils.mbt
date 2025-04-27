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
pub type! MatplotlibError {
  //LoadMatplotlibError
  LoadPyPlotError
  //LoadColorMapError
  LoadPylabError
  LoadFuncError(String)
  // CallFuncError(String)
} derive(Show)
