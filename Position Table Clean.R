library(dplyr)

df<-read.csv('State_of_Iowa_Salary_Book.csv')
sum(df$Position=="")
df<-df[!(df$Position==""),]

cols <- c("Position","Department","Place.of.Residence")
tmpdf <- df[,cols]


positiondf<-group_by(tmpdf,Department,Position, Place.of.Residence)
positiondf<-summarise(positiondf)
positiondf$PositionID<- 1:nrow(positiondf)

write.csv(positiondf,file = "Position Table.csv")

employeedf<-read.csv('Employee.csv')
cols3<-c("EmployeeID", "Name","Gender")
employeedf<-employeedf[,cols3]
write.csv(employeedf,file = "employee.csv")

salarydf<-left_join(df,positiondf)
salarydf2<-left_join(salarydf, employeedf)

cols2<-c("Fiscal.Year","EmployeeID","PositionID","Total.Salary.Paid")
salarydf2<-salarydf2[,cols2]
salarydf2$SalaryID<-1:nrow(salarydf2)

write.csv2(salarydf2,file = "salary.csv")

