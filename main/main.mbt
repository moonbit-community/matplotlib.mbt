///|
fn main {
  let x = Array::makei(100, fn(i) { i.to_double() * 10 / 100 })
  let y = x.map(@math.sin)
  let (_, axes) = @plt.subplots(1, 1)
  let ax = axes[0][0]
  ax.plot(x, y, color=Greenyellow, linestyle=Dashed, linewidth=5) // Plot Sine of x
  ax.set_title("Sine of x")
  ax.set_xlabel("x")
  ax.set_ylabel("sin(x)")

  //@plt.show()
  @plt.savefig("plot.png")
  @plt.close()
}
