

#####################################################################################
#  (0) TIMING: Start time capture
#####################################################################################
rm(list = ls());	options(scipen = 999); set.seed(12345)

start.time = Sys.time()
print(paste0("Start time: ", start.time))
#####################################################################################

#####################################################################################
#  (I) INPUT: Set the folder and some other instructions
#####################################################################################
#====================================================================================
# (A) File setup
MAIN.DIR = "/home/troy/CapRate/"
INPUT.FILE = "IN"
ID.VAR     = "superid"
Y.VAR      = "caprate"
VARS       = c("size","age","sell", 'latitude', 'longitude', 'effective_rent_per_uom_amt', 'bbbdev', 'bbb')

K.FOLDS    = 10
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# NEW range to determine distribution of errors
Q.RANGE    = c(0.20,0.33,0.66,0.80)
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# New heteroscedastic parameters

#====================================================================================
# (B) Variable definitions
PT.VAR     = "propertytype"
MSA.VAR    = "msa_code"
MIN.MSA    = 20
SPREAD.VAR = "bbb"
#====================================================================================
# (C) Weight setup
MIN.WEIGHT = 0
MAX.WEIGHT = 4
INC.WEIGHT = 1
#====================================================================================
# (D) Neighbors setup
MIN.NN     = 10
MAX.NN     = 40
INC.NN     = 10
#====================================================================================
#####################################################################################
#####################################################################################
#  (2) OUTPUT: Running functions and storing results
#####################################################################################
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# NEW: Add Q.RANGE to the function, both here and in the .txt in the headline
#!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
source(paste0(MAIN.DIR,"FILES/MOODYRESEARCH_WNN12_Alex2.txt"))
moody.pred = moodyResearch(MAIN.DIR,INPUT.FILE,Y.VAR,VARS,K.FOLDS,MIN.MSA,PT.VAR,MSA.VAR,ID.VAR,
                           SPREAD.VAR,MIN.WEIGHT,MAX.WEIGHT,INC.WEIGHT,MIN.NN,MAX.NN,INC.NN,Q.RANGE)


write.csv(moody.pred, file = paste0(MAIN.DIR,"weights_",Sys.Date(),".csv"))


# With these lines:
# if (!is.null(moody.pred$weights)) {
#   write.csv(moody.pred$weights, file = paste0(MAIN.DIR,"weights_",Sys.Date(),".csv"), row.names = FALSE)
# }

moody.pred

#####################################################################################
#  (3) TIMING: End time capture and duration calculation
#####################################################################################
end.time = Sys.time()
print(paste0("End time: ", end.time))
print(paste0("Total duration: ", difftime(end.time, start.time, units="mins"), " minutes"))
####################################################################################
# 


# # If you want to save other components as well, you can do:
# write.csv(moody.pred$results, file = paste0(MAIN.DIR,"results_",Sys.Date(),".csv"), row.names = FALSE)
# write.csv(moody.pred$residuals, file = paste0(MAIN.DIR,"residuals_",Sys.Date(),".csv"), row.names = FALSE)
# write.csv(moody.pred$summary, file = paste0(MAIN.DIR,"summary_",Sys.Date(),".csv"), row.names = FALSE)