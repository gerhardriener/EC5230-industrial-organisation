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
  titlePanel("The (Residual) Monopolist's Best Response"),

  sidebarLayout(
    sidebarPanel(
      sliderInput(
        "a",
        label = "Demand Intercept (a):",
        min = 15,
        max = 20,
        value = 15,
        step = 0.5
      ),
      sliderInput(
        "b",
        label = "Demand Slope (b):",
        min = 0.75,
        max = 5,
        value = 0.75,
        step = 0.25
      ),
      sliderInput(
        "ci",
        label = "Marginal Cost (c):",
        min = 2,
        max = 5,
        value = 2,
        step = 0.5
      ),
      sliderInput(
        "qj",
        label = "Rival Output (qj):",
        min = 0,
        max = 20,
        value = 6.4,
        step = 0.1
      ),
      hr(),
      helpText("Original concept by Flavio Toxvaerd (University of Cambridge).")
    ),

    mainPanel(
      tabsetPanel(
        tabPanel(
          "Interactive Graphs",
          br(),
          plotOutput("profitPlot", height = "350px"),
          plotOutput("brPlot", height = "350px")
        ),
        tabPanel(
          "Mathematical Details",
          withMathJax(),
          h3("The Model"),
          p("The market is characterized by the inverse demand function:"),
          p("$$p = a - b(q_i + q_j)$$"),
          p("Where:"),
          tags$ul(
            tags$li("\\(q_i\\) is the quantity of the firm."),
            tags$li("\\(q_j\\) is the quantity produced by the firm's rivals."),
            tags$li("\\(a\\) and \\(b\\) are demand parameters.")
          ),
          p("The firm has constant marginal cost \\(c\\)."),
          h4("The Panels"),
          p(
            strong("Upper Panel:"),
            "Shows the profit function. Increasing \\(q_j\\) shifts this curve left."
          ),
          p(
            strong("Lower Panel:"),
            "Plots the different combinations of \\(q_j\\) and the accompanying (privately) optimal production \\(q_i\\). This curve traces out the Cournot firm's Best Response (or reaction function)."
          )
        )
      )
    )
  )
)

# Server Definition
server <- function(input, output, session) {
  # Reactive Optimization Calculation
  # Calculates optimal qi given the current inputs
  opt_vals <- reactive({
    a <- input$a
    b <- input$b
    ci <- input$ci
    qj <- input$qj

    # Optimal qi (Reaction to qj)
    # Derived from FOC of Profit = qi * (a - ci - b(qi + qj))
    qi_opt <- (a - ci - b * qj) / (2 * b)

    # Max Profit at that qi
    pi_max <- qi_opt * (a - ci - b * (qi_opt + qj))

    # Monopoly Reference (if qj were 0)
    qi_mon <- (a - ci) / (2 * b)
    pi_mon <- qi_mon * (a - ci - b * qi_mon)

    # Clamp negative quantities to 0 for display safety
    if (qi_opt < 0) {
      qi_opt <- 0
      pi_max <- 0
    }

    list(qi = qi_opt, pi = pi_max, qi_mon = qi_mon, pi_mon = pi_mon)
  })

  # Plot 1: The Profit Function (Parabola)
  output$profitPlot <- renderPlot({
    a <- input$a
    b <- input$b
    ci <- input$ci
    qj <- input$qj
    vals <- opt_vals()

    # Create data for curves
    qi_seq <- seq(0, 20, length.out = 300)

    # Current Profit Curve (Blue)
    pi_curr <- qi_seq * (a - ci - b * (qi_seq + qj))

    # Monopoly Reference Curve (Dashed Black)
    pi_ref <- qi_seq * (a - ci - b * qi_seq)

    df <- data.frame(qi = qi_seq, pi_curr = pi_curr, pi_ref = pi_ref)

    ggplot(df, aes(x = qi)) +
      # Reference Curve (qj = 0)
      geom_line(
        aes(y = pi_ref),
        linetype = "dashed",
        color = "black",
        alpha = 0.6
      ) +
      # Current Curve (Actual qj)
      geom_line(aes(y = pi_curr), color = "blue", linewidth = 1.2) +

      # Points and Drop lines for Optimal
      annotate("point", x = vals$qi, y = vals$pi, color = "blue", size = 4) +
      annotate(
        "segment",
        x = vals$qi,
        xend = vals$qi,
        y = 0,
        yend = vals$pi,
        linetype = "dotted",
        color = "blue"
      ) +

      # Points and Drop lines for Monopoly Reference
      annotate(
        "point",
        x = vals$qi_mon,
        y = vals$pi_mon,
        color = "black",
        size = 2,
        alpha = 0.5
      ) +
      annotate(
        "segment",
        x = vals$qi_mon,
        xend = vals$qi_mon,
        y = 0,
        yend = vals$pi_mon,
        linetype = "dotted",
        color = "black",
        alpha = 0.5
      ) +

      # Labels and Limits
      labs(
        title = "Residual Monopolist's Profit",
        x = expression(q[i]),
        y = expression(pi[i](q[i], q[j]))
      ) +
      coord_cartesian(ylim = c(-10, 75), xlim = c(0, 20)) +
      theme_econ
  })

  # Plot 2: Best Response Function
  output$brPlot <- renderPlot({
    a <- input$a
    b <- input$b
    ci <- input$ci
    qj_curr <- input$qj
    qi_opt <- opt_vals()$qi

    # The Best Response Function: qi = (a - ci - b*qj) / 2b
    # Rearrange for plotting qj on Y: qj = (a - ci)/b - 2*qi

    qi_seq <- seq(0, 20, length.out = 100)
    qj_line <- (a - ci) / b - 2 * qi_seq

    df_br <- data.frame(qi = qi_seq, qj = qj_line)
    df_br <- df_br[df_br$qj >= 0, ]

    ggplot() +
      # The Best Response Line
      geom_line(data = df_br, aes(x = qi, y = qj), linewidth = 1.2) +

      # Current State Point
      annotate("point", x = qi_opt, y = qj_curr, color = "blue", size = 4) +

      # Drop lines to axes
      annotate(
        "segment",
        x = qi_opt,
        xend = qi_opt,
        y = 0,
        yend = qj_curr,
        linetype = "dashed",
        color = "gray"
      ) +
      annotate(
        "segment",
        x = 0,
        xend = qi_opt,
        y = qj_curr,
        yend = qj_curr,
        linetype = "dashed",
        color = "gray"
      ) +

      labs(
        title = "Best Response Function",
        x = expression(q[i]),
        y = expression(paste(q[j], " (Rival Output)"))
      ) +
      coord_cartesian(ylim = c(0, 20), xlim = c(0, 20)) +
      theme_econ
  })
}

# Run the app
shinyApp(ui = ui, server = server)
