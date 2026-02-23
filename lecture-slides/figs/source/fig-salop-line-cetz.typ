#import "@preview/cetz:0.4.2"
#import cetz.draw: *
#import cetz.decorations: brace

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 10pt)

#let xL = -4.5
#let xC = 0
#let xR = 4.5

#cetz.canvas(length: 0.9cm, {
  line((-5.5, 0), (5.5, 0), stroke: 1pt + black, mark: (start: ">", end: ">"))

  for x in (xL, xC, xR) {
    circle((x, 0), radius: 0.05, fill: black, stroke: none)
  }

  content((xL, 0), anchor: "north", dy: -0.12, [$bar(p)$])
  content((xC, 0), anchor: "north", dy: -0.12, [$p$])
  content((xR, 0), anchor: "north", dy: -0.12, [$bar(p)$])

  brace((xL, 0.6), (xC, 0.6), name: "lbrace")
  content("lbrace.content", dy: 0.35, [$1/n$])
  brace((xC, 0.6), (xR, 0.6), name: "rbrace")
  content("rbrace.content", dy: 0.35, [$1/n$])
})
