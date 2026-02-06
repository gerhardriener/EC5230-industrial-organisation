library(shiny)
library(ggplot2)

# Define plotting theme for consistency
theme_econ <- theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", hjust = 0.5),
    axis.title = element_text(face = "italic"),
    panel.grid.minor = element_blank()
  )

# UI Definition
ui <- fluidPage(
  titlePanel("Cournot Duopoly Profit Possibility Frontier"),

  sidebarLayout(
    sidebarPanel(
      sliderInput(
        "a",
        label = "Demand Intercept (a):",
        min = 13,
        max = 15,
        value = 14,
        step = 0.1
      ),
      sliderInput(
        "b",
        label = "Demand Slope (b):",
        min = 1,
        max = 15,
        value = 1,
        step = 0.5
      ),
      sliderInput(
        "ci",
        label = "Marginal Cost Firm i (ci):",
        min = 0,
        max = 5,
        value = 0,
        step = 0.5
      ),
      sliderInput(
        "cj",
        label = "Marginal Cost Firm j (cj):",
        min = 0,
        max = 5,
        value = 0,
        step = 0.5
      ),
      hr(),
      h4("Minimum Profit Constraints"),
      helpText(
        "Set minimum acceptable profit levels to explore individually rational outcomes."
      ),
      uiOutput("minmaxi_slider"),
      uiOutput("minmaxj_slider"),
      hr(),
      helpText("Original concept by Flavio Toxvaerd (University of Cambridge).")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel(
          "Interactive Graph",
          br(),
          plotOutput("frontierPlot", height = "550px")
        ),
        tabPanel(
          "Mathematical Details",
          withMathJax(),
          h3("The Model"),
          p("The market is characterized by the inverse demand function:"),
          p("$$p = a - b(q_i + q_j)$$"),
          h4("Key Profit Levels"),
          tags$ul(
            tags$li("\\(\\pi_i^C, \\pi_j^C\\): Cournot equilibrium profits"),
            tags$li(
              "\\(\\pi_i^M, \\pi_j^M\\): Monopoly profits (if the other firm produces 0)"
            ),
            tags$li("\\(\\pi_i^A, \\pi_j^A\\): Equal-split collusion profits"),
            tags$li(
              "\\(\\pi_i^D, \\pi_j^s\\): Stackelberg leader/follower profits"
            )
          ),
          h4("The Frontier"),
          p(
            "The profit possibility frontier shows all Pareto-efficient combinations of profits for the two firms."
          ),
          p(
            "Points inside the frontier are inefficient - both firms could be made better off."
          ),
          p(
            "The Cournot equilibrium typically lies inside the frontier, demonstrating the inefficiency of non-cooperative competition."
          ),
          h4("Collusion"),
          p(
            "The frontier represents outcomes achievable through collusion. The equal-split collusion point (A) gives each firm half the joint monopoly profit."
          )
        )
      )
    )
  )
)

