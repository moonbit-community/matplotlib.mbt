///|
fn main {
  let x = Array::makei(100, fn(i) { i.to_double() * 10 / 100 })
  let y = x.map(@math.sin)
  let (_, axes) = @plt.subplots(1, 1)
  axes[0][0]
  ..plot(x, y, color=Greenyellow, linestyle=Dashed, linewidth=5) // Plot Sine of x
  ..set_title("Sine of x")
  ..set_xlabel("x")
  ..set_ylabel("sin(x)")

  //@plt.show()
  @plt.savefig("plot.png")
  @plt.close()
}
