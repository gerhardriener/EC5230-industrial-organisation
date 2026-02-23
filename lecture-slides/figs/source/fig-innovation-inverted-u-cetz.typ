#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 9pt)

#let x-min = 0
#let x-max = 1.1
#let y-min = 0
#let y-max = 1.15
#let w = 11
#let h = 7

#let X(x) = w * (x - x-min) / (x-max - x-min)
#let Y(y) = h * (y - y-min) / (y-max - y-min)
#let P(x, y) = (X(x), Y(y))
#let f(x) = 4 * x * (1 - x)

#let sample(a, b, n) = {
  let pts = ()
  for i in range(0, n + 1) {
    let t = i / n
    let x = a + (b - a) * t
    pts += (P(x, f(x)),)
  }
  pts
}

#cetz.canvas(length: 0.85cm, {
  let dgray = (paint: gray, thickness: 0.6pt, dash: "dashed")
  line(P(0, 0), P(1.15, 0), stroke: 1pt + black, mark: (end: ">"))
  line(P(0, 0), P(0, 1.2), stroke: 1pt + black, mark: (end: ">"))

  content(P(1.15, 0), anchor: "west", dx: 0.12, text(size: 8pt)[Competition intensity])
  content(P(0, 1.2), anchor: "south", dy: 0.12, text(size: 8pt)[Innovation])

  line(..sample(0.02, 0.98, 120), stroke: (paint: rgb("#1f4fa3"), thickness: 1.2pt))

  let xpeak = 0.5
  let ypeak = 1.0
  line(P(xpeak, 0), P(xpeak, ypeak), stroke: dgray)
  line(P(0, ypeak), P(xpeak, ypeak), stroke: dgray)
  circle(P(xpeak, ypeak), radius: 0.05, fill: rgb("#1f4fa3"), stroke: none)

  content(P(0.25, 0.4), text(size: 8pt, fill: rgb("#2f7d32"))[Escape\ competition\ effect\ dominates])
  content(P(0.75, 0.4), text(size: 8pt, fill: rgb("#b0302f"))[Replacement\ (Schumpeterian)\ effect\ dominates])

  line(P(0.15, 0.65), P(0.35, 0.85), stroke: (paint: rgb("#2f7d32"), thickness: 0.9pt), mark: (start: ">"))
  line(P(0.85, 0.65), P(0.65, 0.85), stroke: (paint: rgb("#b0302f"), thickness: 0.9pt), mark: (start: ">"))

  content(P(0.05, 0), anchor: "north", dy: -0.1, text(size: 8pt)[Monopoly])
  content(P(0.92, 0), anchor: "north", dy: -0.1, text(size: 8pt)[Perfect\ competition])
  content(P(0.98, 0.15), anchor: "north-east", dx: -0.05, dy: -0.02, text(size: 7pt, fill: gray)[Aghion et al. (2005)])
})
