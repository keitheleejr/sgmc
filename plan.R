library("plan")
g <- new("gantt")
g <- ganttAddTask(g, "Build Project Folder", "2023-10-15", "2023-10-16", done=100)
g <- ganttAddTask(g, "Analysis") # no times, so a heading
g <- ganttAddTask(g, "Clean Data", "2023-10-16", "2023-10-17", done=10)
g <- ganttAddTask(g, "Add Levels to levels.R", "2023-10-16", "2023-10-17", done=50)
g <- ganttAddTask(g, "Functions", "2023-10-16", "2023-10-17", done=75)
g <- ganttAddTask(g, "EDA with ggplot2", "2023-10-18", "2023-10-22", done =0)
g <- ganttAddTask(g, "Report") # no times, so a heading
g <- ganttAddTask(g, "Shiny UI", "2023-10-16", "2023-10-19", done=60)
g <- ganttAddTask(g, "Shiny Server", "2023-10-19", "2023-10-22", done=75)
g <- ganttAddTask(g, "Report Outline with CHNA", "2023-10-23", "2023-10-25", done = 0)
g <- ganttAddTask(g, "Report Visualizations", "2023-10-25", "2023-10-27", done = 0)
g <- ganttAddTask(g, "Report Draft", "2023-10-27", "2023-10-30", done = 0)
font <- ifelse(is.na(g[["start"]]), 2, 1)


plot(g, ylabel=list(font=font),
     event.time="2023-10-16", event.label="Report Date")
par(lend="square") # default is round
# legend("topright", pch=22, pt.cex=2, pt.bg=gray(c(0.3, 0.9)),
#        border="black", xpd=NA,
#        legend=c("Completed", "Not Yet Done"), title="Project Plan", bg="white",
#        inset = c (-.075,-.5))

dev.print(png, file = "gantt_chart.png", width = 800, height = 600)

