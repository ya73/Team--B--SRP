#an app that displays individual expression of genes from 
#the cuff diff results of or anlysis
#server side of things
library("cummeRbund")
library("shiny")

# process string passed form the gene search applet so the
# the first letter is a capital modified version of code 
#from http://stackoverflow.com/questions/6364783/capitalize-the-first-letter-of-both-words-in-a-two-word-string
simpleCap <- function(x) {
  s <- strsplit(x, " ")[[1]]
  paste(toupper(substring(s, 1,1)), substring(s, 2),
        sep="", collapse=" ")
}

#make sqlite db in form of cuff object of the cuff diff objects
cuff_data4 <- readCufflinks('cuff_diff_RN4')
cuff_data6 <- readCufflinks('cuff_diff_RN6')

#shiny server takes inputs from ui.R
#and makes output obejcts that ui.R can detect and se
shinyServer(function(input, output) {
# make caps at the begining of gene name make obejct to store result
  gen <- reactive({
    simpleCap(input$name)
  })
# make an isoform expression bar plot of RN4 useing gene name and cummerRbund
#functions. Pakaged in output object to be used by ui.R 
  output$rn4_I <- renderPlot({
    gene1 <- getGene(cuff_data4, gen())
      expressionBarplot(isoforms(gene1))
  })
# make an isoform  table plot of RN4 useing gene name and cummerRbund
#functions. Pakaged in output object to be used by ui.R   
  output$RN4_table_I <- renderTable({
    gene1 <- getGene(cuff_data4, gen())
    head(fpkm(isoforms(gene1)))
    
  })
# make an isoform expression bar plot of RN6 useing gene name and cummerRbund
#functions. Pakaged in output object to be used by ui.R   
  output$rn6_I <- renderPlot({
    gene2 <- getGene(cuff_data6, gen())
      expressionBarplot(isoforms(gene2))
  })
# make an isoform table plot of RN6 useing gene name and cummerRbund
#functions. Pakaged in output object to be used by ui.R   
  output$RN6_table_I <- renderTable({
    gene2 <- getGene(cuff_data6, gen())
    head(fpkm(isoforms(gene2)))
    
  })
# make an expression bar plot of RN4 useing gene name and cummerRbund
#functions. Pakaged in output object to be used by ui.R 
  output$rn4 <- renderPlot({
    gene1 <- getGene(cuff_data4, gen())
    expressionBarplot(gene1)
  })

# make an expression bar plot of RN6 useing gene name and cummerRbund
#functions. Pakaged in output object to be used by ui.R   
  output$rn6 <- renderPlot({
    gene2 <- getGene(cuff_data6, gen())
    expressionBarplot(gene2)
  })
# make an table of RN4 useing gene name and cummerRbund
#functions. Pakaged in output object to be used by ui.R 
  output$RN4_table<- renderTable({
    gene1 <- getGene(cuff_data4, gen())
    head(fpkm(gene1))
    
  })
# make an expression bar plot of RN6 useing gene name and cummerRbund
#functions. Pakaged in output object to be used by ui.R   
  output$RN6_table<- renderTable({
    gene1 <- getGene(cuff_data6, gen())
    head(fpkm(gene1))
    
  })
# used in overview page some genaral stats of cuff diff 6 data
  output$all_table4<- renderPrint({
    cuff_data4
  })
# used in overview page some genaral stats of cuff diff 6 data
  output$all_table6<- renderPrint({
    cuff_data6
  })
 # used in overview page some genaral stats of cuff diff data in form of a scatter plot
  output$scatter4<- renderPlot({
    sca <- csScatter(genes(cuff_data4),'PIR','CTRL')
    plot(sca)
  })
# used in overview page some genaral stats of cuff diff data in form of a scatter plot
  output$scatter6<- renderPlot({
    sca <- csScatter(genes(cuff_data6),'PIR','CTRL')
    plot(sca)
  })
# used in overview page some genaral stats of cuff diff data in form of a box plot
  output$box4<- renderPlot({
    csBoxplot(genes(cuff_data4))
  })
# used in overview page some genaral stats of cuff diff data in form of a box plot
  output$box6<- renderPlot({
    csBoxplot(genes(cuff_data6))
  })
  
})

