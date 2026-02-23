#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 10pt)

#cetz.canvas(length: 0.9cm, {
  line((0, 0), (6.6, 0), stroke: 1pt + black, mark: (end: ">"))
  line((0, 0), (0, 5.2), stroke: 1pt + black, mark: (end: ">"))
  content((6.6, 0), anchor: "west", dx: 0.1, [$q$])
  content((0, 5.2), anchor: "south", dy: 0.1, [$p$])

  circle((0, 4.2), radius: 0.04, fill: black, stroke: none)
  content((0, 4.2), anchor: "east", dx: -0.1, [$v$])

  line((0, 4.2), (3.0, 3.0), (5.2, 1.6), stroke: 1pt + black)
  line((3.0, 0), (3.0, 4.8), stroke: (paint: black, thickness: 0.8pt, dash: "dashed"))

  content((3.0, 5.1), [$D$])
  content((5.5, 1.6), anchor: "west", dx: 0.05, [$S$])
})
