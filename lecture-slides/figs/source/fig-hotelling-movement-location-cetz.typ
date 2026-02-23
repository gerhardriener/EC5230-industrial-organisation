#import "@preview/cetz:0.4.2"
#import cetz.draw: *
#import cetz.decorations: brace

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 10pt)

#let xO = 0
#let xM = 6
#let xL = 12

#cetz.canvas(length: 1cm, {
  line((xO, 0), (xL, 0), stroke: 1pt + black)
  for x in (xO, xM, xL) {
    circle((x, 0), radius: 0.06, fill: black, stroke: none)
  }

  content((xO, 0), anchor: "east", dx: -0.15, [$0$])
  content((xL, 0), anchor: "west", dx: 0.15, [$L$])

  brace((xO, 0.55), (xM, 0.55), name: "brace-a")
  content("brace-a.content", dy: 0.35, [$a$])
  brace((xM, 0.55), (xL, 0.55), name: "brace-b")
  content("brace-b.content", dy: 0.35, [$b$])

  content((xM, 1.45), [Firms 1 and 2])
  line((xM, 1.2), (xM, 0.12), mark: (end: ">"))

  content((xM, -1.15), [Marginal consumer])
  line((xM, -0.75), (xM, -0.08), mark: (end: ">"))
})
