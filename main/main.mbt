///|
fn main {
  let xs = Array::makei(100, fn(i) { i.to_double() / 10.0 })
  let sinx = xs.map(fn(x) { @math.sin(x) })
  let (_, axes) = @plt.subplots(1, 1)

  let ax = axes[0][0]

  ax.plot(xs, sinx, color=@plt.Color::Magenta, linestyle=@plt.LineStyle::DashDot, linewidth=3)
  ax.set_title("Sine Function")
  ax.set_xlabel("x")
  ax.set_ylabel("sin(x)")

  let (l, r) = ax.get_xlim()
  println("l = \{l}, r = \{r}")

  //ax.grid(true)
  @plt.show()
}
