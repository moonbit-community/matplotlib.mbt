///|
pub struct Figure {
  priv obj : PyObject
}

///|
pub fn elim(self : Figure) -> Unit {
  ignore(self.obj)
}
