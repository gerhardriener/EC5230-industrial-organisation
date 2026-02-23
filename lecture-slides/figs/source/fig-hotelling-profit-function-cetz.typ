#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 9pt)

#let x-min = 0
#let x-max = 10.6
#let y-min = 0
#let y-max = 5.2
#let w = 12.8
#let h = 6.0

#let X(x) = w * (x - x-min) / (x-max - x-min)
#let Y(y) = h * (y - y-min) / (y-max - y-min)
#let P(x, y) = (X(x), Y(y))

#let xL = 3.25
#let xM = 6.20
#let xR = 8.35
#let yTop = 4.70
#let yDrop = 2.55
#let yPeak = 3.85
#let k = (yPeak - yDrop) / ((xL - xM) * (xL - xM))
#let yR = yPeak - k * (xR - xM) * (xR - xM)
#let yPar(x) = yPeak - k * (x - xM) * (x - xM)

#let sample-curve(f, a, b, n) = {
  let pts = ()
  for i in range(0, n + 1) {
    let t = i / n
    let x = a + (b - a) * t
    pts += (P(x, f(x)),)
  }
  pts
}

#cetz.canvas(length: 0.75cm, {
  line(P(0, 0), P(10.9, 0), stroke: 1pt + black, mark: (end: ">"))
  line(P(0, 0), P(0, 5.35), stroke: 1pt + black, mark: (end: ">"))
  content(P(10.9, 0), anchor: "west", dx: 0.15, [$p_1$])
  content(P(0, 5.35), anchor: "south", dy: 0.12, [$pi_1(p_1, bar(p)_2)$])

  line(P(0, 0), P(xL, yTop), stroke: 1pt + black)
  line(P(xL, yTop), P(xL, yDrop), stroke: 1pt + black)
  line(..sample-curve(yPar, xL, xR, 80), stroke: 1pt + black)

  let dgray = (paint: gray, thickness: 0.8pt, dash: "dashed")
  line(P(xL, 0), P(xL, yTop), stroke: dgray)
  line(P(xM, 0), P(xM, yPeak), stroke: dgray)
  line(P(xR, 0), P(xR, yR), stroke: dgray)

  content(P(xL, 0), anchor: "north", dy: -0.12, [$bar(p)_2 - c(L-a-b)$])
  content(P(xM, 0), anchor: "north", dy: -0.12, [$bar(p)_1$])
  content(P(xR, 0), anchor: "north", dy: -0.12, [$bar(p)_2 + c(L-a-b)$])
})
