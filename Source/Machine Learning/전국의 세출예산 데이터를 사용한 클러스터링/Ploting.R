# k = 5·Î k-means clustering 
data_k <- kmeans(data1, 5)
clust <- data_k$cluster
data_k_xy <- cbind(clust, data1[,c("means", "delta")])
data_k_xy <- transform(data_k_xy, clust=as.factor(clust))
# ÇÃ·ÔÀ¸·Î ³ªÅ¸³¿
library(ggplot2)
data_k_plot <- ggplot(data = data_k_xy, aes(x = means, y = delta, colour = clust)) + geom_point(shape = 19, size = 3)
data_k_plot