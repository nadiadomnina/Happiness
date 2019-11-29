
library(shiny)
library(dplyr)
library(stringr)
library("knitr")
library(tidyr)
library(ggplot2)
library(maps)
library(leaflet)
library(ggpmisc)
library(plotly)
library(rworldmap)
library(fields)
library(mapproj)

source("analysis_2.R")

shinyServer(function(input, output) {

    
#PAGE ONE INTERACTIVITY
    output$heat_map = renderPlot({
        
        if(input$category == 1 ){
            
            map =  ggplot(world_shape) +
                    geom_polygon(
                        mapping = aes(x = Longitude, y = Latitude, group = group,
                                      fill = Happiness.Score),
                        color = "gray", # show country outlines
                        size = .1 # thinly stroked
                    ) +
                    coord_map() + # use a map-based coordinate system
                    scale_fill_gradient(low = "black", high = "greenyellow",
                                        na.value = "white") +
                    labs(
                        fill = "Happiness Score",
                        title = "World Map: of Happiness Scores"
                    )
        }
        
        if(input$category == 2){
           map =  ggplot(world_shape) +
                geom_polygon(
                    mapping = aes(x = Longitude, y = Latitude, group = group,
                                  fill = Economy..GDP.per.Capita.),
                    color = "gray", # show country outlines
                    size = .1 # thinly stroked
                ) +
                coord_map() + # use a map-based coordinate system
                scale_fill_gradient(low = "black", high = "lightskyblue",
                                    na.value = "white") +
                labs(
                    fill = "GDP Per Capita",
                    title = "World Map: GDP per Capita "
                )
        }
        
        if(input$category == 3){
           map =  ggplot(world_shape) +
                geom_polygon(
                    mapping = aes(x = Longitude, y = Latitude, group = group,
                                  fill = Health..Life.Expectancy.),
                    color = "gray",
                    size = .1
                    )+
               coord_map() + # use a map-based coordinate system
               scale_fill_gradient(low = "black", high = "orange",
                                   na.value = "white") +
               labs(
                   fill = "Life Expectancy",
                   title = "World Map: Life Expectancy "
               )
        }

        if(input$category == 4){
            #NEED TO MAKE A MAP
        }
        
        if(input$category == 5){
            map =  ggplot(world_shape) +
                geom_polygon(
                    mapping = aes(x = Longitude, y = Latitude, group = group,
                                  fill = Trust..Government.Corruption.),
                    color = "gray",
                    size = .1
                ) +
                coord_map() +
                scale_fill_continuous(low = "#431338", high = "431338",
                                      na.value = "white") +
                labs(fill = "Percent of Corruption",
                     title = "Percent of Corruption in each Country, 2017")
        }
 
        map
    })
    
#--------------------------------------------------------------------------------------------------------------  
#ALL THE DIFFERENT SCATTER PLOTS
    output$trust_plot <- renderPlot({
        ggplot(gov_trust_df,
               aes(x = Trust..Government.Corruption.,
                   y = Happiness.Score,
                   color = Freedom)) +
            geom_point(shape = 20, size = 4) +
            stat_smooth(method = "lm", col = "black") +
            theme_light() +
            scale_color_gradient("Degree of Country Freedom",
                                 low = "grey", high = "purple2") +
            labs(x = "Government Trust",
                 y = "Happiness Score",
                 Title = "Happiness Score vs. Gov. Trust Scatterplot")
    })
    
    output$gdp_plot <- renderPlot({
        ggplot(gdp_happy_df,
               aes(x = Economy..GDP.per.Capita.,
                   y = Happiness.Score,
                   color = Happiness.Rank)) +
            geom_point(shape = 19, size = 5) +
            stat_smooth(method = "lm", col = "black") +
            theme_light() +
            scale_color_gradient("Happiness Rank", low = "limegreen",
                                 high = "black", na.value = "white") +
            labs(x = "GDP per Capita",
                 y = "Happiness Score",
                 Title = "GDP vs Happiness Score Scatterplot")
    })
    
    output$health_plot <- renderPlot({
        ggplot(health_df, aes(x = Health..Life.Expectancy.,
                              y = Happiness.Score,
                              color = Happiness.Rank)) +
            geom_point(shape = 20, size = 5) +
            stat_smooth(method = "lm", col = "black") +
            theme_light() +
            scale_color_gradient("Happiness Rank", low = "yellow",
                                 high = "Red") +
            labs(x = "Health & Life Expectancy",
                 y = "Happiness Score",
                 Title = "Health & Life Expectancy vs Happiness Score Scatterplot")
    })
    
    
    
    output$world_happy_map <- renderPlot({
        ggplot(world_shape) +
            geom_polygon(
                mapping = aes(x = Longitude, y = Latitude, group = group,
                              fill = Happiness.Score),
                color = "gray", # show country outlines
                size = .1 # thinly stroked
            ) +
            coord_map() + # use a map-based coordinate system
            scale_fill_gradient(low = "black", high = "greenyellow",
                                na.value = "white") +
            labs(
                fill = "Happiness Score",
                title = "World Map: of Happiness Scores"
            )
    })
    
#--------------------------------------------------------------------------------------------------------------      
    
    
#ECONOMY PAGE INTERACTIVITY
    output$economy_plot = renderPlot({
        
        if(input$economy_choice == 1 ){
            plot = ggplot(employment_df,
                          aes(x = as.numeric(Unemployment....of.labour.force.),
                              y = Happiness.Score, color = Happiness.Rank,
                              na.rm = TRUE)) +
                geom_point(shape = 19, size = 5) +
                stat_smooth(method = "lm", col = "black") +
                theme_light() +
                scale_color_gradient("Happiness Rank", low = "limegreen",
                                     high = "black", na.value = "white") +
                # scale_x_discrete("Unemployed Labor Force", seq(-100, 100, 50),
                # seq(-100, 100, 50), c(-100, 100)) +
                labs(x = "Unemployed Labor Force",
                     y = "Happiness Score",
                     Title = "Unemployment Rate vs Happiness Score Scatterplot")
            
            
        }
        if(input$economy_choice == 2 ){
            plot = ggplot(employment_df, aes(x = Employment..Agriculture....of.employed.,
                                             y = Happiness.Score, color = Happiness.Rank,
                                             na.rm = TRUE)) +
                geom_point(shape = 19, size = 5) +
                stat_smooth(method = "lm", col = "black") +
                theme_light() +
                scale_color_gradient("Happiness Rank", low = "limegreen",
                                     high = "black", na.value = "white") +
                labs(x = "Employed in Agriculture",
                     y = "Happiness Score",
                     Title = "Agriculture Employment vs Happiness Score Scatterplot")
        }
        if(input$economy_choice == 3 ){
            plot = ggplot(employment_df, aes(x = Employment..Industry....of.employed.,
                                             y = Happiness.Score, color = Happiness.Rank,
                                             na.rm = TRUE)) +
                geom_point(shape = 19, size = 5) +
                stat_smooth(method = "lm", col = "black") +
                theme_light() +
                scale_color_gradient("Happiness Rank", low = "limegreen",
                                     high = "black", na.value = "white") +
                labs(x = "Employed in Industry",
                     y = "Happiness Score",
                     Title = "Industry Employment vs Happiness Score Scatterplot")
        }
        if(input$economy_choice == 4 ){
            plot =  ggplot(employment_df, aes(x = Employment..Services....of.employed.,
                                              y = Happiness.Score, color = Happiness.Rank,
                                              na.rm = TRUE)) +
                geom_point(shape = 19, size = 5) +
                stat_smooth(method = "lm", col = "black") +
                theme_light() +
                scale_color_gradient("Happiness Rank", low = "limegreen",
                                     high = "black", na.value = "white") +
                labs(x = "Employed in Services",
                     y = "Happiness Score",
                     Title = "Services Employment vs Happiness Score Scatterplot")
        }
        
        plot
    })

#--------------------------------------------------------------------------------------------------------------  
 
})

