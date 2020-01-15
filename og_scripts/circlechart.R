# Get the name and the y position of each label
label_top20 <- top20
# calculate the ANGLE of the labels
number_of_bar <- nrow(label_top20)
angle <-  90 - 360 * (label_top20$id-0.5) /number_of_bar     # I substract 0.5 because the letter must have the angle of the center of the bars. Not extreme right(1) or extreme left (0)
# calculate the alignment of labels: right or left
# If I am on the left part of the plot, my labels have currently an angle < -90
label_top20$hjust<-ifelse( angle < -90, 1, 0)
# flip angle BY to make them readable
label_top20$angle<-ifelse(angle < -90, angle+180, angle)


p <- ggplot(top20, aes(x=as.factor(song), y=Total.Play)) +       # Note that id is a factor. If x is numeric, there is some space between the first bar
  
  # This add the bars with a blue color
  geom_col(aes(fill = artist)) +
  
  # Limits of the plot = very important. The negative value controls the size of the inner circle, the positive one is useful to add size over each bar
  ylim(0,50) +
  
  # Custom the theme: no axis title and no cartesian grid
  theme_minimal() +
  theme(
    axis.text = element_blank(),
    axis.title = element_blank(),
    panel.grid = element_blank(),
    plot.margin = unit(rep(-2,4), "cm")     # This remove unnecessary margin around plot
  ) +
  
  # This makes the coordinate polar instead of cartesian.
  coord_polar(start = 0) +
  geom_text(data=label_top20, aes(x=id, y=Total.Play+5, label=song, hjust=hjust), 
            color="black", fontface="bold",alpha=0.6, size=4, angle= label_top20$angle, inherit.aes = FALSE )
p
