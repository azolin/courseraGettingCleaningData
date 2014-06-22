# load test set
X_test <- read.table(file = "X_test.txt")
Y_test <- read.table(file = "Y_test.txt")
# load training set
X_training <- read.table(file="X_train.txt")
Y_training <- read.table(file="Y_train.txt")
# add subjects
s_test <- read.table("subject_test.txt")
s_train <- read.table("subject_train.txt")
subject <- rbind(s_train,s_test)
colnames(subject) <- "Subject"

# merge Y with X
YX_test <- cbind(Y_test,X_test)
YX_training <- cbind(Y_training, X_training)
# merge dataframes
YX_all <- rbind(YX_training,YX_test)

# get feature names
fnames <- read.table("features.txt",sep = " ")[2]
#    scan them for mean() or std()
f_indices <- grep("mean[()]|std[()]",as.character(fnames$V2))
#    extract full names of these
f_name_ex <- as.character(fnames$V2)[f_indices]
#    add index 1 (for activity type)
f_indices = f_indices+1
f_indices <- append(1,f_indices)
#    add "activity type" as 1:
f_name_ex <- append("ActivityType",f_name_ex)
# prepare data frame for extraction from YX_all
f_names_df <- data.frame(f_indices,f_name_ex)

# make new data set with only means and stds
data_tidy <- YX_all[,f_names_df$f_indices]
colnames(data_tidy) <- f_names_df$f_name_ex
# --> replace activity names with proper names of these activites
anames <- read.table("activity_labels.txt")
ActivityTypeName <- as.character(anames$V2)[data_tidy$ActivityType]
data_tidy <- cbind(ActivityTypeName,data_tidy)
data_tidy$ActivityType <- NULL
write.table(data_tidy,file = "tidy_dataset_01.txt")

# make new data set for sums by subjects and by activity
#     add subjects
data_tidy2 <- cbind(subject,data_tidy)

data_tidy_agg <- aggregate(data_tidy2,list(ACTIVITY=data_tidy2$ActivityTypeName,SUBJECT=data_tidy2$Subject),mean)
data_tidy_agg$Subject <- NULL
data_tidy_agg$ActivityTypeName <- NULL
write.table(data_tidy_agg,file="tidy_dataset_aggregated.txt")