# Server Definition
server <- function(input, output, session) {
  # Calculate key profit values
  profit_vals <- reactive({
    a <- input$a
    b <- input$b
    ci <- input$ci
    cj <- input$cj

    # Cournot equilibrium profits
    pi_i_C <- (a - 2 * ci + cj)^2 / (9 * b)
    pi_j_C <- (a + ci - 2 * cj)^2 / (9 * b)

    # Monopoly profits (if other firm produces 0)
    pi_i_M <- (a - ci)^2 / (4 * b)
    pi_j_M <- (a - cj)^2 / (4 * b)

    # Equal-split collusion profits (half of joint monopoly)
    pi_i_A <- (a - ci)^2 / (8 * b)
    pi_j_A <- (a - cj)^2 / (8 * b)

    # Stackelberg profits (i as leader, j as follower)
    pi_i_D <- (3 * a - 4 * ci + cj)^2 / (64 * b)
    pi_j_s <- (3 * a + 4 * ci - 7 * cj) * (a - cj) / (32 * b)

    list(
      pi_i_C = pi_i_C,
      pi_j_C = pi_j_C,
      pi_i_M = pi_i_M,
      pi_j_M = pi_j_M,
      pi_i_A = pi_i_A,
      pi_j_A = pi_j_A,
      pi_i_D = pi_i_D,
      pi_j_s = pi_j_s
    )
  })

  # Dynamic slider for minimum profit i (up to Cournot profit)
  output$minmaxi_slider <- renderUI({
    vals <- profit_vals()
    sliderInput(
      "minmaxi",
      label = "Min Profit Firm i:",
      min = 0,
      max = round(vals$pi_i_C, 2),
      value = 0,
      step = 0.5
    )
  })

  # Dynamic slider for minimum profit j (up to Cournot profit)
  output$minmaxj_slider <- renderUI({
    vals <- profit_vals()
    sliderInput(
      "minmaxj",
      label = "Min Profit Firm j:",
      min = 0,
      max = round(vals$pi_j_C, 2),
      value = 0,
      step = 0.5
    )
  })

  # Generate the profit possibility frontier
  output$frontierPlot <- renderPlot({
    a <- input$a
    b <- input$b
    ci <- input$ci
    cj <- input$cj
    minmaxi <- if (is.null(input$minmaxi)) 0 else input$minmaxi
    minmaxj <- if (is.null(input$minmaxj)) 0 else input$minmaxj

    vals <- profit_vals()

    # Generate the frontier curve parametrically
    # The frontier is traced by varying qi and computing corresponding profits
    qi_seq <- seq(0.01, 10, length.out = 500)

    # For each qi, compute qj that lies on the frontier and corresponding profits
    # Using the formulas from the Mathematica notebook
    frontier_data <- lapply(qi_seq, function(qi) {
      # Compute discriminant term
      disc <- a^2 -
        4 * a * ci +
        4 * ci^2 +
        2 * a * cj -
        4 * ci * cj +
        cj^2 +
        8 * b * ci * qi -
        8 * b * cj * qi

      if (disc < 0) {
        return(NULL)
      }

      # qj on frontier
      qj <- -(-3 * a + 2 * ci + cj + 4 * b * qi + sqrt(disc)) / (4 * b)

      if (qj < 0) {
        return(NULL)
      }

      # Profits
      pi_i <- qi * (a - ci - b * (qi + qj))
      pi_j <- qj * (a - cj - b * (qi + qj))

      if (pi_i < 0 || pi_j < 0) {
        return(NULL)
      }

      data.frame(pi_i = pi_i, pi_j = pi_j)
    })

    frontier_df <- do.call(rbind, frontier_data)
    frontier_df <- frontier_df[!is.na(frontier_df$pi_i), ]

    # Create plot
    p <- ggplot() +
      # Profit Possibility Frontier curve
      geom_path(
        data = frontier_df,
        aes(x = pi_i, y = pi_j),
        color = "blue",
        linewidth = 1.2
      ) +

      # Cournot Equilibrium point
      annotate(
        "point",
        x = vals$pi_i_C,
        y = vals$pi_j_C,
        color = "black",
        size = 4
      ) +
      annotate(
        "text",
        x = vals$pi_i_C + 2,
        y = vals$pi_j_C + 2,
        label = "C",
        fontface = "bold",
        size = 5
      ) +

      # Equal-split collusion point (A)
      annotate(
        "point",
        x = vals$pi_i_A,
        y = vals$pi_j_A,
        color = "black",
        size = 4
      ) +
      annotate(
        "text",
        x = vals$pi_i_A + 2,
        y = vals$pi_j_A + 2,
        label = "A",
        fontface = "bold",
        size = 5
      ) +

      # Stackelberg point (D, s)
      annotate(
        "point",
        x = vals$pi_i_D,
        y = vals$pi_j_s,
        color = "black",
        size = 4
      ) +
      annotate(
        "text",
        x = vals$pi_i_D + 2,
        y = vals$pi_j_s - 2,
        label = "S",
        fontface = "bold",
        size = 5
      ) +

      # Dashed lines to Cournot point
      annotate(
        "segment",
        x = vals$pi_i_C,
        xend = vals$pi_i_C,
        y = 0,
        yend = vals$pi_j_C,
        linetype = "dashed",
        color = "gray50"
      ) +
      annotate(
        "segment",
        x = 0,
        xend = vals$pi_i_C,
        y = vals$pi_j_C,
        yend = vals$pi_j_C,
        linetype = "dashed",
        color = "gray50"
      ) +

      # Dashed lines to Equal-split point
      annotate(
        "segment",
        x = vals$pi_i_A,
        xend = vals$pi_i_A,
        y = 0,
        yend = vals$pi_j_A,
        linetype = "dashed",
        color = "gray50"
      ) +
      annotate(
        "segment",
        x = 0,
        xend = vals$pi_i_A,
        y = vals$pi_j_A,
        yend = vals$pi_j_A,
        linetype = "dashed",
        color = "gray50"
      ) +

      # Dashed lines to Stackelberg point
      annotate(
        "segment",
        x = vals$pi_i_D,
        xend = vals$pi_i_D,
        y = 0,
        yend = vals$pi_j_s,
        linetype = "dashed",
        color = "gray50"
      ) +
      annotate(
        "segment",
        x = 0,
        xend = vals$pi_i_D,
        y = vals$pi_j_s,
        yend = vals$pi_j_s,
        linetype = "dashed",
        color = "gray50"
      ) +

      # Minimum profit constraint lines (if set > 0)
      {
        if (minmaxi > 0) {
          annotate(
            "segment",
            x = minmaxi,
            xend = minmaxi,
            y = 0,
            yend = 50,
            linetype = "dotted",
            color = "red",
            linewidth = 0.8
          )
        }
      } +
      {
        if (minmaxj > 0) {
          annotate(
            "segment",
            x = 0,
            xend = 50,
            y = minmaxj,
            yend = minmaxj,
            linetype = "dotted",
            color = "red",
            linewidth = 0.8
          )
        }
      } +

      # Axis labels with key points marked
      scale_x_continuous(
        breaks = c(
          round(vals$pi_i_C, 1),
          round(vals$pi_i_M, 1),
          round(vals$pi_i_A, 1),
          round(vals$pi_i_D, 1)
        ),
        labels = c(
          expression(pi[i]^C),
          expression(pi[i]^M),
          expression(pi[i]^A),
          expression(pi[i]^D)
        )
      ) +
      scale_y_continuous(
        breaks = c(
          round(vals$pi_j_C, 1),
          round(vals$pi_j_M, 1),
          round(vals$pi_j_A, 1),
          round(vals$pi_j_s, 1)
        ),
        labels = c(
          expression(pi[j]^C),
          expression(pi[j]^M),
          expression(pi[j]^A),
          expression(pi[j]^s)
        )
      ) +

      # Formatting
      coord_cartesian(xlim = c(0, 50), ylim = c(0, 50)) +
      labs(
        title = "Profit Possibility Frontier under Cournot Competition",
        x = expression(pi[i]),
        y = expression(pi[j])
      ) +
      theme_econ +
      theme(
        axis.text = element_text(face = "bold"),
        plot.title = element_text(size = 14)
      )

    p
  })
}

# Run the app
shinyApp(ui = ui, server = server)
