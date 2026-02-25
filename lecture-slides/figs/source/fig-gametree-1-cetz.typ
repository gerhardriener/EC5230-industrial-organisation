#import "@preview/cetz:0.4.2"
#import cetz.draw: *

#set page(width: auto, height: auto, margin: 12pt)
#set text(size: 10pt)

// Generic two-stage extensive-form game tree
// Coordinates scaled from egame(600,280) ÷100:
//   Player 1 root:  (3, 2.4)
//   Player 2 left:  (1, 1.4)   Player 2 right: (5, 1.4)
//   Leaves (l→r):   (0, 0.4)  (2, 0.4)  (4, 0.4)  (6, 0.4)

#cetz.canvas(length: 1.4cm, {

  // --- Branches ---
  line((3, 2.4), (1, 1.4), stroke: 1pt + black)
  line((3, 2.4), (5, 1.4), stroke: 1pt + black)
  line((1, 1.4), (0, 0.4), stroke: 1pt + black)
  line((1, 1.4), (2, 0.4), stroke: 1pt + black)
  line((5, 1.4), (4, 0.4), stroke: 1pt + black)
  line((5, 1.4), (6, 0.4), stroke: 1pt + black)

  // --- Decision nodes (filled) ---
  circle((3, 2.4), radius: 0.07, fill: black, stroke: none)
  circle((1, 1.4), radius: 0.07, fill: black, stroke: none)
  circle((5, 1.4), radius: 0.07, fill: black, stroke: none)

  // --- Terminal nodes (hollow) ---
  circle((0, 0.4), radius: 0.07, fill: white, stroke: 1pt + black)
  circle((2, 0.4), radius: 0.07, fill: white, stroke: 1pt + black)
  circle((4, 0.4), radius: 0.07, fill: white, stroke: 1pt + black)
  circle((6, 0.4), radius: 0.07, fill: white, stroke: 1pt + black)

  // --- Player labels (above each decision node) ---
  content((3, 2.4), anchor: "south", dy: 0.18, [Player 1])
  content((1, 1.4), anchor: "south", dy: 0.18, [Player 2])
  content((5, 1.4), anchor: "south", dy: 0.18, [Player 2])

  // --- Action labels at branch midpoints (dx ≥ 0.20 for clearance from branch line) ---
  // Root → P2-left  midpoint (2, 1.9): label left of branch
  content((2, 1.9), anchor: "east", dx: -0.20, dy: 0.08, [Action $L$])
  // Root → P2-right midpoint (4, 1.9): label right of branch
  content((4, 1.9), anchor: "west", dx: 0.20, dy: 0.08, [Action $R$])
  // P2-left → leaf a midpoint (0.5, 0.9): label left
  content((0.5, 0.9), anchor: "east", dx: -0.20, dy: 0.08, [Action $l$])
  // P2-left → leaf b midpoint (1.5, 0.9): label right
  content((1.5, 0.9), anchor: "west", dx: 0.20, dy: 0.08, [Action $r$])
  // P2-right → leaf c midpoint (4.5, 0.9): label left
  content((4.5, 0.9), anchor: "east", dx: -0.20, dy: 0.08, [Action $l$])
  // P2-right → leaf d midpoint (5.5, 0.9): label right
  content((5.5, 0.9), anchor: "west", dx: 0.20, dy: 0.08, [Action $r$])

  // --- Payoff labels (below terminal nodes) ---
  content((0, 0.4), anchor: "north", dy: -0.15, [$(a_1, a_2)$])
  content((2, 0.4), anchor: "north", dy: -0.15, [$(b_1, b_2)$])
  content((4, 0.4), anchor: "north", dy: -0.15, [$(c_1, c_2)$])
  content((6, 0.4), anchor: "north", dy: -0.15, [$(d_1, d_2)$])
})
