/////|
//fn main {
//  let xs = Array::makei(100, fn(i) { i.to_double() / 10.0 })
//  let sinx = xs.map(fn(x) { @math.sin(x) })
//  let (_, axes) = @plt.subplots(1, 1)
//  let ax = axes[0][0]
//  ax.plot(
//    xs,
//    sinx,
//    color=@plt.Color::Darkslateblue,
//    linestyle=@plt.LineStyle::DashDot,
//    linewidth=3,
//  )
//  ax.set_title("Sine Function")
//  ax.set_xlabel("x")
//  ax.set_ylabel("sin(x)")
//  ax.text(5, 0, "sin", color=@plt.Color::Lightpink, fontsize=16)
//
//  //ax.grid(true)
//  @plt.show()
//}

let sin = @math.sin

fn main {
  let x = Array::makei(100, fn(i) { i.to_double() * 10 / 100})
  let y = x.map(sin)

  let (_, axes) = @plt.subplots(1, 1)
  let ax = axes[0][0]

  ax.plot(x, y, color = @plt.Color::Green, linestyle = @plt.Dashed, linewidth = 2)
  ax.set_title("Sine Function")
  @plt.show()
}
