# #practice for lesson
# #episode 8 creating publication-quality graphics with ggplot2
# #software carpentry workshop
# #friday, february 22, 2019
# #sharon solis
# 
# #open ggplot2 library, we installed this morning
library("ggplot2")

#initiate new variable called gapminder, to read gapminder file in data folder
gapminder <- read.csv("data/gapminder_data.csv", header=TRUE)

#visually inspect gapminder

#data subsetting
#looking at row 1, column 1
gapminder[1,1]

#look at row 1
gapminder[1, ]

#preview top few lines
head(gapminder)

#preview bottom few lines
tail(gapminder)

#let's look at the middle
gapminder[900:905, ]



#call ggplot function to create new plot, GLOBAL option, applies 
#to ALL layers
#aes - aesthetic properties, x and y locations; looks for column 
#headings, nice!
#geom - this layer tells how we want to visually represent data 
#(geom_point - scatterplot)
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp)) + 
  geom_point()


#easy CHALLENGE 1
#modify the line below to show how life expectancy has changed 
#over time
ggplot(data = gapminder, aes(x = year, y = lifeExp)) + 
  geom_point()

#medium CHALLENGE 2
#aesthetic property of color
#modify code to color the points by continent column
#what trends do you see? are they what you expected?
ggplot(data = gapminder, aes(x = year, y = lifeExp, 
                             col = continent)) + geom_point()

###LAYERS
#scatterplot is hard to visualize change over time though
#line plot instead
#add geom_line layer instead of geom_point
#by aesthetic draws line for each country
ggplot(data = gapminder, aes( x=year, y=lifeExp, by=country, 
                              color = continent )) + geom_line()

# add column of countries as characters, instead of factors
countries_character <- as.character(gapminder$country)
gapminder2 <- cbind(gapminder,countries_character)

ggplot(data = gapminder2, aes( x=year, y=lifeExp, 
                               by=countries_character, 
                              color = continent )) + geom_line()
# plots came out the same for countries read as factors vs character

#try plot for line for each continent
ggplot(data = gapminder2, aes( x=year, y=lifeExp, 
                               color = continent )) + geom_line() +
  geom_point()

#try plotting year as factor here

#visualize both lines and points
#add another layer
#changed background
ggplot(data = gapminder, aes( x=year, y=lifeExp, by=country, 
                              color = continent )) + geom_line() +
  geom_point() + theme_bw()

#draw points on top of lines, black color for points
ggplot(data = gapminder, aes( x=year, y=lifeExp, by=country )) +
  geom_line(aes(color=continent)) + geom_point()

#TIP
#change color of all lines to blue
ggplot(data = gapminder, aes( x=year, y=lifeExp, by=country )) +
  geom_line(color="purple") + geom_point()

##easy CHALLENGE 3
#switch order of point and line layers from previous example.
#what happens?
ggplot(data = gapminder, aes( x=year, y=lifeExp, by=country )) +
 geom_point() +  geom_line(aes(color=continent))

#TRANSFORMATION AND STATISTICS
#overlay statistical models over data
#color by continent
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp, 
                             color=continent)) + geom_point()

#use scale function (change x axis), 
#using alpha function (transparency)
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp,
                             color = continent)) + 
  geom_point(alpha = 0.5) + scale_x_log10()

#geom_smooth, adding another layer here
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp,
                             color = continent)) + 
  geom_point(alpha = 0.5) + scale_x_log10() + 
  geom_smooth(method ="lm")

#make line thicker
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp,
                             color = continent)) + 
  geom_point(alpha = 0.5) + 
  scale_x_log10() + 
  geom_smooth(method ="lm", size=1.5)

#Challenge
#modify color and size of points on the point layer
#in the previous example
#hint do not use the aes function
ggplot(data = gapminder, aes(x = gdpPercap, y = lifeExp,
                             color = continent)) + 
  geom_point(alpha = 0.5, size=3, shape = 2) + 
  scale_x_log10() + 
  geom_smooth(method ="lm", size=1.5)

#try with a non-factor, color = countries_as_character
ggplot(data = gapminder2, aes(x = gdpPercap, y = lifeExp,
                             color = year)) + 
  geom_point(alpha = 0.5, size=3, shape = 2) + 
  scale_x_log10() + 
  geom_smooth(method ="lm", size=1.5)
