///|
fn main {
  let n = 5000 // number of data points
  let t : Array[Double] = Array::makei(n, fn(i) {
    2.0 * @math.PI * i.to_double() / n.to_double()
  })
  let xs = t.map(fn(t) { 16.0 * @math.sin(t) * @math.sin(t) * @math.sin(t) })
  let ys = t.map(fn(t) {
    13.0 * @math.cos(t) -
    5.0 * @math.cos(2.0 * t) -
    2.0 * @math.cos(3.0 * t) -
    @math.cos(4.0 * t)
  })
  @plt.plot(
    xs,
    ys,
    color=@plt.Red,
    alpha=0.5,
    linewidth=4,
    linestyle=@plt.Dashed,
  )
  @plt.title("Moonbit x Matplotlib")
  @plt.show()
}
