library(shiny)
library(shinydashboard)
library(shinyjs)

# Define UI for application
ui <- navbarPage(
  title = "Student Performance Explorer",
  
  tags$style(HTML("
    .navbar { background-color: #256a92; }
    .navbar-default .navbar-nav > li > a { color: #ffffff; }
    .navbar-header .navbar-brand { color: #ffffff !important; font-size: 24px; }
    
    .about-page {
      background-color: #f4f7f8;
      color: #333333;
      display: flex;
      flex-direction: column;
      justify-content: center;
      align-items: center;
      text-align: center;
      padding: 40px 20px;
      border-radius: 10px;
      box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    }
    .about-page h1 {
      color: #256a92;
      font-size: 36px;
      font-weight: bold;
      margin-bottom: 20px;
    }
    .about-page p {
      font-size: 18px;
      line-height: 1.8;
      margin: 15px 0;
      color: #555555;
      max-width: 800px;
      text-align: left;
    }
    .about-page h2 {
      font-size: 22px;
      margin-top: 30px;
      color: #256a92;
    }
    .about-page a {
      color: #256a92;
      text-decoration: none;
      font-weight: bold;
    }
    .about-page a:hover {
      text-decoration: underline;
    }
  ")),
  
  tabPanel("About",
           fluidPage(
             div(class = "about-page",
                 h1("About This Application"),
                 p("This application provides a comprehensive analysis of student performance across various academic subjects."),
                 p("The analysis considers the following factors: Gender, Ethnicity/Race, Parental Education Level, Lunch Type, and Test Preparation Course."),
                 h2("Developed By"),
                 p("Ali Haider (Student ID: 22F-8803)")
             )
           )
  ),
  
  tabPanel("Math Scores", 
           plotOutput("math_histogram"),
           tableOutput("math_table"),
           plotOutput("math_distribution"),
           plotOutput("math_regression"),
           verbatimTextOutput("math_confidence")
  ),
  
  tabPanel("Reading Scores", 
           plotOutput("reading_histogram"),
           tableOutput("reading_table"),
           plotOutput("reading_distribution"),
           plotOutput("reading_regression"),
           verbatimTextOutput("reading_confidence")  # <-- Closed the parentheses here
  ),
  
  tabPanel("Writing Scores", 
           plotOutput("writing_histogram"),
           tableOutput("writing_table"),
           plotOutput("writing_distribution"),
           plotOutput("writing_regression"),
           verbatimTextOutput("writing_confidence")
  )
)
