///|
typealias PyModule = @python.PyModule

///|
typealias PyString = @python.PyString

///|
typealias PyInteger = @python.PyInteger

///|
typealias PyFloat = @python.PyFloat

///|
typealias PyBool = @python.PyBool

///|
typealias PyTuple = @python.PyTuple

///|
typealias PyDict = @python.PyDict

///|
typealias PyList = @python.PyList

///|
typealias Pycallable = @python.PyCallable

///|
typealias PyObject = @python.PyObject

///|
typealias PyObjectEnum = @python.PyObjectEnum

///|
pub type! MatplotlibError {
  //LoadMatplotlibError
  LoadPyPlotError
  //LoadColorMapError
  LoadPylabError
  LoadFuncError(String)
  // CallFuncError(String)
} derive(Show)
