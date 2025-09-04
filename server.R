# server for transmittance and absorbance learning module

shinyServer(function(input, output) {
  
  output$sets = renderImage({
    if(input$set_opt == "Cuvette Key"){
      list(src = "www/cuvette_key.png", height = "95%")}
    else if(input$set_opt == "Set 1"){
      list(src = "www/set_one.png", height = "95%")}
    else if(input$set_opt == "Set 2"){
      list(src = "www/set_two.png", height = "95%")}
    else if(input$set_opt == "Set 3"){
      list(src = "www/set_three.png", height = "95%")}
  }, deleteFile = FALSE)

# code for activity 1 (power and transmittance)
  
output$activty1plot = renderPlot({
  
  if (input$plotoption == "none"){
    epsilon = 1 - input$epsilon
    photonsleft = round(1000 * (epsilon)^(seq(0,50)),0)
    plot(x = 1, y = -1, pch = 19, col = 1,
         xlim = c(0,1), xlab = "distance (cm)", ylab = "",
         bty = "n", ylim = c(0,1), asp = 1, yaxt = "n")
    text(x = 0.01, y = 0.9, pos = 4, cex = 2,
         labels = bquote(P[0] == 1000))
    text(x = 0.99, y = 0.1, pos = 2, cex = 2,
         labels = bquote(P[T] == .(photonsleft[51])))
    lines(x = c(0,1), y = c(0,0), lwd = 2, col = 1)
    lines(x = c(1,1), y = c(0,1), lwd = 2, col = 1)
    lines(x = c(1,0), y = c(1,1), lwd = 2, col = 1)
    lines(x = c(0,0), y = c(1,0), lwd = 2, col = 1)
  } else
  
  if (input$plotoption == "cross-section plot"){
    epsilon = 1 - input$epsilon
    photonsleft = round(1000 * (epsilon)^(seq(0,50)),0)
    plot(x = 1, y = -1, pch = 19, col = 1,
         xlim = c(0,1), xlab = "distance (cm)", ylab = "", 
         bty = "n", ylim = c(0,1), asp = 1, yaxt = "n")
    text(x = 0.01, y = 0.9, pos = 4, cex = 2,
         labels = bquote(P[0] == 1000))
    text(x = 0.99, y = 0.1, pos = 2, cex = 2,
         labels = bquote(P[T] == .(photonsleft[51])))
    lines(x = c(0,1), y = c(0,0), lwd = 2, col = 1)
    lines(x = c(1,1), y = c(0,1), lwd = 2, col = 1)
    lines(x = c(1,0), y = c(1,1), lwd = 2, col = 1)
    lines(x = c(0,0), y = c(1,0), lwd = 2, col = 1)
    for (i in 1:51){
      inc = i - 1
      y = runif(photonsleft[i], min = 0, max = 1)
      x = rep(inc/50, photonsleft[i])
      points(x = x, y = y, pch = 19, col = 6, cex = 0.1)
    } 
  } else
  
  if (input$plotoption == "P(d) vs. d"){
    epsilon = 1 - input$epsilon
    photonsleft = round(1000 * (epsilon)^(seq(0,50)),0)
    plot(x = seq(0,1,0.02), y = photonsleft, 
         type = "p", col = 6, pch = 19,
         xlim = c(0,1), xlab = "distance (cm)", 
         ylim = c(0,1000), ylab = "number of photons")
    grid()
  }
  
})

# code for activity 2

  output$activity2plot = renderPlot({
    
    if (input$linearize == "none"){
      old.par = par(mar = c(4,4,1,2))
      pd = round(1000 * (0.92)^(seq(0,50)),0)
      plot(x = seq(0,1,0.02), y = pd, 
           type = "p", col = 6, pch = 19,
           xlim = c(0,1), xlab = "distance (cm)", 
           ylim = c(0,1000), ylab = "number of photons")
      grid()
      par(old.par)
    } else
      
    if (input$linearize == "model 1"){
      old.par = par(mar = c(4,4,1,2))
      pd = round(1000 * (0.92)^(seq(0,50)),0)
      x = seq(0,1,0.02)
      plot(x = x, y = pd, 
           type = "p", col = 6, pch = 19,
           xlim = c(0,1), xlab = "distance (cm)", 
           ylim = c(0,1000), ylab = "number of photons")
      y = 999.9 * exp(-0.08339 * seq(0,50))
      lines(x = x, y = y, lwd = 2, col = 6)
      grid()
      par(old.par)
    } else
    
    if (input$linearize == "model 2"){
      old.par = par(mar = c(4,4,1,2))
      pd = round(1000 * (0.92)^(seq(0,50)),0)
      x = seq(0,1,0.02)
      plot(x = x, y = log(pd), 
           type = "p", col = 6, pch = 19,
           xlim = c(0,1), xlab = "distance (cm)", 
           ylim = c(0,log(1000)), ylab = "ln(number of photons)")
      y = 999.9 * exp(-0.08339 * seq(0,50))
      lines(x = x, y = log(y), lwd = 2, col = 6)
      grid()
      par(old.par)
    } else
    
    if (input$linearize == "model 3"){
      old.par = par(mar = c(4,4,1,2))
      pd = round(1000 * (0.92)^(seq(0,50)),0)
      x = seq(0,1,0.02)
      plot(x = x, y = log(pd/1000), 
           type = "p", col = 6, pch = 19,
           xlim = c(0,1), xlab = "distance", 
           ylim = c(-7,0), ylab = "ln(number of photons/1000)")
      y = 999.9 * exp(-0.08339 * seq(0,50))
      lines(x = x, y = log(y/1000), lwd = 2, col = 6)
      grid()
      par(old.par)
    }
  })
  
  model = reactive({
    if (input$linearize == "model 1"){
      d = seq(0,50)
      P0 = 1000
      P = round(1000 * (0.92)^(d),0)
      model1 = nls(P ~ P0 * exp(-k * d), start = list(P0 = 1000, k = 0.08))
      print(model1)
    } else
    
    if (input$linearize == "model 2"){
      d = seq(0,50)
      P0 = 1000
      P = round(1000 * (0.92)^(d),0)
      model2 = lm(log(P) ~  d)
      print(model2)
    } else

    if (input$linearize == "model 3"){
      d = seq(0,50)
      P0 = 1000
      P = round(1000 * (0.92)^(d),0)
      model3 = lm(log(P/P0) ~ d)
      print(model3)
    }
    
  })
  
  output$model = renderPrint({
    
    model()
    
  })
  


})

