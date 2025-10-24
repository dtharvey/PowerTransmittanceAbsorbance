  set.seed(50)  
  epsilon = 0.9
  photons = 1000
  bins = 50
  photons0 = photons
  y = runif(photons, min = 0, max = 1)
  x = rep(0, photons)

  
  plot(x = x, y = y, pch = 19, col = "blue", cex = 0.1,
       xlim = c(0,1), xlab = "", ylab = "", bty = "n",
       ylim = c(0,1), asp = 1, xaxt = "n", yaxt = "n")
  lines(x = c(0,1), y = c(0,0), lwd = 2, col = "black")
  lines(x = c(1,1), y = c(0,1), lwd = 2, col = "black")
  lines(x = c(1,0), y = c(1,1), lwd = 2, col = "black")
  lines(x = c(0,0), y = c(1,0), lwd = 2, col = "black")
  
  # step though time
  remain = rep(photons,bins)
  for (i in 1:bins){
    photons = epsilon * photons
    y = runif(photons, min = 0, max = 1)
    x = rep(i/50, photons)
    points(x = x, y = y, pch = 19, col = "blue", cex = 0.1)
    remain[i] = round(photons,0)
  }
  plot(x = seq(0,bins), y = c(photons0,remain), 
       type = "p", pch = 19, col = "blue", cex = 0.25)

x = seq(0,10,1)
y1 = round(1000 * (0.95)^(x),0)
# y2 = 1000 * exp(-0.1 * x)
plot(x,y1, type = "p", col = "blue")  
# lines(x,y2, col = "red")
lm.1 = lm(log(y1) ~ x)
# lm.2 = lm(log(y2) ~ x)
plot(x = x, y = log(y1), type = "p", col = "blue")
abline(lm.1)
# lines(x = x, y = log(y2),  col = "red")
summary(lm.1)
# summary(lm.2)


d = seq(0,50)
P0 = 1000
P = round(1000 * (0.92)^(d),0)
model = nls(P~P0* exp(-k * d), start = list(P0 = 1000, k = 0.08))
summary(model)
plot(seq(0,1,0.02),y1, pch = 19, col = "blue")
calc = 9.999e2 * exp(-8.337e-2 * x)
lines(x = seq(0,1,0.02), y = calc)
