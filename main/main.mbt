fn main {
  let x : Array[Double] = Array::makei(100, fn (i) {i.to_double()})
  let lnx = x.map(@math.ln)

  @plt.plot(x, lnx)
  @plt.title("log(x)")
  @plt.show()
}
