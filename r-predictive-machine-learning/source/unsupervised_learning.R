## Original R learning-project source: association rules and clustering
library(arules)
data("Groceries")
summary(Groceries)

x <- Groceries[size(Groceries) > 25]
inspect(x)
itemFrequencyPlot(Groceries, support = 0.1, cex.names = 0.8)

basket_rules <- apriori(Groceries, parameter = list(sup = 0.003, conf = 0.5, target = "rules"))
summary(basket_rules)
inspect(head(sort(basket_rules, by = "lift")))
inspect(subset(basket_rules, size(basket_rules) > 4))
inspect(subset(basket_rules, lift > 5))

yogurt.rhs <- subset(basket_rules, subset = rhs %in% "yogurt" & lift > 3)
inspect(yogurt.rhs)
meat.lhs <- subset(basket_rules, subset = lhs %in% "meat" & lift > 1.5)
inspect(meat.lhs)

# Clustering
seed <- read.table("seeds_dataset.txt")
seed <- seed[, 1:7]
colnames(seed) <- c("area", "perimeter", "compactness", "length", "width", "asymmetry", "groovelength")
seed <- scale(seed)

set.seed(1)
fit <- kmeans(seed, 5)
table(fit$cluster)
library(fpc)
plotcluster(seed, fit$cluster)
fit$centers

# Elbow analysis
wss <- rep(0, 12)
for (i in 1:12) {
  wss[i] <- sum(kmeans(seed, centers = i)$withinss)
}
plot(1:12, wss, type = "b", xlab = "Number of Clusters", ylab = "Within group sum of squares")

# Three-cluster solution selected in the original exercise
set.seed(1)
fit1 <- kmeans(seed, 3)
table(fit1$cluster)
plotcluster(seed, fit1$cluster)
fit1$centers

# Hierarchical clustering
seed.dist <- dist(seed)
seed.hclust <- hclust(seed.dist)
plot(seed.hclust, ann = FALSE)
seed.3clust <- cutree(seed.hclust, k = 3)
rect.hclust(seed.hclust, k = 3)
aggregate(seed, by = list(seed.3clust), FUN = mean)
plotcluster(seed, seed.3clust)
