#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 8.5pt)

#let panel-w = 7.4
#let panel-h = 6.6
#let x-gap = 1.0

#let x-min = 0
#let x-max = 19
#let y-min = 0
#let y-max = 19

#let draw-panel(dx: 0, title: [], c0: 10, c1: 6, drastic: false) = {
  scope({
    translate((dx, 0))

    let X(x) = panel-w * (x - x-min) / (x-max - x-min)
    let Y(y) = panel-h * (y - y-min) / (y-max - y-min)
    let P(x, y) = (X(x), Y(y))
    let A = 18
    let Pm = (A + c1) / 2
    let Qm = (A - c1) / 2
    let Qpc = A - c0
    let dgray = (paint: gray, thickness: 0.5pt, dash: "dashed")

    // Axes and title
    line(P(0, 0), P(19.4, 0), stroke: 0.9pt + black, mark: (end: ">"))
    line(P(0, 0), P(0, 19.4), stroke: 0.9pt + black, mark: (end: ">"))
    content(P(19.4, 0), anchor: "west", dx: 0.08, [$Q$])
    content(P(0, 19.4), anchor: "south", dy: 0.08, [$P$])
    content((panel-w / 2, panel-h + 0.45), text(weight: "bold")[#title])

    // Demand and horizontal lines
    line(P(0, A), P(A, 0), stroke: 1pt + black)
    line(P(0, c0), P(18, c0), stroke: (paint: rgb("#b0302f"), thickness: 0.8pt, dash: "dashed"))
    line(P(0, c1), P(18, c1), stroke: (paint: rgb("#1f4fa3"), thickness: 0.8pt, dash: "dashed"))
    line(P(0, Pm), P(18, Pm), stroke: (paint: rgb("#5e84c9"), thickness: 0.7pt, dash: "dotted"))

    content(P(0, c0), anchor: "east", dx: -0.06, text(size: 7.5pt, fill: rgb("#b0302f"))[$c_0$])
    content(P(0, c1), anchor: "east", dx: -0.06, text(size: 7.5pt, fill: rgb("#1f4fa3"))[$c_1$])
    content(P(0, Pm), anchor: "east", dx: -0.06, text(size: 7.5pt, fill: rgb("#5e84c9"))[$P^m(c_1)$])

    if drastic {
      line(P(0, c1), P(Qm, c1), P(Qm, Pm), P(0, Pm), close: true,
        fill: rgb("#cfe0ff"), stroke: (paint: rgb("#1f4fa3"), thickness: 0.8pt))
      line(P(Qm, 0), P(Qm, Pm), stroke: dgray)
      content(P(Qm, 0), anchor: "north", dy: -0.08, text(size: 7.5pt, fill: gray)[$Q^m(c_1)$])
      line(P(15, Pm), P(15, c0), stroke: (paint: rgb("#b0302f"), thickness: 0.8pt), mark: (start: ">", end: ">"))
      content(P(15.2, (Pm + c0) / 2), anchor: "west", dx: 0.06, text(size: 7pt, fill: rgb("#b0302f"))[$P^m(c_1) < c_0$\ drastic])
      content(P(4.6, 6.2), frame: "rect", fill: white, stroke: none, padding: 0.05, text(size: 7.2pt)[Unconstrained monopoly\ profit $pi^m(c_1)$])
    } else {
      line(P(0, c1), P(Qpc, c1), P(Qpc, c0), P(0, c0), close: true,
        fill: rgb("#d9f1d2"), stroke: (paint: rgb("#4c8f3a"), thickness: 0.8pt))
      line(P(Qpc, 0), P(Qpc, c0), stroke: dgray)
      content(P(Qpc, 0), anchor: "north", dy: -0.08, text(size: 7.5pt, fill: gray)[$A-c_0$])
      line(P(15, c0), P(15, Pm), stroke: (paint: rgb("#b0302f"), thickness: 0.8pt), mark: (start: ">", end: ">"))
      content(P(15.2, (Pm + c0) / 2), anchor: "west", dx: 0.06, text(size: 7pt, fill: rgb("#b0302f"))[$P^m(c_1) > c_0$\ non-drastic])
      content(P(4.1, 8), frame: "rect", fill: white, stroke: none, padding: 0.05, text(size: 7.2pt)[Limit-pricing profit\ $(c_0-c_1)(A-c_0)$])
    }

    content(P(11.8, 2.0), anchor: "south-west", text(size: 7pt)[$P=A-Q$])
  })
}

#cetz.canvas(length: 0.75cm, {
  draw-panel(dx: 0, title: [(a) Non-drastic], c0: 10, c1: 6, drastic: false)
  draw-panel(dx: panel-w + x-gap, title: [(b) Drastic], c0: 10, c1: 1, drastic: true)
})
