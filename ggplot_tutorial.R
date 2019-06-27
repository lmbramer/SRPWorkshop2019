# Setup
options(scipen=999)  # turn off scientific notation like 1e+06
library(ggplot2)
data("midwest", package = "ggplot2")  # load the data

# what is this data #
?midwest
dim(midwest)
head(midwest)
names(midwest)

# Init Ggplot
# any information that is part of the source dataframe has to be specified inside the aes() function
ggplot(midwest, aes(x=area, y=poptotal))  # area and poptotal are columns in 'midwest'

# Make a Simple Scatterplot
ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point()

# Like geom_point(), there are many such geom layers 
# let’s just add a smoothing layer using geom_smooth(method='lm') 

g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + 
  geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands

plot(g)

# The line of best fit is in blue. Can you find out what other method options are available for geom_smooth? (note: see ?geom_smooth). 
# You might have noticed that majority of points lie in the bottom of the chart which doesn’t really look nice. So, let’s change the Y-axis limits to focus on the lower half.

# The X and Y axis limits can be controlled in 2 ways.

# Method 1: By deleting the points outside the range
# This will change the lines of best fit or smoothing lines as compared to the original data.

# This can be done by xlim() and ylim(). You can pass a numeric vector of length 2 (with max and min values) or just the max and min values itself.

g <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point() + 
  geom_smooth(method="lm")  # set se=FALSE to turnoff confidence bands

# Delete the points outside the limits
g + xlim(c(0, 0.1)) + ylim(c(0, 1000000))   # deletes points
# g + xlim(0, 0.1) + ylim(0, 1000000)   # deletes points

# Method 2: Zooming In
# The other method is to change the X and Y axis limits by zooming in to the region of interest without deleting the points. This is done using coord_cartesian().

# Zoom in without deleting the points outside the limits. 
# As a result, the line of best fit is the same as the original plot.
g1 <- g + coord_cartesian(xlim=c(0,0.1), ylim=c(0, 1000000))  # zooms in
plot(g1)

# How to Change the Title and Axis Labels
# Add Title and Labels
g1 + labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# or

g1 + ggtitle("Area Vs Population", subtitle="From midwest dataset") + xlab("Area") + ylab("Population")

# How to Change the Color and Size of Points
# We can change the aesthetics of a geom layer by modifying the respective geoms. Let’s change the color of the points and the line to a static value.

ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(col="steelblue", size=3) +   # Set static color and size for points
  geom_smooth(method="lm", col="firebrick") +  # change the color of line
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# How to Change the Color To Reflect Categories in Another Column?
# Suppose if we want the color to change based on another column in the source dataset (midwest), it must be specified inside the aes() function.

gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

plot(gg)

# Now each point is colored based on the state it belongs because of aes(col=state). Not just color, but size, shape, stroke (thickness of boundary) and fill (fill color) can be used to discriminate groupings.

# As an added benefit, the legend is added automatically. If needed, it can be removed by setting the legend.position to None from within a theme() function.

gg + theme(legend.position="None")  # remove legend

# Also, You can change the color palette entirely.

gg + scale_colour_brewer(palette = "Set1")  # change color palette

# More of such palettes can be found in the RColorBrewer package
install.packages("RColorBrewer")
library(RColorBrewer)
head(brewer.pal.info, 10)  # show 10 palettes

# How to Change the X Axis Texts and Ticks Location
# Alright, now let’s see how to change the X and Y axis text and its location. This involves two aspects: breaks and labels.

# The breaks should be of the same scale as the X axis variable. Note that I am using scale_x_continuous because, the X axis variable is a continuous variable. Had it been a date variable, scale_x_date could be used. Like scale_x_continuous() an equivalent scale_y_continuous() is available for Y axis.

# Base plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Change breaks
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01))

# Step 2: Change the labels You can optionally change the labels at the axis ticks. labels take a vector of the same length as breaks.
# Let me demonstrate by setting the labels to alphabets from a to k (though there is no meaning to it in this context).

# Base Plot
gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Change breaks + label
gg + scale_x_continuous(breaks=seq(0, 0.1, 0.01), labels = letters[1:11])

# How to change axis labels in ggplot2

gg <- ggplot(midwest, aes(x=area, y=poptotal)) + 
  geom_point(aes(col=state), size=3) +  # Set color to vary based on state categories.
  geom_smooth(method="lm", col="firebrick", size=2) + 
  coord_cartesian(xlim=c(0, 0.1), ylim=c(0, 1000000)) + 
  labs(title="Area Vs Population", subtitle="From midwest dataset", y="Population", x="Area", caption="Midwest Demographics")

# Reverse X Axis Scale
gg + scale_x_reverse()

### other geoms

ggplot(data = midwest, aes(x = state, y = poptotal))+
  geom_boxplot()

# change scale of data 
ggplot(data = midwest, aes(x = state, y = poptotal))+
  geom_boxplot() +
  scale_y_continuous(trans = "log")

# plot number of counties per state in the dataset
ggplot(data = midwest, aes(x = state)) +
  geom_bar()
