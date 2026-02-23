#import "@preview/cetz:0.4.2"
#import cetz.draw: *
#import cetz.decorations: brace

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 10pt)

#let xL = -5.0
#let xA = -2.0
#let xC = 0.0
#let xB = 2.0
#let xR = 5.0

#cetz.canvas(length: 0.9cm, {
  line((-6.0, 0), (6.0, 0), stroke: 1pt + black, mark: (start: ">", end: ">"))
  for x in (xL, xA, xC, xB, xR) {
    circle((x, 0), radius: 0.05, fill: black, stroke: none)
  }

  content((xL, 0), anchor: "north", dy: -0.12, [$bar(p)$])
  content((xC, 0), anchor: "north", dy: -0.12, [$p$])
  content((xR, 0), anchor: "north", dy: -0.12, [$bar(p)$])

  brace((xL, 0.65), (xA, 0.65), name: "b1")
  content("b1.content", dy: 0.35, [$1/n - x$])
  brace((xA, 0.65), (xC, 0.65), name: "b2")
  content("b2.content", dy: 0.35, [$x$])
  brace((xC, 0.65), (xB, 0.65), name: "b3")
  content("b3.content", dy: 0.35, [$x$])
  brace((xB, 0.65), (xR, 0.65), name: "b4")
  content("b4.content", dy: 0.35, [$1/n - x$])

  content((xA, 1.55), align(center)[Marginal\\consumer])
  line((xA, 1.2), (xA, 0.12), stroke: 1pt + black, mark: (end: ">"))
  content((xB, 1.55), align(center)[Marginal\\consumer])
  line((xB, 1.2), (xB, 0.12), stroke: 1pt + black, mark: (end: ">"))
})
