library(shiny)
library(dplyr)
library(ggplot2)
library(MASS)  # For confidence interval calculation

# Read data from CSV file
students_data <- read.csv("Modified_StudentsPerformance.csv")

# Define server logic required to analyze the data
server <- function(input, output, session) {
  
  # Summary Statistics: mean, median, sd, IQR, etc.
  descriptive_stats <- function(data) {
    data_summary <- data.frame(
      Mean = mean(data),
      Median = median(data),
      SD = sd(data),
      IQR = IQR(data)
    )
    return(data_summary)
  }
  
  # Render a histogram of math scores
  output$math_histogram <- renderPlot({
    ggplot(students_data, aes(x = math.score)) +
      geom_histogram(binwidth = 5, fill = "#3c8dbc", color = "white", alpha = 0.8) +
      labs(title = "Math Score Distribution", x = "Math Score", y = "Frequency") +
      theme_minimal()
  })
  
  # Tabular representation of Math Data
  output$math_table <- renderTable({
    descriptive_stats(students_data$math.score)
  })
  
  # Probability Distribution for math scores
  output$math_distribution <- renderPlot({
    ggplot(students_data, aes(x = math.score)) +
      geom_histogram(aes(y = ..density..), binwidth = 5, fill = "#3c8dbc", color = "white", alpha = 0.6) +
      stat_function(fun = dnorm, args = list(mean = mean(students_data$math.score), sd = sd(students_data$math.score)), color = "#e74c3c", size = 1) +
      labs(title = "Math Probability Distribution", x = "Math Score", y = "Density") +
      theme_minimal()
  })
  
  # Regression model for math scores
  output$math_regression <- renderPlot({
    ggplot(students_data, aes(x = reading.score, y = math.score)) +
      geom_point(color = "#3c8dbc", size = 2) +
      geom_smooth(method = "lm", se = FALSE, color = "#e74c3c", size = 1.2) +
      labs(title = "Regression Model for Math Scores", x = "Reading Score", y = "Math Score") +
      theme_minimal()
  })
  
  # Confidence interval for math score regression model
  output$math_confidence <- renderPrint({
    model <- lm(math.score ~ reading.score, data = students_data)
    confint(model)
  })
  
  # Repeat the above process for Reading and Writing Scores
  
  # Reading Histogram
  output$reading_histogram <- renderPlot({
    ggplot(students_data, aes(x = reading.score)) +
      geom_histogram(binwidth = 5, fill = "#00a65a", color = "white", alpha = 0.8) +
      labs(title = "Reading Score Distribution", x = "Reading Score", y = "Frequency") +
      theme_minimal()
  })
  
  output$reading_table <- renderTable({
    descriptive_stats(students_data$reading.score)
  })
  
  output$reading_distribution <- renderPlot({
    ggplot(students_data, aes(x = reading.score)) +
      geom_histogram(aes(y = ..density..), binwidth = 5, fill = "#00a65a", color = "white", alpha = 0.6) +
      stat_function(fun = dnorm, args = list(mean = mean(students_data$reading.score), sd = sd(students_data$reading.score)), color = "#27ae60", size = 1) +
      labs(title = "Reading Probability Distribution", x = "Reading Score", y = "Density") +
      theme_minimal()
  })
  
  output$reading_regression <- renderPlot({
    ggplot(students_data, aes(x = writing.score, y = reading.score)) +
      geom_point(color = "#00a65a", size = 2) +
      geom_smooth(method = "lm", se = FALSE, color = "#27ae60", size = 1.2) +
      labs(title = "Regression Model for Reading Scores", x = "Writing Score", y = "Reading Score") +
      theme_minimal()
  })
  
  output$reading_confidence <- renderPrint({
    model <- lm(reading.score ~ writing.score, data = students_data)
    confint(model)
  })
  
  # Writing Histogram
  output$writing_histogram <- renderPlot({
    ggplot(students_data, aes(x = writing.score)) +
      geom_histogram(binwidth = 5, fill = "#f39c12", color = "white", alpha = 0.8) +
      labs(title = "Writing Score Distribution", x = "Writing Score", y = "Frequency") +
      theme_minimal()
  })
  
  output$writing_table <- renderTable({
    descriptive_stats(students_data$writing.score)
  })
  
  output$writing_distribution <- renderPlot({
    ggplot(students_data, aes(x = writing.score)) +
      geom_histogram(aes(y = ..density..), binwidth = 5, fill = "#f39c12", color = "white", alpha = 0.6) +
      stat_function(fun = dnorm, args = list(mean = mean(students_data$writing.score), sd = sd(students_data$writing.score)), color = "#f1c40f", size = 1) +
      labs(title = "Writing Probability Distribution", x = "Writing Score", y = "Density") +
      theme_minimal()
  })
  
  output$writing_regression <- renderPlot({
    ggplot(students_data, aes(x = math.score, y = writing.score)) +
      geom_point(color = "#f39c12", size = 2) +
      geom_smooth(method = "lm", se = FALSE, color = "#f1c40f", size = 1.2) +
      labs(title = "Regression Model for Writing Scores", x = "Math Score", y = "Writing Score") +
      theme_minimal()
  })
  
  output$writing_confidence <- renderPrint({
    model <- lm(writing.score ~ math.score, data = students_data)
    confint(model)
  })
}

