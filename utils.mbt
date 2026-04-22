///|
type PyModule = @python.PyModule

///|
type PyString = @python.PyString

///|
type PyInteger = @python.PyInteger

///|
type PyFloat = @python.PyFloat

///|
type PyBool = @python.PyBool

///|
type PyTuple = @python.PyTuple

///|
type PyDict = @python.PyDict

///|
type PyList = @python.PyList

///|
type PyCallable = @python.PyCallable

///|
type PyObject = @python.PyObject

///|
type PyObjectEnum = @python.PyObjectEnum

///|
pub suberror MatplotlibError {
  //LoadMatplotlibError
  LoadPyPlotError
  //LoadColorMapError
  LoadPylabError
  LoadFuncError(String)
  // CallFuncError(String)
}
