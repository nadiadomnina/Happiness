
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
    output$heat_map = renderPlotly({
        
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
                    title = "World Map: Happiness Scores"
                )+
                coord_map(xlim=c(-180,180))#+
           # coord_fixed(ratio = 1, xlim = c(-180, 180))
            
            
            
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
                )+
               coord_map(xlim=c(-180,180))
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
               )+
               coord_map(xlim=c(-180,180))
        }

        if(input$category == 4){
            map =  ggplot(world_shape) +
                geom_polygon(
                    mapping = aes(x = Longitude, y = Latitude, group = group,
                                  fill = as.numeric(Unemployment....of.labour.force.)),
                    color = "gray",
                    size = .1
                )+
                coord_map() + # use a map-based coordinate system
                scale_fill_gradient(low = "pink", high = "black",
                                    na.value = "white") +
                labs(
                    fill = "Unemployment Rate",
                    title = "World Map: Unemployment Rate"
                )+
                coord_map(xlim=c(-180,180))
            
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
                scale_fill_continuous(low = "white", high = "#AB82FF",
                                      na.value = "white") +
                labs(fill = "Percent of Corruption",
                     title = "Percent of Corruption in each Country, 2017")+
                coord_map(xlim=c(-180,180))
        }
 
     
        map = ggplotly(map, width = 1400, height = 790)
    })
    
#--------------------------------------------------------------------------------------------------------------  
#ALL THE DIFFERENT SCATTER PLOTS
    output$trust_plot <- renderPlot({
        ggplot(gov_trust_df,
               aes(x = Trust..Government.Corruption.,
                   y = Happiness.Score,
                   color = Happiness.Rank)) +
            geom_point(shape = 19, size = 5) +
            stat_smooth(method = "lm", col = "black") +
            theme_light() +
            scale_color_gradient("Happiness Rank",
                                 low = "purple", high = "black") +
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
            scale_color_gradient("Happiness Rank", low = "lightskyblue",
                                 high = "black", na.value = "white") +
            labs(x = "GDP per Capita",
                 y = "Happiness Score",
                 Title = "GDP vs Happiness Score Scatterplot")
    })
    
    output$health_plot <- renderPlot({
        ggplot(health_df, aes(x = Health..Life.Expectancy.,
                              y = Happiness.Score,
                              color = Happiness.Rank)) +
            geom_point(shape = 19, size = 5) +
            stat_smooth(method = "lm", col = "black") +
            theme_light() +
            scale_color_gradient("Happiness Rank", low = "orange",
                                 high = "black") +
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
                scale_color_gradient("Happiness Rank", low = "pink",
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
                scale_color_gradient("Happiness Rank", low = "pink",
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
                scale_color_gradient("Happiness Rank", low = "pink",
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
                scale_color_gradient("Happiness Rank", low = "pink",
                                     high = "black", na.value = "white") +
                labs(x = "Employed in Services",
                     y = "Happiness Score",
                     Title = "Services Employment vs Happiness Score Scatterplot")
        }
        
        plot
    })


    output$economy_r_squared = renderText({
        
        
        if(input$economy_choice == 1 ){
            text = paste(("R value:"),
                         employment1_r_squared)
        }
        if(input$economy_choice == 2 ){
            text = paste(("R value:"),
                         employment2_r_squared)
        }
        if(input$economy_choice == 3 ){
            text = paste(("R value:"),
                         employment3_r_squared)
        }
        if(input$economy_choice == 4 ){
            text = paste(("R value:"),
                         employment4_r_squared)
        }
        text
    })
    

    
    output$economy_analysis = renderText({
        
        if(input$economy_choice == 1 ){
            text =  ("This section explores the relationship between the percentage of people who are unemployed and happiness. 
            We had predicted that this would be a highly important correlation, but were extremely surprised
            to find that the R-squared value was only 0.03. This correaltion is so close to zero that it can be deemed as such, 
            showing that there isnt a direct correaltion between unemployment percentages and happiness of individuals around the world.")
        }
        
        if(input$economy_choice == 2 ){
            text = 
            ("This section explores the relationship between the percentage of people who are employed in agricultural work and happiness.
            This R-squared value showed the highest correaltion of all our economy research, 0.56. Thinking about it, this correaltion
            was to be expected, since a country that is full of agricultural workers is a country that probably lacks modern technology, 
            leaving people to fend for themselves with their bare hands")
        
                       
        }
        
        
        if(input$economy_choice == 3 ){
            text =("This section explores the relationship between the percentage of people who are employed in industry  and happiness.
                   We predicted that there would definetely be a correlation, relying on our knowledge that more developed countries have more industry
                   jobs, and thus must be happier. but we were wrong. The correaltion was only 0.19, showing that big industry isnt everything, especially
                   in terms of happiness.
                  ")
        }
        
        if(input$economy_choice == 4 ){
            text = ("For the percentage of the population employed in services, 
            we found the R-squared value of .58. This meant that countries who have more people employed in services
           have higher life satisfaction rates, making us question if this is the way the job market should be heading? 
")
        }
        text
    })
    
#--------------------------------------------------------------------------------------------------------------  
 
})

