///|
pub struct Figure {
  priv obj : PyObject
}

///|
pub fn Figure::elim(self : Figure) -> Unit {
  ignore(self.obj)
}
