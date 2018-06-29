# Рисуем вафельный график через библиотеку ggplot2
# шаг-1 загружаем таблицу
MDF <- read.csv("Morphology.csv", header=TRUE, sep = ",")
MDF <- na.omit(MDF) 
row.has.na <- apply(MDF, 1, function(x){any(is.na(x))}) 
sum(row.has.na) 
head(MDF)


## шаг-2. Делаем таблицу и задаем данные Prep data (nothing to change here)
var <- MDF$aspect_class  # Это будет нашей категорией, здесь: класс аспекта разворота угла (8 сторон света) the categorical data 
nrows <- 10
df <- expand.grid(y = 1:nrows, x = 1:nrows) # задаем квадрат 10*10
categ_table <- round(table(var) * ((nrows*nrows)/(length(var)))) # задаем таблицу со значениями категорий
categ_table
df$category <- factor(rep(names(categ_table), categ_table)) # имена (для легенды)
# NOTE: if sum(categ_table) is not 100 (i.e. nrows^2), it will need adjustment to make the sum to 100.

## шаг-3. Теперь рисуем вафлю. Plot Waffle Chart
ggplot(df, aes(x = x, y = y, fill = category)) + 
        geom_tile(color = "black", size = 0.5) +
        scale_x_continuous(expand = c(0, 0)) +
        scale_y_continuous(expand = c(0, 0), trans = 'reverse') +
        scale_fill_brewer(palette = "Set3") +
        labs(title="Waffle Chart: Mariana Trench", subtitle="Aspect class of the basement angle",
             caption="Graphics: R")  + 
        theme( plot.title = element_text(size = rel(1.2)),
              axis.text = element_blank(),
              axis.title = element_blank(),
              axis.ticks = element_blank(),
              legend.title = element_blank(),
              legend.position = "right")