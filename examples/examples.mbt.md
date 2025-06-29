## Heart Curve

```moonbit
fnalias @math.(sin, cos)
const PI : Double = @math.PI
test "heart_curve" {
  let n = 5000 // number of data points
  let t : Array[Double] = Array::makei(n, fn(i) {
    2.0 * PI * i.to_double() / n.to_double()
  })
  let xs = t.map(fn(t) { 16.0 * sin(t) * sin(t) * sin(t) })
  let ys = t.map(fn(t) {
    13.0 * cos(t) - 5.0 * cos(2.0 * t) - 2.0 * cos(3.0 * t) - cos(4.0 * t)
  })

  let (_, ax) = @plt.subplots(1, 1)
  ax[0][0].plot(xs, ys, color=@plt.Red, linewidth=5)
  ax[0][0].set_title("Moonbit x Matplotlib")
  @plt.show()
}
```

## Math functions

```moonbit
test "math_funcs" {
  let xs = Array::makei(100, fn(i) { i.to_double() / 10.0 })
  let square = xs.map(fn(x) { x * x })
  let exps = xs.map(fn(x) { @math.exp(x) })
  let sinx = xs.map(fn(x) { @math.sin(x) })
  let logx = xs.map(fn(x) { @math.ln(x) })
  let (_, axes) = @plt.subplots(2, 2, figsize=(10, 8))

  // Square function
  axes[0][0].plot(xs, square, color=@plt.Red, linewidth=3)
  axes[0][0].set_title("Square Function")

  // Exponential function
  axes[0][1].plot(xs, exps,
    color=@plt.Green,
    linestyle=@plt.Dashed,
    linewidth=3,
  )
  axes[0][1].set_title("Exponential Function")

  // Sine function
  axes[1][0].plot(xs, sinx, color=@plt.Blue, linestyle=@plt.Dotted, linewidth=3)
  axes[1][0].set_title("Sine Function")

  // Logarithm function
  axes[1][1].plot(xs, logx,
    color=@plt.Magenta,
    linestyle=@plt.DashDot,
    linewidth=3,
  )
  axes[1][1].set_title("Logarithm Function")
  @plt.show()
}
```

