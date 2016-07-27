an app that displays individual expression of genes from 
#the cuff diff results of or anlysis
#ui side of things
#import libraries 
library("cummeRbund")
library("shiny")

#make sqlite db in form of cuff object of the cuff diff objects
cuff_data4 <- readCufflinks('cuff_diff_RN4')
cuff_data6 <- readCufflinks('cuff_diff_RN6')

#ui functions is fluid page so updates contanstly and can change
#in layout and in reaction to user
 shinyUI(
    fluidPage(
      titlePanel(title = h1("PIR search", align ="center")),
#first panel populated by a form like item where users can input
# a gene name by typing and cliking submit 
      sidebarLayout(position = "left",
        sidebarPanel(
          textInput("name", "enter gene name", ""),
          submitButton("submit")
        ),
# mian panel displays plots in reaction to user output 
        mainPanel(
# divide into 3 tabs
          tabsetPanel(type="tab",
# output plots for overall expression of gene 
# for both rn4 an rn6 in the form of table and a boxplot
            tabPanel("Individual Expression",
            fluidRow(
               splitLayout("RN4","RN6"),
               splitLayout(plotOutput("rn4"),plotOutput("rn6")),
               splitLayout(tableOutput("RN4_table"),tableOutput("RN6_table"))
                    )
            ),
#output plots for individual isoform expression of gene 
#for both rn4 an rn6 in the form of table and a boxplot
            tabPanel("Individul Isoform Expression",
              fluidRow(
                splitLayout("RN4","RN6"),
                splitLayout(plotOutput("rn4_I"),plotOutput("rn6_I")),
                splitLayout(tableOutput("RN4_table_I"),tableOutput("RN6_table_I"))
              )    
            ),
# output plots of overall expression in the form of a table
# and a scatter plot.
            tabPanel("Overview",
              titlePanel(title = h1("RN4", align ="left")),
              textOutput("all_table4"),
              plotOutput("scatter4"),
              plotOutput("box4"),
              titlePanel(title = h1("RN6", align ="left")),
              textOutput("all_table6"),
              plotOutput("scatter6"),
              plotOutput("box6")
            )
            )
          )
        ) 
      )
    )
