///|
fnalias @math.(sin, cos)

///|
const PI : Double = @math.PI

///|
fn main {
  let n = 5000 // number of data points
  let t : Array[Double] = Array::makei(n, fn(i) {
    2.0 * PI * i.to_double() / n.to_double()
  })
  let xs = t.map(fn(t) { 16.0 * sin(t) * sin(t) * sin(t) })
  let ys = t.map(fn(t) {
    13.0 * cos(t) - 5.0 * cos(2.0 * t) - 2.0 * cos(3.0 * t) - cos(4.0 * t)
  })
  let (_, ax) = @plt.subplots()
  ax.plot(xs, ys, color=@plt.Red, linewidth=5)
  ax.set_title("Moonbit x Matplotlib")
  @plt.show()
}
