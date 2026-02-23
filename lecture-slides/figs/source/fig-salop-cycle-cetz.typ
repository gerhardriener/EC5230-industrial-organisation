#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 6pt)
#set text(size: 10pt)

#let R = 2.2

#cetz.canvas(length: 1cm, {
  circle((0, 0), radius: R, stroke: 1pt + black, fill: none)

  for pt in ((0, R), (R, 0), (0, -R), (-R, 0)) {
    circle(pt, radius: 0.05, fill: black, stroke: none)
  }

  content((0, R), anchor: "south", dy: 0.1, [$bar(p)$])
  content((R, 0), anchor: "west", dx: 0.1, [$bar(p)$])
  content((0, -R), anchor: "north", dy: -0.1, [$p$])
  content((-R, 0), anchor: "east", dx: -0.1, [$bar(p)$])

  for pt in ((-1.75, 1.75), (1.75, 1.75), (-1.75, -1.75), (1.75, -1.75)) {
    content(pt, [$1/4$])
  }
})
