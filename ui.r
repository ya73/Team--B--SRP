#import libraries and set working directory
library("shiny", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.0")
library("cummeRbund", lib.loc="/usr/lib/R/site-library") 
setwd("~/cummeRbund_test")

#a page that is not static and changes dynamically
shinyUI(fluidPage(
#title
    titlePanel(title = h1("PIR search", align ="center")),
#contains 2 panels sidebar and main 
    sidebarLayout(
        sidebarPanel(
#generate text above type input box and the input  box
            textInput("name", "enter gene name", ""),
#generate button 
            submitButton("submit"),
#generate yes or no button
            radioButtons("isoform","with isoform?",list("yes", "no")),
#zoom slider genrate
            sliderInput("zoom","zoom %", min = 0, max = 100, value = 0, step = 5, animate = TRUE),
#text that goes above zoom
            textOutput("zoom"),
#drop down choice widget
            selectInput("listgenome", "select genome", c("Rn6","Rn4"), selected = "Rn4", selectize = FALSE)
        ),
        mainPanel(("View"),
#tabs for each output
            tabsetPanel(type= "tab",
#output graph of table
                tabPanel("Individual Expression", plotOutput("expression")),
                tabPanel("VOLCANO!",plotOutput("volcano")),
                tabPanel("Overview", plotOutput("overview"))
            ),
#output in text on the main panel
            textOutput("genename"),
            textOutput("isoform"),
            textOutput("listgenome")
        )    
        )
    ) 
)

