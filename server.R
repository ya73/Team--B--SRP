#import libraries set working directory
library("shiny", lib.loc="~/R/x86_64-pc-linux-gnu-library/3.0")
library("cummeRbund", lib.loc="/usr/lib/R/site-library")
setwd("~/cummeRbund_test")
# make db
cuff_data <- readCufflinks('test_cuffdiff')

shinyServer(
    function(input, output){
#store current gene name
        gen <- reactive({
          input$name
        })
# take inputs from ui.r and convert to outputs usually passed to main panel
        output$genename <- renderText(gen)
        output$isoform <- renderText(input$isoform)
        output$zoom <- renderText(paste(input$zoom, "%"))
        output$listgenome <- renderText(input$listgenome)
#make gene expression plot useing cummeRbund
        output$expression <- renderPlot({
            gene1 <- getGene(cuff_data, gen())
            expressionBarplot(gene1)
        })
#VOLCANO
        output$volcano <- renderPlot({
            vol <- csVolcano(genes(cuff_data),'q1','q2')
            plot(vol)
        })
#overview scatter plot of genes
        output$overview <- renderPlot({
          sca <- csScatter(genes(cuff_data),'q1','q2')
          plot(sca)
        })
        
    }  
)