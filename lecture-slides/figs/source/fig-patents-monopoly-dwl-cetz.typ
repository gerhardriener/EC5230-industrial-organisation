#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 9pt)

#let sta-blue = rgb("#00539B")
#let sta-red = rgb("#EE312A")

#let A = 16
#let MC = 4
#let Qm = (A - MC) / 2
#let Pm = (A + MC) / 2
#let Qc = A - MC

#let x-min = 0
#let x-max = 15
#let y-min = 0
#let y-max = 17
#let w = 11
#let h = 7
#let X(x) = w * (x - x-min) / (x-max - x-min)
#let Y(y) = h * (y - y-min) / (y-max - y-min)
#let P(x, y) = (X(x), Y(y))
#let d(x) = A - x
#let mr(x) = A - 2 * x

#let curve(f, a, b, n) = {
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
  line(P(0, 0), P(15.4, 0), stroke: 1pt + black, mark: (end: ">"))
  line(P(0, 0), P(0, 17.5), stroke: 1pt + black, mark: (end: ">"))
  content(P(15.4, 0), anchor: "west", dx: 0.1, [$Q$])
  content(P(0, 17.5), anchor: "south", dy: 0.08, [$P$])

  line(P(0, Pm), P(Qm, Pm), P(0, A), close: true, fill: luma(85%), stroke: (paint: luma(80%), thickness: 0.4pt))
  line(P(0, MC), P(Qm, MC), P(Qm, Pm), P(0, Pm), close: true, fill: sta-blue.lighten(75%), stroke: (paint: sta-blue.lighten(35%), thickness: 0.6pt))
  line(P(Qm, MC), P(Qm, Pm), P(Qc, MC), close: true, fill: sta-red.lighten(75%), stroke: (paint: sta-red.lighten(35%), thickness: 0.6pt))

  line(..curve(d, 0, 14.5, 2), stroke: (paint: black, thickness: 1.2pt))
  line(..curve(mr, 0, A / 2, 2), stroke: (paint: gray, thickness: 0.9pt, dash: "dashed"))
  line(P(0, MC), P(14, MC), stroke: (paint: luma(35%), thickness: 1.1pt))

  line(P(Qm, 0), P(Qm, Pm), stroke: dgray)
  line(P(0, Pm), P(Qm, Pm), stroke: dgray)
  line(P(Qc, 0), P(Qc, MC), stroke: dgray)

  content(P(Qm, 0), anchor: "north", dy: -0.1, text(size: 8pt)[$Q^m$])
  content(P(Qc, 0), anchor: "north", dy: -0.1, text(size: 8pt)[$Q^c$])
  content(P(0, Pm), anchor: "east", dx: -0.08, text(size: 8pt)[$P^m$])
  content(P(0, MC), anchor: "east", dx: -0.08, text(size: 8pt)[$c$])

  content(P(13, 1.5), anchor: "north-west", dx: 0.05, text(size: 8pt)[$P=A-Q$])
  content(P(7, 2.5), anchor: "north-east", dx: -0.05, text(size: 8pt, fill: gray)[MR])
  content(P(12.5, 4.4), anchor: "south-west", dx: 0.05, text(size: 8pt, fill: luma(35%))[MC = c])

  content(P(3, 7), frame: "rect", fill: white, stroke: none, padding: 0.06, text(size: 8pt, weight: "bold", fill: sta-blue)[$pi nu$])
  content(P(8, 6), frame: "rect", fill: white, stroke: none, padding: 0.06, text(size: 8pt, weight: "bold", fill: sta-red)[$lambda nu$])
  content(P(2, 12.5), frame: "rect", fill: white, stroke: none, padding: 0.06, text(size: 8pt, weight: "bold", fill: gray)[CS^m])

  content(P(8.5, 15.5), anchor: "north-west", frame: "rect", fill: white, stroke: (paint: luma(80%), thickness: 0.4pt), padding: 0.08, text(size: 8pt, fill: luma(35%))[Competitive CS; $pi + lambda < 1$])
})
