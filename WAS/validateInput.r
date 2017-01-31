
# Validate the contents of the phenotype and trait of interest files
validateInput <- function(phenoIn, snpIn) {

	###
	### pheno file validation

	print(paste("Number of columns in phenotype file:", ncol(phenoIn),sep=""))
	print(paste("Number of columns in trait of interest file:", ncol(snpIn),sep=""))

	## check user id exists in pheno file
	idx1 = which(names(phenoIn) == opt$userId);
	if (length(idx1)==0) {
                stop(paste("phenotype file doesn't contain userID colunn:", opt$userId), call.=FALSE)
        }

	## confounder variables exist in pheno file
	idx = which(names(phenoIn) == "x21022_0_0");
	if (length(idx)==0) {
                stop("phenotype file doesn't contain required age colunn: x21022_0_0", call.=FALSE)
        }

	idx = which(names(phenoIn) == "x31_0_0");
        if (length(idx)==0) {
                stop("phenotype file doesn't contain required sex colunn: x31_0_0", call.=FALSE)
        }

	
	if (opt$genetic ==TRUE) {
		idx = which(names(phenoIn) == "x22000_0_0");
        	if (length(idx)==0) {
        	        stop("phenotype file doesn't contain required genetic batch colunn: x22000_0_0", call.=FALSE)
        	}	
	}

	## if running with sensitivity option then check extra columns exist in pheno file (genetic PCs and assessment centre)
	if (opt$sensitivity==TRUE) {

		if (opt$genetic ==TRUE) {
			## check first 10 genetic PCs exist
			for (i in 1:10) {
				idx = which(names(phenoIn) == paste("x22009_0_", i, sep=""));
				if (length(idx)==0) {
         			       stop(paste("phenotype file doesn't contain required genetic principal component colunn: x22000_0_", i, sep=""), call.=FALSE)
        			}
			}
		}

		## assessment centre field
		idx = which(names(phenoIn) == "x54_0_0");
        	if (length(idx)==0) {
        	        stop("phenotype file doesn't contain required assessment centre colunn: x54_0_0", call.=FALSE)
        	}
	}

	###
	### trait of interest file validation

	## check user id exists in snp file
	idx1 = which(names(snpIn) == opt$userId);
	if (length(idx1)==0) {
		stop(paste("Trait of interest file doesn't contain userID colunn:", opt$userId), call.=FALSE)
	}
	
	## check trait of interest exists in trait of interest file
	idx2 = which(names(snpIn) == opt$traitofinterest);
	if (length(idx2)==0) {
		stop(paste("Trait of interest file doesn't contain trait of interest variable column:", opt$traitofinterest), call.=FALSE)
	}


}
