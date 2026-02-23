#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 8.5pt)

#let panel-w = 7.5
#let panel-h = 6.5
#let gap = 1.0
#let x-min = 0
#let x-max = 16
#let y-min = 0
#let y-max = 22

#let A = 18
#let c0 = 10
#let c1 = 6
#let Qm0 = (A - c0) / 2
#let Pm0 = (A + c0) / 2
#let Qm1 = (A - c1) / 2
#let Pm1 = (A + c1) / 2
#let Qpc = A - c0

#cetz.canvas(length: 0.75cm, {
  // Panel A: Monopoly
  scope({
    translate((0, 0))
    let X(x) = panel-w * (x - x-min) / (x-max - x-min)
    let Y(y) = panel-h * (y - y-min) / (y-max - y-min)
    let P(x, y) = (X(x), Y(y))
    let dgray = (paint: gray, thickness: 0.5pt, dash: "dashed")

    line(P(0, 0), P(16.4, 0), stroke: 0.9pt + black, mark: (end: ">"))
    line(P(0, 0), P(0, 22.5), stroke: 0.9pt + black, mark: (end: ">"))
    content(P(16.4, 0), anchor: "west", dx: 0.06, [$Q$])
    content(P(0, 22.5), anchor: "south", dy: 0.06, [$P$])
    content((panel-w / 2, panel-h + 0.45), text(weight: "bold")[(a) Monopoly])

    line(P(0, A), P(15, A - 15), stroke: 1pt + black)
    line(P(0, c0), P(15.5, c0), stroke: (paint: rgb("#b0302f"), thickness: 0.8pt, dash: "dashed"))
    line(P(0, c1), P(15.5, c1), stroke: (paint: rgb("#1f4fa3"), thickness: 0.8pt, dash: "dashed"))
    content(P(0, c0), anchor: "east", dx: -0.05, text(size: 7.5pt, fill: rgb("#b0302f"))[$c_0$])
    content(P(0, c1), anchor: "east", dx: -0.05, text(size: 7.5pt, fill: rgb("#1f4fa3"))[$c_1$])

    line(P(0, c0), P(Qm0, c0), P(Qm0, Pm0), P(0, Pm0), close: true, fill: rgb("#f8dede"), stroke: none)
    line(P(0, Pm1), P(Qm0, Pm1), P(Qm0, Pm0), P(0, Pm0), close: true, fill: rgb("#f0a8a8"), stroke: (paint: rgb("#b0302f"), thickness: 0.5pt))
    line(P(0, c1), P(Qm1, c1), P(Qm1, Pm1), P(0, Pm1), close: true, fill: none, stroke: (paint: rgb("#1f4fa3"), thickness: 0.8pt))
    line(P(0, c1), P(Qm1, c1), P(Qm1, c0), P(0, c0), close: true, fill: rgb("#d7e5ff"), stroke: none)
    line(P(Qm0, c0), P(Qm1, c0), P(Qm1, Pm1), P(Qm0, Pm1), close: true, fill: rgb("#d7e5ff"), stroke: none)

    content(P(2.5, 12.5), frame: "rect", fill: white, stroke: none, padding: 0.05, text(size: 7.2pt)[$pi^m(c_0)$ (replaced)])
    content(P(2.5, 13), frame: "rect", fill: white, stroke: none, padding: 0.04, text(size: 6.6pt, fill: rgb("#b0302f"))[lost: 8])
    content(P(7.5, 3), text(size: 7.5pt, fill: rgb("#1f4fa3"))[$Delta pi^m = 20$])
    line(P(7, 3.5), P(6, 7), stroke: (paint: rgb("#1f4fa3"), thickness: 0.8pt), mark: (end: ">"))

    line(P(Qm0, 0), P(Qm0, Pm0), stroke: dgray)
    line(P(Qm1, 0), P(Qm1, Pm1), stroke: dgray)
    content(P(Qm0, 0), anchor: "north", dy: -0.08, text(size: 7pt, fill: gray)[$Q_0^m$])
    content(P(Qm1, 0), anchor: "north", dy: -0.08, text(size: 7pt, fill: gray)[$Q_1^m$])
  })

  // Panel B: Perfect competition
  scope({
    translate((panel-w + gap, 0))
    let X(x) = panel-w * (x - x-min) / (x-max - x-min)
    let Y(y) = panel-h * (y - y-min) / (y-max - y-min)
    let P(x, y) = (X(x), Y(y))
    let dgray = (paint: gray, thickness: 0.5pt, dash: "dashed")

    line(P(0, 0), P(16.4, 0), stroke: 0.9pt + black, mark: (end: ">"))
    line(P(0, 0), P(0, 22.5), stroke: 0.9pt + black, mark: (end: ">"))
    content(P(16.4, 0), anchor: "west", dx: 0.06, [$Q$])
    content(P(0, 22.5), anchor: "south", dy: 0.06, [$P$])
    content((panel-w / 2, panel-h + 0.45), text(weight: "bold")[(b) Perfect competition])

    line(P(0, A), P(15, A - 15), stroke: 1pt + black)
    line(P(0, c0), P(15.5, c0), stroke: (paint: rgb("#b0302f"), thickness: 0.8pt, dash: "dashed"))
    line(P(0, c1), P(15.5, c1), stroke: (paint: rgb("#1f4fa3"), thickness: 0.8pt, dash: "dashed"))
    content(P(0, c0), anchor: "east", dx: -0.05, text(size: 7.5pt, fill: rgb("#b0302f"))[$c_0$])
    content(P(0, c1), anchor: "east", dx: -0.05, text(size: 7.5pt, fill: rgb("#1f4fa3"))[$c_1$])

    content(P(10.5, 10.5), anchor: "west", dx: 0.05, text(size: 7.2pt, fill: rgb("#b0302f"))[Pre-innovation: $pi = 0$])
    line(P(10.5, 10), P(10, 10), stroke: (paint: rgb("#b0302f"), thickness: 0.7pt), mark: (end: ">"))

    line(P(0, c1), P(Qpc, c1), P(Qpc, c0), P(0, c0), close: true, fill: rgb("#d9f1d2"), stroke: (paint: rgb("#4c8f3a"), thickness: 0.8pt))
    content(P(5, 8), frame: "rect", fill: white, stroke: none, padding: 0.05, text(size: 7.2pt)[$Delta pi = 32$ (pc, all new rents)])

    line(P(Qpc, 0), P(Qpc, c0), stroke: dgray)
    content(P(Qpc, 0), anchor: "north", dy: -0.08, text(size: 7pt, fill: gray)[$A-c_0$])
  })
})
