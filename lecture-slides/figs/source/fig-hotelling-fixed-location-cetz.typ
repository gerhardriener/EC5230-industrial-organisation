#import "@preview/cetz:0.4.2"
#import cetz.draw: *
#import cetz.decorations: brace

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 10pt)

#let xO = 0
#let xFone = 3
#let xMC = 6
#let xFtwo = 9
#let xL = 12

#cetz.canvas(length: 1cm, {
  // Baseline
  line((xO, 0), (xL, 0), stroke: 1pt + black)

  // Points
  for x in (xO, xFone, xMC, xFtwo, xL) {
    circle((x, 0), radius: 0.06, fill: black, stroke: none)
  }

  // Endpoint labels
  content((xO, 0), anchor: "east", dx: -0.15, [$0$])
  content((xL, 0), anchor: "west", dx: 0.15, [$L$])

  // Braces and labels
  brace((xO, 0.55), (xFone, 0.55), name: "brace-a")
  content("brace-a.content", dy: 0.35, [$a$])

  brace((xFone, 0.55), (xMC, 0.55), name: "brace-x")
  content("brace-x.content", dy: 0.35, [$x$])

  brace((xMC, 0.55), (xFtwo, 0.55), name: "brace-y")
  content("brace-y.content", dy: 0.35, [$y$])

  brace((xFtwo, 0.55), (xL, 0.55), name: "brace-b")
  content("brace-b.content", dy: 0.35, [$b$])

  // Firm labels and arrows
  content((xFone, 1.45), [Firm 1])
  line((xFone, 1.2), (xFone, 0.12), mark: (end: ">"))

  content((xFtwo, 1.45), [Firm 2])
  line((xFtwo, 1.2), (xFtwo, 0.12), mark: (end: ">"))

  // Marginal consumer label and arrow
  content((xMC, -1.15), align(center)[Marginal\\consumer])
  line((xMC, -0.75), (xMC, -0.08), mark: (end: ">"))
})
