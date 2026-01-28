library(shiny)
library(ggplot2)

# Define plotting theme for consistency
theme_econ <- theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.title = element_text(face = "italic"),
    panel.grid = element_blank(),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

# UI Definition
ui <- fluidPage(
  titlePanel("Salop Circular City Model"),

  sidebarLayout(
    sidebarPanel(
      h4("Consumer Location"),
      sliderInput(
        "consumer_angle",
        label = "Consumer position (degrees):",
        min = 0,
        max = 360,
        value = 90,
        step = 1
      ),
      hr(),
      h4("Firm 1 Prices"),
      helpText("Firm 1 is located at the top (90°)"),
      sliderInput(
        "p12",
        label = "Price towards Firm 2 (p₁₂):",
        min = -30,
        max = 90,
        value = 30,
        step = 1
      ),
      sliderInput(
        "p13",
        label = "Price towards Firm 3 (p₁₃):",
        min = 90,
        max = 210,
        value = 150,
        step = 1
      ),
      hr(),
      h4("Firm 2 Prices"),
      helpText("Firm 2 is located at bottom-right (330°)"),
      sliderInput(
        "p21",
        label = "Price towards Firm 1 (p₂₁):",
        min = -30,
        max = 90,
        value = 30,
        step = 1
      ),
      sliderInput(
        "p23",
        label = "Price towards Firm 3 (p₂₃):",
        min = 210,
        max = 330,
        value = 270,
        step = 1
      ),
      hr(),
      h4("Firm 3 Prices"),
      helpText("Firm 3 is located at bottom-left (210°)"),
      sliderInput(
        "p31",
        label = "Price towards Firm 1 (p₃₁):",
        min = 90,
        max = 210,
        value = 150,
        step = 1
      ),
      sliderInput(
        "p32",
        label = "Price towards Firm 2 (p₃₂):",
        min = 210,
        max = 330,
        value = 270,
        step = 1
      ),
      hr(),
      helpText("Original concept by Flavio Toxvaerd (University of Cambridge).")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel(
          "Interactive Graph",
          br(),
          plotOutput("circlePlot", height = "550px", width = "550px"),
          br(),
          verbatimTextOutput("marketShares")
        ),
        tabPanel(
          "Mathematical Details",
          withMathJax(),
          h3("The Salop Circular City Model"),
          p(
            "The Salop model is a spatial model of product differentiation where:"
          ),
          tags$ul(
            tags$li(
              "Consumers are uniformly distributed around a circle of circumference 1"
            ),
            tags$li("Firms are located at fixed positions on the circle"),
            tags$li("Consumers incur transportation costs to reach a firm"),
            tags$li(
              "Each consumer buys from the firm offering the lowest total cost (price + transport)"
            )
          ),
          h4("Model Setup"),
          p("In this example, 3 firms are equally spaced around the circle:"),
          tags$ul(
            tags$li(strong("Firm 1"), " (Blue) at 90° (top)"),
            tags$li(strong("Firm 2"), " (Green) at 330° (bottom-right)"),
            tags$li(strong("Firm 3"), " (Red) at 210° (bottom-left)")
          ),
          h4("Market Boundaries"),
          p(
            "The boundary between two firms' markets is determined by the indifferent consumer:"
          ),
          p("$$p_i + t \\cdot d_i = p_j + t \\cdot d_j$$"),
          p(
            "where \\(t\\) is the transport cost per unit distance and \\(d\\) is the distance to each firm."
          ),
          h4("Interpretation of Sliders"),
          p(
            "The price sliders control the location of the indifferent consumer between each pair of firms. Higher prices push the boundary towards the firm, reducing its market share."
          ),
          h4("Equilibrium"),
          p(
            "In the symmetric equilibrium with equal costs, all firms charge the same price and each captures 1/3 of the market."
          )
        )
      )
    )
  )
)

# Server Definition
server <- function(input, output, session) {
  # Calculate market boundaries based on prices
  market_data <- reactive({
    # Firm positions in degrees
    firm1_pos <- 90 # Top
    firm2_pos <- 330 # Bottom-right
    firm3_pos <- 210 # Bottom-left

    # Price parameters control boundary positions
    # Boundary between Firm 1 and Firm 2 (clockwise from Firm 1)
    boundary_12 <- (30 - input$p21 + input$p12)

    # Boundary between Firm 1 and Firm 3 (counter-clockwise from Firm 1)
    boundary_13 <- (150 - input$p13 + input$p31)

    # Boundary between Firm 2 and Firm 3
    boundary_23 <- (270 - input$p23 + input$p32)

    # Market share arcs (in degrees)
    # Firm 1: from boundary_12 to boundary_13
    firm1_start <- boundary_12
    firm1_end <- boundary_13

    # Firm 3: from boundary_13 to boundary_23
    firm3_start <- boundary_13
    firm3_end <- boundary_23

    # Firm 2: from boundary_23 to boundary_12 (wrapping around)
    firm2_start <- boundary_23 - 360 # Adjust for wraparound
    firm2_end <- boundary_12

    list(
      firm1_start = firm1_start,
      firm1_end = firm1_end,
      firm2_start = firm2_start,
      firm2_end = firm2_end,
      firm3_start = firm3_start,
      firm3_end = firm3_end,
      boundary_12 = boundary_12,
      boundary_13 = boundary_13,
      boundary_23 = boundary_23
    )
  })

  # Plot the circular city
  output$circlePlot <- renderPlot({
    data <- market_data()
    consumer_rad <- input$consumer_angle * pi / 180

    # Create circle data
    theta <- seq(0, 2 * pi, length.out = 361)
    circle_df <- data.frame(x = cos(theta), y = sin(theta))

    # Firm positions
    firm1_x <- cos(90 * pi / 180)
    firm1_y <- sin(90 * pi / 180)
    firm2_x <- cos(330 * pi / 180)
    firm2_y <- sin(330 * pi / 180)
    firm3_x <- cos(210 * pi / 180)
    firm3_y <- sin(210 * pi / 180)

    # Consumer position
    consumer_x <- cos(consumer_rad)
    consumer_y <- sin(consumer_rad)

    # Create arc data for each firm's market
    create_arc <- function(start_deg, end_deg, n = 100) {
      # Handle wraparound
      if (end_deg < start_deg) {
        theta1 <- seq(start_deg, 360, length.out = n / 2) * pi / 180
        theta2 <- seq(0, end_deg, length.out = n / 2) * pi / 180
        theta <- c(theta1, theta2)
      } else {
        theta <- seq(start_deg, end_deg, length.out = n) * pi / 180
      }
      data.frame(x = cos(theta), y = sin(theta))
    }

    # Create arcs for each firm
    arc1 <- create_arc(data$firm1_start, data$firm1_end)
    arc2 <- create_arc(data$firm2_start + 360, data$firm2_end + 360)
    arc3 <- create_arc(data$firm3_start, data$firm3_end)

    # Base plot
    p <- ggplot() +
      # Draw market share arcs
      geom_path(
        data = arc1,
        aes(x = x, y = y),
        color = "blue",
        linewidth = 6,
        alpha = 0.8
      ) +
      geom_path(
        data = arc3,
        aes(x = x, y = y),
        color = "red",
        linewidth = 6,
        alpha = 0.8
      ) +
      geom_path(
        data = arc2,
        aes(x = x, y = y),
        color = "green",
        linewidth = 6,
        alpha = 0.8
      ) +

      # Draw thin circle outline
      geom_path(
        data = circle_df,
        aes(x = x, y = y),
        color = "gray80",
        linewidth = 0.5
      ) +

      # Firm 1 (Blue - top)
      annotate("point", x = firm1_x, y = firm1_y, color = "black", size = 8) +
      annotate("point", x = firm1_x, y = firm1_y, color = "blue", size = 6) +
      annotate(
        "text",
        x = firm1_x,
        y = firm1_y + 0.15,
        label = "Firm 1",
        fontface = "bold",
        size = 5
      ) +

      # Firm 2 (Green - bottom-right)
      annotate("point", x = firm2_x, y = firm2_y, color = "black", size = 8) +
      annotate("point", x = firm2_x, y = firm2_y, color = "green", size = 6) +
      annotate(
        "text",
        x = firm2_x + 0.15,
        y = firm2_y - 0.15,
        label = "Firm 2",
        fontface = "bold",
        size = 5
      ) +

      # Firm 3 (Red - bottom-left)
      annotate("point", x = firm3_x, y = firm3_y, color = "black", size = 8) +
      annotate("point", x = firm3_x, y = firm3_y, color = "red", size = 6) +
      annotate(
        "text",
        x = firm3_x - 0.15,
        y = firm3_y - 0.15,
        label = "Firm 3",
        fontface = "bold",
        size = 5
      ) +

      # Consumer position (red dot)
      annotate(
        "point",
        x = consumer_x,
        y = consumer_y,
        color = "darkred",
        size = 4
      ) +
      annotate(
        "text",
        x = consumer_x * 1.30,
        y = consumer_y * 1.30,
        label = "Consumer",
        color = "darkred",
        size = 4
      ) +

      # Formatting
      coord_fixed(xlim = c(-1.4, 1.4), ylim = c(-1.4, 1.4)) +
      labs(title = "Salop Circular City Model\nMarket Shares with 3 Firms") +
      theme_econ

    # Add legend
    p <- p +
      annotate(
        "rect",
        xmin = 0.8,
        xmax = 1.4,
        ymin = 0.9,
        ymax = 1.4,
        fill = "white",
        color = "black"
      ) +
      annotate(
        "text",
        x = 1.1,
        y = 1.32,
        label = "Market covered by:",
        size = 3.5,
        fontface = "bold"
      ) +
      annotate(
        "segment",
        x = 0.85,
        xend = 1.0,
        y = 1.2,
        yend = 1.2,
        color = "blue",
        linewidth = 2
      ) +
      annotate("text", x = 1.2, y = 1.2, label = "Firm 1", size = 3.5) +
      annotate(
        "segment",
        x = 0.85,
        xend = 1.0,
        y = 1.08,
        yend = 1.08,
        color = "green",
        linewidth = 2
      ) +
      annotate("text", x = 1.2, y = 1.08, label = "Firm 2", size = 3.5) +
      annotate(
        "segment",
        x = 0.85,
        xend = 1.0,
        y = 0.96,
        yend = 0.96,
        color = "red",
        linewidth = 2
      ) +
      annotate("text", x = 1.2, y = 0.96, label = "Firm 3", size = 3.5)

    p
  })

  # Display market shares
  output$marketShares <- renderText({
    data <- market_data()

    # Calculate market shares (as proportion of circle)
    # Each firm's arc length as fraction of 360 degrees
    share1 <- abs(data$firm1_end - data$firm1_start) / 360
    share3 <- abs(data$firm3_end - data$firm3_start) / 360
    share2 <- 1 - share1 - share3

    # Ensure non-negative
    share1 <- max(0, min(1, share1))
    share2 <- max(0, min(1, share2))
    share3 <- max(0, min(1, share3))

    paste0(
      "Market Shares (approximate):\n",
      "  Firm 1 (Blue):  ",
      sprintf("%.1f%%", share1 * 100),
      "\n",
      "  Firm 2 (Green): ",
      sprintf("%.1f%%", share2 * 100),
      "\n",
      "  Firm 3 (Red):   ",
      sprintf("%.1f%%", share3 * 100)
    )
  })
}

# Run the app
shinyApp(ui = ui, server = server)
